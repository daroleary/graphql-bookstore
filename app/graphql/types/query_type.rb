module Types
  class QueryType < Types::BaseObject
    description "root query"

    field :authors, [AuthorType], null: true do
      description "gets all authors"
    end

    field :author, AuthorType, null: true do
      description "Find a author by id"
      argument :id, ID, required: true
    end

    field :book, BookType, null: true do
      description "Find a book by id"
      argument :id, ID, required: true
    end

    # GraphQL query: return all authors with name, and books with title
    # {
    #   authors {
    #     name
    #     books {
    #       title
    #     }
    #   }
    # }
    #
    def authors
      Author.all
    end

    # GraphQL query: return all author[1] with id, name, and associated books with title
    # {
    #   author(id: 1) {
    #     id
    #     name
    #     books {
    #       id
    #       title
    #     }
    #   }
    # }
    def author(id:)
      Author.find(id)
    end

    def books
      Book.all
    end

    def book(id:)
      Book.find(id)
    end
  end
end
