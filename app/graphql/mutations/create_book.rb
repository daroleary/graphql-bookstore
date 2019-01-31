# GraphQL: mutation - create book, specifying author_id (required), title and genre
# mutation createBook($author_id: ID!, $title: String, $genre: String) {
#   createBook(authorId: $author_id, title: $title, genre: $genre) {
#     book {
#       id
#       genre
#       title
#       authorId
#     }
#   }
# }
#
# GraphQL: query variables
# {
#   "author_id": 1, "title": "Harry potter", "genre": "Sci-fi"
# }
#
# {
#   "data": {
#     "createBook": {
#       "book": {
#         "id": "51",
#         "genre": "Sci-fi",
#         "title": "Harry potter",
#         "authorId": "1"
#       }
#     }
#   }
# }
class Mutations::CreateBook < Mutations::BaseMutation
  null true

  argument :author_id, ID, required: true
  argument :title, String, required: false
  argument :genre, String, required: false

  field :book, BookType, null: true
  field :errors, [String], null: false

  def resolve(author_id:, title:, genre:)
    book = Book.new(title: title, genre: genre, author_id: author_id)
    if book.save
      # Successful creation, return the created object with no errors
      {
          book: book,
          errors: [],
      }
    else
      # Failed save, return the errors to the client
      {
          book: nil,
          errors: book.errors.full_messages
      }
    end
  end
end
