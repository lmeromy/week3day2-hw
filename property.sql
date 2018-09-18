DROP TABLE IF EXISTS properties;

CREATE TABLE properties(
  id SERIAL4 PRIMARY KEY,
  address VARCHAR(255),
  value INT4,
  number_beds INT2,
  year_built VARCHAR(255)
);
