import XCTest
@testable import RMGraphQL

final class AuthInterceptorTests: XCTestCase {
    var rmApi: RMApi!

    #warning("SHOULD NOT RUN IN CI")
    func test() async throws {
        let exp = expectation(description: "AuthInterceptor expectation")

        let config = RMApiConfig(endpont: rmApiEndpont, loggingLevel: .all, cashingStrategy: .inMemory)
        let authBlock: ((URLRequest) -> URLRequest)? = { req in
            exp.fulfill()
            return req
        }

        let rmApi = try RMApi(config: config, authBlock: authBlock)
        _ = try await rmApi.fetchAllDeadCharacters()

        await waitForExpectations(timeout: 5)
    }


}
