require_relative('../db/sql_runner')

class Movie

  attr_accessor :title, :genre
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
  end

  def save()
    sql = "INSERT INTO movies
    (
      title, genre
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@title, @genre]
    user = SqlRunner.run( sql, values ).first
    @id = user['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM movies"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM movies"
    movies = SqlRunner.run(sql, [])
    result = movies.map { |movie| Casting.new( movie ) }
    return result
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM movies WHERE id = $1"
    values = [id]
    movie_hash = SqlRunner.run(sql,values).first()
    return nil if movie_hash == nil
    return Casting.new(movie_hash)
  end

  def update_by_id(id)
    sql = "UPDATE movies SET fee = $1 WHERE id = $2"
    values = [@fee, id]
    SqlRunner.run(sql,values)
  end

end
