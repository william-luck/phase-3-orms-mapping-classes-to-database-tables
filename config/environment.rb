require 'bundler'
Bundler.require

require_relative '../lib/song'

# All this line is doing is setting up a constant that is eqeula to a hash that contains the connection to the database.
# Can access the constant and teh connection through DB[:conn]
DB = { conn: SQLite3::Database.new("db/music.db") }
