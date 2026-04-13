//
//  ProductionViewModelTests.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 10/04/26.
//

import XCTest
import NetworkComponent
@testable import CineTrack

// MARK: - Mock Repository

final class MockProductionRepository: ProductionRepositoryProtocol {

    // MARK: Stubs
    var productionToReturn: Production?
    var listToReturn: [Production] = []
    var errorToThrow: Error?

    // MARK: Spies
    var fetchByIdCallCount = 0
    var fetchByTitleCallCount = 0
    var fetchListCallCount = 0
    var lastFetchedId: String?
    var lastFetchedTitle: String?
    var lastSearchTerm: String?

    func fetchById(_ id: String) async throws -> Production {
        fetchByIdCallCount += 1
        lastFetchedId = id
        if let error = errorToThrow { throw error }
        guard let production = productionToReturn else { throw FetchError.badResponseError }
        return production
    }

    func fetchByTitle(_ title: String) async throws -> Production {
        fetchByTitleCallCount += 1
        lastFetchedTitle = title
        if let error = errorToThrow { throw error }
        guard let production = productionToReturn else { throw FetchError.badResponseError }
        return production
    }

    func fetchList(searchTerm: String) async throws -> [Production] {
        fetchListCallCount += 1
        lastSearchTerm = searchTerm
        if let error = errorToThrow { throw error }
        return listToReturn
    }
}

// MARK: - Production Factory

let expected = Production(
    id: "tt9999999",
    title: "Inception",
    year: "2024",
    favorite: false,
    released: "01 Jan 2024",
    runtime: "120 min",
    genre: "Action",
    director: "Christopher Nolan",
    writer: nil,
    actors: "Leonardo DiCaprio",
    plot: "A thief who steals corporate secrets.",
    language: "English",
    country: "USA",
    poster: "https://poster.url/img.jpg",
    ratings: [],
    type: "movie"
)

// MARK: - Tests

final class ProductionViewModelTests: XCTestCase {

    // MARK: - Properties

    private var sut: ProductionViewModel!
    private var mockRepository: MockProductionRepository!

    // MARK: - Lifecycle

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockRepository = MockProductionRepository()
        sut = ProductionViewModel(repository: mockRepository)
    }

    override func tearDownWithError() throws {
        sut = nil
        mockRepository = nil
        try super.tearDownWithError()
    }

    // MARK: - fetchProductionById — Success

    func testFetchProductionById_WhenSuccess_SetsSelectedProduction() async {
        // Arrange (Given)
            mockRepository.productionToReturn = expected

        // Act (When)
        await sut.fetchProductionById("tt9999999")

        // Assert (Then)
        XCTAssertEqual(sut.selectedProduction?.id, expected.id)
    }

    func testFetchProductionById_WhenSuccess_CallsRepositoryExactlyOnce() async {
        // Arrange (Given)
        mockRepository.productionToReturn = expected

        // Act (When)
        await sut.fetchProductionById("tt1234567")

        // Assert (Then)
        XCTAssertEqual(mockRepository.fetchByIdCallCount, 1)
    }

    func testFetchProductionById_WhenSuccess_PassesCorrectIdToRepository() async {
        // Arrange (Given)
        mockRepository.productionToReturn = expected

        // Act (When)
        await sut.fetchProductionById("tt9876543")

        // Assert (Then)
        XCTAssertEqual(mockRepository.lastFetchedId, "tt9876543")
    }

    func testFetchProductionById_ResetsSelectedProductionBeforeFetching() async {
        // Arrange (Given)
        sut.selectedProduction = expected
        mockRepository.errorToThrow = FetchError.badResponseError

        // Act (When)
        await sut.fetchProductionById("tt0000000")

        // Assert (Then)
        XCTAssertNil(sut.selectedProduction)
    }

    // MARK: - fetchProductionById — Failure

    func testFetchProductionById_WhenFetchErrorThrown_SetsSelectedProductionToNil() async {
        // Arrange (Given)
        mockRepository.errorToThrow = FetchError.badResponseError

        // Act (When)
        await sut.fetchProductionById("tt0000000")

        // Assert (Then)
        XCTAssertNil(sut.selectedProduction)
    }

    func testFetchProductionById_WhenBadUrlErrorThrown_SetsSelectedProductionToNil() async {
        // Arrange (Given)
        mockRepository.errorToThrow = FetchError.badUrlError

        // Act (When)
        await sut.fetchProductionById("%%invalid%%")

        // Assert (Then)
        XCTAssertNil(sut.selectedProduction)
    }

    func testFetchProductionById_WhenUnexpectedErrorThrown_SetsSelectedProductionToNil() async {
        // Arrange (Given)
        mockRepository.errorToThrow = URLError(.timedOut)

        // Act (When)
        await sut.fetchProductionById("tt1234567")

        // Assert (Then)
        XCTAssertNil(sut.selectedProduction)
    }

    func testFetchProductionById_WhenErrorOccurs_DoesNotRetainPreviousSelection() async {
        // Arrange (Given)
        sut.selectedProduction = expected
        mockRepository.errorToThrow = FetchError.badResponseError

        // Act (When)
        await sut.fetchProductionById("tt0000000")

        // Assert (Then)
        XCTAssertNil(sut.selectedProduction)
    }

    // MARK: - fetchFeaturedProductions — Success

    func testFetchFeaturedProductions_WhenSuccess_SetsCorrectCount() async {
        // Arrange (Given)
        mockRepository.listToReturn = [expected, expected]

        // Act (When)
        await sut.fetchFeaturedProductions()

        // Assert (Then)
        XCTAssertEqual(sut.featuredProductions?.count, 2)
    }

    func testFetchFeaturedProductions_WhenSuccess_SetsCorrectFirstItemId() async {
        // Arrange (Given)
        mockRepository.listToReturn = [expected, expected]

        // Act (When)
        await sut.fetchFeaturedProductions()

        // Assert (Then)
        XCTAssertEqual(sut.featuredProductions?.first?.id, "tt9999999")
    }

    func testFetchFeaturedProductions_WhenSuccess_SetsCorrectLastItemId() async {
        // Arrange (Given)
        mockRepository.listToReturn = [expected, expected]

        // Act (When)
        await sut.fetchFeaturedProductions()

        // Assert (Then)
        XCTAssertEqual(sut.featuredProductions?.last?.id, "tt9999999")
    }

    func testFetchFeaturedProductions_WhenSuccess_CallsRepositoryExactlyOnce() async {
        // Arrange (Given) — sut already initialized with mockRepository

        // Act (When)
        await sut.fetchFeaturedProductions()

        // Assert (Then)
        XCTAssertEqual(mockRepository.fetchListCallCount, 1)
    }

    func testFetchFeaturedProductions_WhenReturnsEmptyList_SetsNotNil() async {
        // Arrange (Given)
        mockRepository.listToReturn = []

        // Act (When)
        await sut.fetchFeaturedProductions()

        // Assert (Then)
        XCTAssertNotNil(sut.featuredProductions)
    }

    func testFetchFeaturedProductions_WhenReturnsEmptyList_SetsEmptyArray() async {
        // Arrange (Given)
        mockRepository.listToReturn = []

        // Act (When)
        await sut.fetchFeaturedProductions()

        // Assert (Then)
        XCTAssertTrue(sut.featuredProductions?.isEmpty == true)
    }

    // MARK: - fetchFeaturedProductions — Failure

    func testFetchFeaturedProductions_WhenErrorAndNoPreviousData_SetsNotNil() async {
        // Arrange (Given)
        mockRepository.errorToThrow = FetchError.badResponseError

        // Act (When)
        await sut.fetchFeaturedProductions()

        // Assert (Then)
        XCTAssertNotNil(sut.featuredProductions)
    }

    func testFetchFeaturedProductions_WhenErrorAndNoPreviousData_SetsEmptyArray() async {
        // Arrange (Given)
        mockRepository.errorToThrow = FetchError.badResponseError

        // Act (When)
        await sut.fetchFeaturedProductions()

        // Assert (Then)
        XCTAssertTrue(sut.featuredProductions?.isEmpty == true)
    }

    func testFetchFeaturedProductions_WhenErrorWithPreviousData_KeepsPreviousCount() async {
        // Arrange (Given)
        sut.featuredProductions = [expected]
        mockRepository.errorToThrow = FetchError.badResponseError

        // Act (When)
        await sut.fetchFeaturedProductions()

        // Assert (Then)
        XCTAssertEqual(sut.featuredProductions?.count, 1)
    }

    func testFetchFeaturedProductions_WhenErrorWithPreviousData_KeepsPreviousItemId() async {
        // Arrange (Given)
        sut.featuredProductions = [expected]
        mockRepository.errorToThrow = FetchError.badResponseError

        // Act (When)
        await sut.fetchFeaturedProductions()

        // Assert (Then)
        XCTAssertEqual(sut.featuredProductions?.first?.id, "tt9999999")
    }

    func testFetchFeaturedProductions_WhenUnexpectedErrorWithNoPreviousData_SetsNotNil() async {
        // Arrange (Given)
        mockRepository.errorToThrow = URLError(.notConnectedToInternet)

        // Act (When)
        await sut.fetchFeaturedProductions()

        // Assert (Then)
        XCTAssertNotNil(sut.featuredProductions)
    }

    func testFetchFeaturedProductions_WhenUnexpectedErrorWithNoPreviousData_SetsEmptyArray() async {
        // Arrange (Given)
        mockRepository.errorToThrow = URLError(.notConnectedToInternet)

        // Act (When)
        await sut.fetchFeaturedProductions()

        // Assert (Then)
        XCTAssertTrue(sut.featuredProductions?.isEmpty == true)
    }

    // MARK: - fetchSearchResults — Success

    func testFetchSearchResults_WhenSuccess_SetsCorrectCount() async {
        // Arrange (Given)
        mockRepository.listToReturn = [expected, expected]

        // Act (When)
        await sut.fetchSearchResults(searchTerm: "batman")

        // Assert (Then)
        XCTAssertEqual(sut.searchResults?.count, 2)
    }

    func testFetchSearchResults_WhenSuccess_SetsCorrectFirstItemId() async {
        // Arrange (Given)
        mockRepository.listToReturn = [expected, expected]

        // Act (When)
        await sut.fetchSearchResults(searchTerm: "batman")

        // Assert (Then)
        XCTAssertEqual(sut.searchResults?.first?.id, "tt9999999")
    }

    func testFetchSearchResults_PassesCorrectSearchTermToRepository() async {
        // Arrange (Given) — sut already initialized with mockRepository

        // Act (When)
        await sut.fetchSearchResults(searchTerm: "interstellar")

        // Assert (Then)
        XCTAssertEqual(mockRepository.lastSearchTerm, "interstellar")
    }

    func testFetchSearchResults_WhenSuccess_CallsRepositoryExactlyOnce() async {
        // Arrange (Given) — sut already initialized with mockRepository

        // Act (When)
        await sut.fetchSearchResults(searchTerm: "test")

        // Assert (Then)
        XCTAssertEqual(mockRepository.fetchListCallCount, 1)
    }

    func testFetchSearchResults_WhenReturnsEmptyList_SetsNotNil() async {
        // Arrange (Given)
        mockRepository.listToReturn = []

        // Act (When)
        await sut.fetchSearchResults(searchTerm: "xyzunknownmovie")

        // Assert (Then)
        XCTAssertNotNil(sut.searchResults)
    }

    func testFetchSearchResults_WhenReturnsEmptyList_SetsEmptyArray() async {
        // Arrange (Given)
        mockRepository.listToReturn = []

        // Act (When)
        await sut.fetchSearchResults(searchTerm: "xyzunknownmovie")

        // Assert (Then)
        XCTAssertTrue(sut.searchResults?.isEmpty == true)
    }

    // MARK: - fetchSearchResults — Failure

    func testFetchSearchResults_WhenFetchErrorThrown_SetsNotNil() async {
        // Arrange (Given)
        mockRepository.errorToThrow = FetchError.badResponseError

        // Act (When)
        await sut.fetchSearchResults(searchTerm: "batman")

        // Assert (Then)
        XCTAssertNotNil(sut.searchResults)
    }

    func testFetchSearchResults_WhenFetchErrorThrown_SetsEmptyArray() async {
        // Arrange (Given)
        mockRepository.errorToThrow = FetchError.badResponseError

        // Act (When)
        await sut.fetchSearchResults(searchTerm: "batman")

        // Assert (Then)
        XCTAssertTrue(sut.searchResults?.isEmpty == true)
    }

    func testFetchSearchResults_WhenUnexpectedErrorThrown_SetsNotNil() async {
        // Arrange (Given)
        mockRepository.errorToThrow = URLError(.timedOut)

        // Act (When)
        await sut.fetchSearchResults(searchTerm: "batman")

        // Assert (Then)
        XCTAssertNotNil(sut.searchResults)
    }

    func testFetchSearchResults_WhenUnexpectedErrorThrown_SetsEmptyArray() async {
        // Arrange (Given)
        mockRepository.errorToThrow = URLError(.timedOut)

        // Act (When)
        await sut.fetchSearchResults(searchTerm: "batman")

        // Assert (Then)
        XCTAssertTrue(sut.searchResults?.isEmpty == true)
    }

    func testFetchSearchResults_WhenErrorOccurs_DoesNotRetainPreviousResults() async {
        // Arrange (Given)
        sut.searchResults = [expected]
        mockRepository.errorToThrow = FetchError.badResponseError

        // Act (When)
        await sut.fetchSearchResults(searchTerm: "new query")

        // Assert (Then)
        XCTAssertTrue(sut.searchResults?.isEmpty == true)
    }

    // MARK: - Initial State

    func testInitialState_AllPropertiesAreNil() {
        let freshViewModel = ProductionViewModel(repository: mockRepository)

        XCTAssertNil(freshViewModel.featuredProductions)
        XCTAssertNil(freshViewModel.searchResults)
        XCTAssertNil(freshViewModel.selectedProduction)
    }
}
