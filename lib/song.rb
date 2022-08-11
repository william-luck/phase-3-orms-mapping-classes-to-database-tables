class Song

  attr_accessor :name, :album, :id

  # Set the id equal to nil because that will be the responsibility of the database.
  def initialize(name:, album:, id: nil)
    @name = name
    @album = album
    @id = id
  end

  # crafts an SQL statement, responsibility of the class, so class method
  def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS songs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        album TEXT
      )
      SQL
    DB[:conn].execute(sql)
  end

  # Usually a good idea not to include this method upon intialization, and to keep them separate. 
  def save
    sql = <<-SQL
      INSERT INTO songs (name, album)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.album)

    # Gets the song ID from the database, save it to the Ruby instance.
    self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]

    # returns Ruby instance
    self

  end

  def self.create(name:, album:)
    song = Song.new(name: name, album: album)
    song.save 
  end






end
