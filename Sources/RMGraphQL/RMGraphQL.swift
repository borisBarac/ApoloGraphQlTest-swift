import Foundation
import Apollo
import ApolloSQLite
import Api

public struct RMApi {
    let apolloClient: ApolloClient
    let logger: Logger

    public init(config: RMApiConfig) {
        self.logger = Logger(loggingLevel: config.loggingLevel)
        self.apolloClient = ApolloClient(url: config.endpont ?? rmApiEndpont  )
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
