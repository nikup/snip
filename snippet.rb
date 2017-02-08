require './database'
require './model'

class Snippet < Model
  ATTRIBUTES = [:short, :long_info]
end
__END__
  def self.fetch(id)
    new Database.fetch(:idea, id)
  end

  def self.delete(id)
    @@ideas.slice!(id.to_i)
    @@ideas_db.write(@@ideas)
  end

  def self.edit(params)
    id = params[:id].to_i
    @@ideas[id][:short] = params[:short]
    @@ideas[id][:long_info] = params[:long_info]
    @@ideas_db.write(@@ideas)
  end

  def self.ideas
    @@ideas
  end
end