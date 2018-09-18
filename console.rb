require("pry")
require_relative("./models/property")


#Property.delete_all()

hoose1 = Property.new({
  "address" => "18 Stratford Drive",
  "value" => 290000,
  "number_beds" => 2,
  "year_built" => "1954"
})


hoose1.save()

hoose2 = Property.new({
  "address" => "32 Gaviota Way",
  "value" => 310000,
  "number_beds" => 3,
  "year_built" => "1930"
  })

hoose2.save()

hoose2.value = 330000
hoose2.update()

hooses = Property.all()
find1 = Property.find_by_id(24)
find2 = Property.find_by_address("18 Stratford Drive")

binding.pry
nil
