import XCTest
@testable import RMGraphQL

final class RMApiTests: XCTestCase {
    var rmApi: RMApi!

    override func setUp() async throws {
        try await super.setUp()
        rmApi = makeSUT()
    }

    override func tearDown() async throws {
        try await super.tearDown()
    }

    #warning("SHOULD NOT RUN IN CI")
    func testRealApiConnection() async throws {
        let data = try? await rmApi.fetchAllDeadCharacters()
        XCTAssertNotNil(data, "Data is NULL")
    }

    // MARK: - Helpers
    func makeSUT() -> RMApi {
        return RMApi()
    }
}
