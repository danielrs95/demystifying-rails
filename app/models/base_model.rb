class BaseModel
  attr_reader :errors

  def new_record?
    @id.blank?
  end

  def save
    return false unless valid?

    if new_record?
      insert
    else
      update
    end
    true
  end

  # Get the table name string
  def self.table_name
    to_s.pluralize.downcase
  end

  def self.all
    # rename all the variables

    record_hashes = connection.execute("SELECT * FROM #{table_name}")
    record_hashes.map do |record|
      # Can omit classes and call new
      # This is a class method, if we call new
      # It will be called on the class it lives in
      new(record)
    end
  end

  def destroy
    query_string = "DELETE FROM #{self.class.table_name} WHERE #{self.class.table_name}.id = ?"
    connection.execute query_string, id
  end

  def self.find(id)
    query_string = "SELECT * FROM #{table_name} WHERE #{table_name}.id = ? LIMIT 1"
    record_hash = connection.execute(query_string, id).first
    new(record_hash)
  end

  def self.connection
    db_connection = SQLite3::Database.new('db/development.sqlite3')
    db_connection.results_as_hash = true
    db_connection
  end

  def connection
    self.class.connection
  end
end
