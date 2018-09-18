require('pg')

class Property
  attr_accessor :address, :value, :number_beds, :year_built

  attr_reader :id

  def initialize(hoose_options)
    @id = hoose_options["id"].to_i() if hoose_options["id"]
    @address = hoose_options["address"]
    @value = hoose_options["value"].to_i
    @number_beds = hoose_options["number_beds"].to_i
    @year_built = hoose_options["year_built"]
  end

  def save()
    db = PG.connect({dbname: "property-tracker", host: "localhost"})
    sql = "INSERT INTO properties (address, value, number_beds, year_built)
    VALUES ($1, $2, $3, $4)
    RETURNING *"
    values = [@address, @value, @number_beds, @year_built]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def update()
    db = PG.connect({dbname: "property-tracker", host: "localhost"})
    sql = "UPDATE properties SET
    (address, value, number_beds, year_built)
    = ($1, $2, $3, $4)
    WHERE id = $5 "
    values = [@address, @value, @number_beds, @year_built, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  # not sure if this is working
  def Property.find_by_id(id)
    db = PG.connect({dbname: "property-tracker", host: "localhost"})
    sql = "SELECT * FROM properties WHERE id = $1"
    values = [@id]
    db.prepare("find_by_id", sql)
    hoose = db.exec_prepared("find_by_id", values)
    db.close()
    return hoose
  end

  # also not sure if this is working
  def Property.find_by_address(address)
    db = PG.connect({dbname: "property-tracker", host: "localhost"})
    sql = "SELECT * FROM properties WHERE address = $1"
    values = [@address]
    db.prepare("find_by_address", sql)
    hoose = db.exec_prepared("find_by_address", values)
    db.close()
    if hoose != nil
      return hoose
    else
      return nil
    end
  end

  # do we need the following function in order to run operations
  # on the data as class objects?
  def Property.all()
    db = PG.connect({dbname: "property-tracker", host: "localhost"})
    sql = "SELECT * FROM properties"
    db.prepare("all", sql)
    hooses = db.exec_prepared("all")
    db.close()
    return hooses.map {|hoose| Property.new(hoose)}
  end

  def Property.delete_all()
    db = PG.connect({dbname: "property-tracker", host: "localhost"})
    sql = "DELETE FROM properties"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

end
