require 'sqlite3'

class Chef
  def initialize(first_name, last_name, birthday, email, phone)
    @first_name = first_name
    @last_name = last_name
    @birthday = birthday
    @email = email
    @phone = phone
  end
  def save
    Chef.db.execute(
      <<-SQL
        INSERT INTO chefs 
        (first_name, last_name, birthday, email, phone, created_at, updated_at)
        VALUES
        ("#{@first_name}", "#{@last_name}", "#{@birthday}", "#{@email}", "#{@phone}", DATETIME('now'), DATETIME('now'));
      SQL
    )
  end

  def self.create_table
    Chef.db.execute(
      <<-SQL
        CREATE TABLE chefs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name VARCHAR(64) NOT NULL,
          last_name VARCHAR(64) NOT NULL,
          birthday DATE NOT NULL,
          email VARCHAR(64) NOT NULL,
          phone VARCHAR(64) NOT NULL,
          created_at DATETIME NOT NULL,
          updated_at DATETIME NOT NULL
        );
      SQL
    )
  end

  def self.seed
    Chef.db.execute(
      <<-SQL
        INSERT INTO chefs
          (first_name, last_name, birthday, email, phone, created_at, updated_at)
        VALUES
          ('Rosenzweig', 'Aaron', '1995-29-11', 'rosenzweig.a@gmail.com', '73829091423', DATETIME('now'), DATETIME('now')),
          ('Ferran', 'Adriá', '1985-02-09', 'ferran.adria@elbulli.com', '42381093238', DATETIME('now'), DATETIME('now')),
          ('Becerril', 'Jose', '1943-03-10', 'bece@kaiuj.com', '92749381673', DATETIME('now'), DATETIME('now')),
          ('Jaime', 'Ximena', '1989-08-07', 'xime@gmail.com', '72274538911', DATETIME('now'), DATETIME('now')),
          ('Hernandez', 'Pablo', '1999-01-19', 'barca@yahoo.com', '29836489001', DATETIME('now'), DATETIME('now')),
          ('Gutierrez', 'Mariana', '1967-04-04', 'marianagu@hotmail.com', '83645218923', DATETIME('now'), DATETIME('now'));
      SQL
    )
  end

  def self.all
    Chef.db.execute(
      <<-SQL
        SELECT * FROM chefs;
      SQL
    )
  end

  def self.where(condicion, value)
    Chef.db.execute(
      <<-SQL
        SELECT * FROM chefs WHERE "#{condicion}" = "#{value}";
        DELETE FROM chefs WHERE "#{condicion}" = "#{value}";
      SQL
    )
  end

  def self.delete(condicion, value)
    Chef.db.execute(
      <<-SQL
        DELETE FROM chefs WHERE "#{condicion}" = "#{value}";
      SQL
    )
  end

  private

  def self.db
    @@db ||= SQLite3::Database.new("chefs.db")
  end

end

 chef = Chef.new('Jaime', 'Kuriel', '1978-05-08', 'jakuri@gmail.com', '28367491028')
 chef.save