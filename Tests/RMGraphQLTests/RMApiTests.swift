import XCTest
@testable import RMGraphQL

final class RMApiTests: XCTestCase {
    var rmApi: RMApi!

    override func setUp() async throws {
        try await super.setUp()
    }

    override func tearDown() async throws {
        try await super.tearDown()
    }

    func testInit() throws {
        let config = RMApiConfig(endpont: rmApiEndpont, loggingLevel: .all, cashingStrategy: .inMemory)
        let api = try? RMApi(config: config)
        XCTAssertNotNil(api)
    }

    #warning("SHOULD NOT RUN IN CI")
    func testRealApiConnection() async throws {
        rmApi = makeLiveSUT()
        let data = try? await rmApi.fetchAllDeadCharacters()
        XCTAssertNotNil(data, "Data is NULL")
    }

    func testMockPass() async throws {
        rmApi = makeMockSUT(mockPass: true)
        let data = try? await rmApi.fetchAllDeadCharacters()
        XCTAssertNotNil(data, "Data is NULL")
    }

    func testMockFail() async throws {
        rmApi = makeMockSUT(mockPass: false)
        do {
            let _ = try await rmApi.fetchAllDeadCharacters()
        } catch(let error) {
            XCTAssertNotNil(error)
        }
    }

    // MARK: - Helpers
    func makeLiveSUT() -> RMApi {
        let config = RMApiConfig(endpont: rmApiEndpont,
                                 loggingLevel: .none,
                                 cashingStrategy: .inMemory)
        let api = try? RMApi(config: config)
        assert(api != nil, "COULD NOT MAKE SUT")
        return api!
    }

    func makeMockSUT(mockPass: Bool) -> RMApi {
        let mock = mockPass ? MockInterceptor.passMock : MockInterceptor.failMock
        let config = RMApiConfig(endpont: rmApiEndpont,
                                 loggingLevel: .none,
                                 cashingStrategy: .none,
                                 mockInterceptor: mock)
        let api = try? RMApi(config: config)

        assert(api != nil, "COULD NOT MAKE SUT")
        return api!
    }
}
