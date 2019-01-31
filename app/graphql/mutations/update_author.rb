# GraphQL mutation: update author, specifying ID required, name required, and age optional
# mutation updateAuthor($id: ID!, $name: String!, $age: Int) {
#   updateAuthor(id: $id, name: $name, age: $age) {
#     author {
#       name
#       id
#       age
#     }
#   }
# }
# GraphQL: query variables
# {
#   "name": "Taylor Wu", "age": 24, "id": 12
# }
#
# GraphQL: response
# {
#   "data": {
#     "updateAuthor": {
#       "author": {
#         "name": "Taylor Wu",
#         "id": "12",
#         "age": 24
#       }
#     }
#   }
# }
class Mutations::UpdateAuthor < Mutations::BaseMutation
  null true

  argument :id, ID, required: true
  argument :name, String, required: true
  argument :age, Integer, required: false

  field :author, AuthorType, null: true
  field :errors, [String], null: true

  def resolve(id:, name:, age:)
    author = Author.find(id)
    if author.update(name: name, age: age)
      # Successful update, return the created object with no errors
      {
          author: author,
          errors: [],
      }
    else
      # Failed update, return the errors to the client
      {
          author: nil,
          errors: author.errors.full_messages
      }
    end
  end
end
