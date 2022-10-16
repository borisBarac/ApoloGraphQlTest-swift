import Foundation
import Apollo
import Api

public struct RMApi {
    let apolloClient: ApolloClient

    public init() {
        self.apolloClient = ApolloClient(url: rmApiEndpont)
    }

    public func fetchAllDeadCharacters() async throws -> GraphQLResult<DeadCharactersQuery.Data> {
        do {
            return try await withCheckedThrowingContinuation { continuation in
                apolloClient.fetch(query: DeadCharactersQuery()) { result in
                    switch result {
                    case .success(let data):
                        continuation.resume(returning: data)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }

        } catch {
            throw RMError.asyncConvertionFailed
        }


    }

}
