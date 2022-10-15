// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import Api

public class Query: MockObject {
  public static let objectType: Object = Api.Objects.Query
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Query>>

  public struct MockFields {
    @Field<Characters>("DeadCharacters") public var DeadCharacters
    @Field<Character>("character") public var character
  }
}

public extension Mock where O == Query {
  convenience init(
    DeadCharacters: Mock<Characters>? = nil,
    character: Mock<Character>? = nil
  ) {
    self.init()
    self.DeadCharacters = DeadCharacters
    self.character = character
  }
}
