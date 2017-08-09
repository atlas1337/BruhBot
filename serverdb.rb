#!/usr/bin/env ruby
require 'sqlite3'

def dbSetup(server)
  db = SQLite3::Database.new "db/#{server}.db"

  # Create bandnames table
  db.execute <<-SQL
    create table if not exists bandnames (
      name text,
      genre text,
      addedby int,
      UNIQUE(name)
    );
  SQL

  query = [
    'ALTER TABLE bandnames ADD COLUMN name text, UNIQUE(name)',
    'ALTER TABLE bandnames ADD COLUMN genre text',
    'ALTER TABLE bandnames ADD COLUMN addedby text'
  ]
  query.each do |q|
    begin
      db.execute(q)
    rescue SQLite3::Exception
      next
    end
  end

  # Create currency table
  db.execute <<-SQL
    create table if not exists currency (
      userid int,
      amount int,
      UNIQUE(userid)
    );
  SQL


  query = [
    'ALTER TABLE currency ADD COLUMN userid int, UNIQUE(userid)',
    'ALTER TABLE currency ADD COLUMN amount int'
  ]
  query.each do |q|
    begin
      db.execute(q)
    rescue SQLite3::Exception
      next
    end
  end

  # Set up levels table
  db.execute <<-SQL
      create table if not exists levels (
        userid int,
        level int,
        xp int,
        UNIQUE(userid)
      );
  SQL

  query = [
    'ALTER TABLE levels ADD COLUMN userid int, UNIQUE(userid)',
    'ALTER TABLE levels ADD COLUMN level int',
    'ALTER TABLE levels ADD COLUMN xp int'
  ]
  query.each do |q|
    begin
      db.execute(q)
    rescue SQLite3::Exception
      next
    end
  end

  # Create quotes table
  db.execute <<-SQL
    create table if not exists quotes (
      quote text,
      UNIQUE(quote)
    );
  SQL

  query = [
    'ALTER TABLE quotes ADD COLUMN quote text, UNIQUE(quote)'
  ]
  query.each do |q|
    begin
      db.execute(q)
    rescue SQLite3::Exception
      next
    end
  end

  db.close if db
end
