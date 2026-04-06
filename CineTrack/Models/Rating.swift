public struct Rating: Decodable {
    var source: String
    var value: String
    
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
    
    init(source: String, value: String) {
        self.source = source
        self.value = value
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.source = try container.decode(String.self, forKey: .source)
        self.value = try container.decode(String.self, forKey: .value)
    }
}
