require_relative('../db/sql_runner')

class Star

  attr_accessor :first_name, :last_name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def save()
    sql = "INSERT INTO stars
    (
      first_name, last_name
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@first_name, @last_name]
    user = SqlRunner.run( sql, values ).first
    @id = user['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM stars"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM stars"
    stars = SqlRunner.run(sql, [])
    result = stars.map { |star| Casting.new( star ) }
    return result
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM stars WHERE id = $1"
    values = [id]
    star_hash = SqlRunner.run(sql,values).first()
    return nil if star_hash == nil
    return Casting.new(star_hash)
  end

  def update_by_id(id)
    sql = "UPDATE stars SET fee = $1 WHERE id = $2"
    values = [@fee, id]
    SqlRunner.run(sql,values)
  end

end
