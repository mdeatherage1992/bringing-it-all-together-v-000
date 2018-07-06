class Dog
  attr_accessor :name, :breed
attr_reader :id

  def initialize(id=nil, name, breed)
    @id = id
    @name = name
    @breed = breed
  end

 def self.create_table
   sql = <<-SQL
   CREATE TABLE dogs
   SQL
   DB[:conn].execute(sql)





  def save
    if self.id
      self.update
    else
      sql = <<-SQL
        INSERT INTO songs (name, breed)
        VALUES (?, ?)
      SQL

      DB[:conn].execute(sql, self.name, self.breed)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    end
  end

  def self.create(name:, breed:)
    dog = Dog.new(name, breed)
    dog.save
    dog
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM dogs WHERE id = ?"
    result = DB[:conn].execute(sql, id)[0]
    Dog.new(result[0], result[1], result[2])
  end

  def update
    sql = "UPDATE dogs SET name = ?, breed = ? WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.breed, self.id)
  end
end
