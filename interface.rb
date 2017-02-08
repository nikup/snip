require 'database'

snippets_db = Database.new 'snippets'

snippets = snippets_db.read()

snippets_db.write(snippets)


class Snippet
  def create(attributes)
    snippet = new(attributes)
    snippet.save
    snippet
  end

  def initialize(attributes)
  end
end



snippet = Snippet.create name: 'fdsfs', long_info: 'dfsdfsdfs'

snippet = Snippet.new name: 'fdsfs', long_info: 'dfsdfsdfs'
snippet.id # => nil
snippet.save
snippet.id # => 1

snippet = Snippet.fetch(id)
# nil
# {name: 'fdsfs', long_info: 'dfsdfsdfs'}
snippet.name # => 'fdsfs'
snippet.long_info # => 'dfsdfsdfs'

snippet.long_info = 'FFFFF'
snippet.save

Snippet.delete(id)
