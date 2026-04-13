//
//  FetchServicePackageTests.swift
//  NetworkComponent
//
//  Created by Ryan Davi Oliveira de Meneses on 13/04/26.
//

import XCTest
@testable import NetworkComponent

// MARK: - Mock URL Protocol

final class MockURLProtocol: URLProtocol {

    // MARK: Stubs
    
    nonisolated(unsafe) static var dataToReturn: Data?
    nonisolated(unsafe) static var responseToReturn: HTTPURLResponse?
    nonisolated(unsafe) static var errorToThrow: Error?

    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        if let error = MockURLProtocol.errorToThrow {
            client?.urlProtocol(self, didFailWithError: error)
            return
        }
        if let response = MockURLProtocol.responseToReturn {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        if let data = MockURLProtocol.dataToReturn {
            client?.urlProtocol(self, didLoad: data)
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}

// MARK: - Helpers

private struct MockDecodable: Codable, Equatable {
    let name: String
}

private extension HTTPURLResponse {
    static func make(statusCode: Int, url: URL = URL(string: "https://example.com")!) -> HTTPURLResponse {
        HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}

// MARK: - Tests

final class FetchServicePackageTests: XCTestCase {
    
    // MARK: - Properties

    private var sut: FetchServicePackage!
    private var mockSession: URLSession!
    private let testURL = URL(string: "https://example.com/test")!
    
    // MARK: - Lifecycle

    override func setUpWithError() throws {
        try super.setUpWithError()

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        mockSession = URLSession(configuration: configuration)
        sut = FetchServicePackage(session: mockSession)

        MockURLProtocol.dataToReturn = nil
        MockURLProtocol.responseToReturn = nil
        MockURLProtocol.errorToThrow = nil
    }

    override func tearDownWithError() throws {
        sut = nil
        mockSession = nil
        MockURLProtocol.dataToReturn = nil
        MockURLProtocol.responseToReturn = nil
        MockURLProtocol.errorToThrow = nil
        try super.tearDownWithError()
    }
    
    // MARK: - fetch — Success

    func testFetch_WhenResponseIs200AndValidData_ReturnsDecodedObject() async throws {
        // Arrange (Given)
        let expectedData = try JSONEncoder().encode(MockDecodable(name: "Inception"))
        MockURLProtocol.dataToReturn = expectedData
        MockURLProtocol.responseToReturn = .make(statusCode: 200)

        // Act (When)
        let result = try await sut.fetch(MockDecodable.self, from: testURL)

        // Assert (Then)
        XCTAssertEqual(result.name, "Inception")
    }
    
    func testFetch_WhenResponseIs200AndValidData_DoesNotThrow() async {
        // Arrange (Given)
        let data = try? JSONEncoder().encode(MockDecodable(name: "Inception"))
        MockURLProtocol.dataToReturn = data
        MockURLProtocol.responseToReturn = .make(statusCode: 200)

        // Act (When) + Assert (Then)
        await XCTAssertNoThrowAsync(try await sut.fetch(MockDecodable.self, from: testURL))
    }
    
    // MARK: - fetch — Bad Response

    func testFetch_WhenResponseIs404_ThrowsBadResponseError() async {
        // Arrange (Given)
        MockURLProtocol.dataToReturn = Data()
        MockURLProtocol.responseToReturn = .make(statusCode: 404)

        // Act (When) + Assert (Then)
        await XCTAssertThrowsErrorAsync(try await sut.fetch(MockDecodable.self, from: testURL)) { error in
            XCTAssertEqual(error as? FetchError, .badResponseError)
        }
    }
    
    func testFetch_WhenResponseIs500_ThrowsBadResponseError() async {
        // Arrange (Given)
        MockURLProtocol.dataToReturn = Data()
        MockURLProtocol.responseToReturn = .make(statusCode: 500)

        // Act (When) + Assert (Then)
        await XCTAssertThrowsErrorAsync(try await sut.fetch(MockDecodable.self, from: testURL)) { error in
            XCTAssertEqual(error as? FetchError, .badResponseError)
        }
    }
    
    func testFetch_WhenResponseIs401_ThrowsBadResponseError() async {
        // Arrange (Given)
        MockURLProtocol.dataToReturn = Data()
        MockURLProtocol.responseToReturn = .make(statusCode: 401)

        // Act (When) + Assert (Then)
        await XCTAssertThrowsErrorAsync(try await sut.fetch(MockDecodable.self, from: testURL)) { error in
            XCTAssertEqual(error as? FetchError, .badResponseError)
        }
    }
    
    // MARK: - fetch — Bad Data

    func testFetch_WhenNetworkFails_ThrowsBadDataError() async {
        // Arrange (Given)
        MockURLProtocol.errorToThrow = URLError(.notConnectedToInternet)

        // Act (When) + Assert (Then)
        await XCTAssertThrowsErrorAsync(try await sut.fetch(MockDecodable.self, from: testURL)) { error in
            XCTAssertEqual(error as? FetchError, .badDataError)
        }
    }

    func testFetch_WhenRequestTimesOut_ThrowsBadDataError() async {
        // Arrange (Given)
        MockURLProtocol.errorToThrow = URLError(.timedOut)

        // Act (When) + Assert (Then)
        await XCTAssertThrowsErrorAsync(try await sut.fetch(MockDecodable.self, from: testURL)) { error in
            XCTAssertEqual(error as? FetchError, .badDataError)
        }
    }
    
    // MARK: - fetch — Decoding Error

    func testFetch_WhenDataIsMalformed_ThrowsDecodingError() async {
        // Arrange (Given)
        MockURLProtocol.dataToReturn = Data("invalid json".utf8)
        MockURLProtocol.responseToReturn = .make(statusCode: 200)

        // Act (When) + Assert (Then)
        await XCTAssertThrowsErrorAsync(try await sut.fetch(MockDecodable.self, from: testURL)) { error in
            XCTAssertEqual(error as? FetchError, .decodingError)
        }
    }

    func testFetch_WhenDataIsEmpty_ThrowsDecodingError() async {
        // Arrange (Given)
        MockURLProtocol.dataToReturn = Data()
        MockURLProtocol.responseToReturn = .make(statusCode: 200)

        // Act (When) + Assert (Then)
        await XCTAssertThrowsErrorAsync(try await sut.fetch(MockDecodable.self, from: testURL)) { error in
            XCTAssertEqual(error as? FetchError, .decodingError)
        }
    }
    
    func testFetch_WhenDataHasWrongSchema_ThrowsDecodingError() async {
        // Arrange (Given)
        let wrongData = try? JSONEncoder().encode(["unexpectedKey": "unexpectedValue"])
        MockURLProtocol.dataToReturn = wrongData
        MockURLProtocol.responseToReturn = .make(statusCode: 200)

        // Act (When) + Assert (Then)
        await XCTAssertThrowsErrorAsync(try await sut.fetch(MockDecodable.self, from: testURL)) { error in
            XCTAssertEqual(error as? FetchError, .decodingError)
        }
    }
    
    // MARK: - Async XCTest Helpers

    func XCTAssertNoThrowAsync<T>(
        _ expression: @autoclosure () async throws -> T,
        _ message: String = "",
        file: StaticString = #filePath,
        line: UInt = #line
    ) async {
        do {
            _ = try await expression()
        } catch {
            XCTFail("Expected no error but got \(error). \(message)", file: file, line: line)
        }
    }

    func XCTAssertThrowsErrorAsync<T>(
        _ expression: @autoclosure () async throws -> T,
        _ message: String = "",
        file: StaticString = #filePath,
        line: UInt = #line,
        _ errorHandler: (Error) -> Void = { _ in }
    ) async {
        do {
            _ = try await expression()
            XCTFail("Expected error to be thrown. \(message)", file: file, line: line)
        } catch {
            errorHandler(error)
        }
    }
    
}
