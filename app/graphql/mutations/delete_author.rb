# GraphQL mutation: delete author, specifying ID required
# mutation deleteAuthor($id:ID!) {
#   deleteAuthor(id:$id) {
#     author {
#       name
#       id
#     }
#   }
# }
#
# GraphQL: query variables
# {
#   "id": 12
# }
#
# GraphQL: response
# {
#   "data": {
#     "deleteAuthor": {
#       "author": {
#         "name": "Taylor Wu",
#         "id": "12"
#       }
#     }
#   }
# }
class Mutations::DeleteAuthor < Mutations::BaseMutation
  null true

  argument :id, ID, required: true

  field :author, AuthorType, null: true
  field :errors, [String], null: false

  def resolve(id:)
    author = Author.find(id)
    author.destroy

    {
        author: author,
        errors: []
    }
  end
end
