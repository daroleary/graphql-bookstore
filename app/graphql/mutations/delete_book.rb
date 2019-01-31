# GraphQL mutation: delete book, specifying ID required
# mutation deleteBook($id: ID!) {
#   deleteBook(id: $id) {
#     book {
#       id
#       authorId
#       title
#       genre
#     }
#   }
# }
#
# GraphQL: query variables
# {
#   "id": 1
# }
#
# GraphQL: response
# {
#   "data": {
#     "deleteBook": {
#       "book": {
#         "id": "1",
#         "authorId": "1",
#         "title": "Harry potter 2",
#         "genre": "fiction"
#       }
#     }
#   }
# }
class Mutations::DeleteBook < Mutations::BaseMutation
  null true

  argument :id, ID, required: true

  field :book, BookType, null: true
  field :errors, [String], null: false

  def resolve(id:)
    book = Book.find(id)
    book.destroy
    {
        book: book,
        errors: []
    }
  end
end
