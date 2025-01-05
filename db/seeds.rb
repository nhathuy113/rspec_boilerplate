# db/seeds.rb

# Brands
brands = [
  { name: 'Apple' },
  { name: 'Samsung' },
  { name: 'Google' },
  { name: 'OnePlus' },
  { name: 'Xiaomi' }
]

brands.each do |brand|
  Brand.create!(name: brand[:name])
end

# Years
years = [2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024]
years.each do |year|
  Year.create!(number: year)
end

# OS Versions
os_versions = [
  { version: 'iOS 12'},
  { version: 'iOS 13'},
  { version: 'iOS 14'},
  { version: 'Android 11' },
  { version: 'Android 12' },
  { version: 'Android 13' }
]

os_versions.each do |os_version|
  OsVersion.create!(version: os_version[:version])
end

# SmartPhone Models
smartphone_models = [
  { name: 'iPhone 12', year_id: 8, os_version_id: 3, brand_id: 1 },
  { name: 'Galaxy S21', year_id: 8, os_version_id: 6, brand_id: 1 },
  { name: 'Pixel 6', year_id: 8, os_version_id: 6, brand_id: 2 },
  { name: 'OnePlus 9 Pro', year_id: 8, os_version_id: 6, brand_id: 3 },
  { name: 'Redmi Note 11', year_id: 8, os_version_id: 6, brand_id: 4 }
]

smartphone_models.each do |model|
  SmartphoneModel.create!(
    name: model[:name],
    year_id: model[:year_id],
    os_version_id: model[:os_version_id],
    brand_id: model[:brand_id]
  )
end

# Body Colors
body_colors = [
  { color: 'Space Gray' },
  { color: 'Graphite' },
  { color: 'Silver' },
  { color: 'Black' },
  { color: 'White' }
]

body_colors.each do |color|
  BodyColor.create!(color: color[:color])
end

# Memories
memories = [
  { size: '64GB' },
  { size: '128GB' },
  { size: '256GB' },
  { size: '512GB' }
]

memories.each do |memory|
  Memory.create!(size: memory[:size])
end

# Smartphones (using existing data)
smartphones = [
  { smartphone_model_id: 1, imei: 'abc1' },
  { smartphone_model_id: 2, imei: 'abc2' },
  { smartphone_model_id: 3, imei: 'abc3' },
  { smartphone_model_id: 4, imei: 'abc4' }
]


# { smartphone_model_id: 1, smartphone_option: 1, imei: 'abc1' },
#   { smartphone_model_id: 2, smartphone_option: 1, imei: 'abc2' },
#   { smartphone_model_id: 3, smartphone_option: 1, imei: 'abc3' },
#   { smartphone_model_id: 4, smartphone_option: 1, imei: 'abc4' }

smartphones.each do |smartphone|
  # Smartphone.create!(smartphone_model_id: smartphone[:smartphone_model_id], smartphone_option_id: smartphone[:smartphone_model_id], imei: smartphone[:imei])
  Smartphone.create!(smartphone_model_id: smartphone[:smartphone_model_id], imei: smartphone[:imei])
end

# Model Options (associating models with body colors and memories)
model_options = [
  { smartphone_model_id: 1, body_color_id: 2, memory_id: 2 },
  { smartphone_model_id: 2, body_color_id: 3, memory_id: 3 },
  { smartphone_model_id: 3, body_color_id: 4, memory_id: 1 },
]
``
model_options.each do |option|
  ModelOption.create!(
    smartphone_model_id: option[:smartphone_model_id],
    body_color_id: option[:body_color_id],
    memory_id: option[:memory_id]
  )
end

puts "Seeding complete!"
