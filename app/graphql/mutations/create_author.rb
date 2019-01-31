# GraphQL: mutation - create author, specifying name and age
# mutation createAuthor($name: String!, $age: Int) {
#   createAuthor(name: $name, age: $age) {
#     author {
#       id
#       name
#       age
#     }
#   }
# }
#
# GraphQL: query variables
# {
#   "name": "Taylor Wu", "age": 24
# }
#
# GraphQL: response
# {
#   "data": {
#     "createAuthor": {
#       "author": {
#         "id": "12",
#         "name": "Taylor Wu",
#         "age": 24
#       }
#     }
#   }
# }
class Mutations::CreateAuthor < Mutations::BaseMutation
  null true

  argument :name, String, required: true
  argument :age, Integer, required: false

  field :author, AuthorType, null: true
  field :errors, [String], null: false

  def resolve(name:, age:)
    author = Author.new(name: name, age: age)
    if author.save
      # Successful creation, return the created object with no errors
      {
        author: author,
        errors: [],
      }
    else
      # Failed save, return the errors to the client
      {
        author: nil,
        errors: author.errors.full_messages
      }
    end
  end
end
