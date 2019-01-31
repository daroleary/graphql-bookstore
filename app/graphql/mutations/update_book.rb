# GraphQL mutation: update book, specifying ID required, name, and genre
# mutation updateBook($id: ID!, $title: String, $genre: String) {
#   updateBook(id: $id, title: $title, genre: $genre) {
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
#   "id": 1, "title": "Harry potter 2", "genre": "fiction"
# }
#
# GraphQL: response
# {
#   "data": {
#     "updateBook": {
#       "book": {
#         "id": "1",
#         "authorId": "1",
#         "title": "Harry potter 2",
#         "genre": "fiction"
#       }
#     }
#   }
# }
class Mutations::UpdateBook < Mutations::BaseMutation
  null true

  argument :id, ID, required: true
  argument :title, String, required: false
  argument :genre, String, required: false

  field :book, BookType, null: true
  field :errors, [String], null: false

  def resolve(id:, title:, genre:)
    book = Book.find(id)
    if book.update(title: title, genre: genre)
      # Successful update, return the created object with no errors
      {
          book: book,
          errors: [],
      }
    else
      # Failed update, return the errors to the client
      {
          book: nil,
          errors: book.errors.full_messages
      }
    end
  end
end
