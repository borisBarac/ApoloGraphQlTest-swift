import XCTest
@testable import RMGraphQL

final class AuthInterceptorTests: XCTestCase {
    var rmApi: RMApi!

    func testAuthBockCalled() async throws {
        let exp = expectation(description: "AuthInterceptor expectation")

        let config = RMApiConfig(endpont: rmApiEndpont,
                                 loggingLevel: .none,
                                 cashingStrategy: .none,
                                 mockInterceptor: MockInterceptor.passMock)
        let authBlock: AuthBlockType? = { _ in
            exp.fulfill()
        }

        let rmApi = try RMApi(config: config, authBlock: authBlock)
        _ = try await rmApi.fetchAllDeadCharacters()

        await waitForExpectations(timeout: 3)
    }

}
