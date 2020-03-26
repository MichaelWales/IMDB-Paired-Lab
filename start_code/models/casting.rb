require_relative('../db/sql_runner')

class Casting

  attr_accessor :fee
  attr_reader :movie_id, :star_id, :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @movie_id = options['movie_id'].to_i
    @star_id = options['star_id'].to_i
    @fee = options['fee'].to_i
  end

  def save()
    sql = "INSERT INTO castings
    (
      movie_id, star_id, fee
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@movie_id, @star_id, @fee]
    user = SqlRunner.run( sql, values ).first
    @id = user['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM castings"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM castings"
    castings = SqlRunner.run(sql, [])
    result = castings.map { |casting| Casting.new( casting ) }
    return result
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM castings WHERE id = $1"
    values = [id]
    casting_hash = SqlRunner.run(sql,values).first()
    return nil if casting_hash == nil
    return Casting.new(casting_hash)
  end

  def update_by_id(id)
    sql = "UPDATE castings SET fee = $1 WHERE id = $2"
    values = [@fee, id]
    SqlRunner.run(sql,values)
  end


end
