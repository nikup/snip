class Database

  def self.read(file_name)
    return YAML.load_file(file_name) || {}
  end

  def self.write(file_name, records)
    File.open(file_name, 'w') do |out|
      YAML.dump(records, out)
    end
  end

  def self.create(file_name, attributes)
    records = read file_name
    max_key = records.keys.max_by { |key| key.to_i } || 0
    id = max_key + 1

    attributes[:id] = id
    records[id] = attributes
    write file_name, records
    id
  end

  def self.update(file_name, attributes)
    records = read file_name
    records[attributes[:id]] = attributes
    write file_name, records
    records
  end

  def  self.fetch(file_name, id)
    records = read file_name
    records[id]
    #return hash
  end
end