// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI
@_exported import enum ApolloAPI.GraphQLEnum
@_exported import enum ApolloAPI.GraphQLNullable
import Api

public class DeadCharactersQuery: GraphQLQuery {
  public static let operationName: String = "DeadCharacters"
  public static let document: DocumentType = .notPersisted(
    definition: .init(
      """
      query DeadCharacters {
        DeadCharacters: characters(filter: {status: "dead"}) {
          __typename
          results {
            __typename
            ...characterFields
          }
        }
      }
      """,
      fragments: [CharacterFields.self]
    ))

  public init() {}

  public struct Data: Api.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ParentType { Api.Objects.Query }
    public static var __selections: [Selection] { [
      .field("characters", alias: "DeadCharacters", DeadCharacters?.self, arguments: ["filter": ["status": "dead"]]),
    ] }

    /// Get the list of all characters
    public var deadCharacters: DeadCharacters? { __data["DeadCharacters"] }

    /// DeadCharacters
    ///
    /// Parent Type: `Characters`
    public struct DeadCharacters: Api.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ParentType { Api.Objects.Characters }
      public static var __selections: [Selection] { [
        .field("results", [Result?]?.self),
      ] }

      public var results: [Result?]? { __data["results"] }

      /// DeadCharacters.Result
      ///
      /// Parent Type: `Character`
      public struct Result: Api.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ParentType { Api.Objects.Character }
        public static var __selections: [Selection] { [
          .fragment(CharacterFields.self),
        ] }

        /// The name of the character.
        public var name: String? { __data["name"] }
        /// The status of the character ('Alive', 'Dead' or 'unknown').
        public var status: String? { __data["status"] }
        /// The type or subspecies of the character.
        public var type: String? { __data["type"] }
        /// Link to the character's image.
        /// All images are 300x300px and most are medium shots or portraits since they are intended to be used as avatars.
        public var image: String? { __data["image"] }
        /// The id of the character.
        public var id: Api.ID? { __data["id"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(data: DataDict) { __data = data }

          public var characterFields: CharacterFields { _toFragment() }
        }
      }
    }
  }
}
