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

  def self.connection
    db_connection = SQLite3::Database.new('db/development.sqlite3')
    db_connection.results_as_hash = true
    db_connection
  end

  def connection
    self.class.connection
  end
end
