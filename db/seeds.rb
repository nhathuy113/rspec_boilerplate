# db/seeds.rb

years = [2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024]

# why no use
# years = (2018..2023).to_a => 2018 1/2

years.each do |year|
  Year.create!(number: year)
end

# Brands
brands = %w[Apple Samsung Google Huawei OnePlus]
model_suffixes = {
  'Apple'    => 'iPhone',
  'Samsung'  => 'Galaxy',
  'Google'   => 'Pixel',
  'Huawei'   => 'Mate',
  'OnePlus'  => 'OnePlus'
}
brands.each do |brand|
  Brand.create!(name: brand[:name])
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

# Define possible options for storage and colors
storage_options = [64, 128, 256, 512]
color_options = %w[Black White Gold Blue Red Green]
edition_labels  = %w[Standard Pro Plus Lite]

years.each do |year|
  brands.each do |brand|
    rand(1..2).times do
      # brand_make_smartphone_model
      new_smartphone_released_by brand
    end
  end
end

def new_smartphone_released_by(brand)
  os_name = 'Android'
  # os_name = 'iOS' if brand.name == SmartphoneModel.APPLE
  os_name = 'iOS' if brand.is_apple?

  SmartphoneModel.create!(
    name: model[:name],h
    year_id: model[:year_id],
    os_version_id: model[:os_version_id],
    brand_id: brand
  )

  combinations = storage_options.product(color_options)

  combinations.each do |comb|
    storage, color = comb

    ModelOption.create!(
      body_color: color,
      memory: storage
    )
  end
end

# TODO
SmartphoneModel.create!(
  name: model[:name],
  year_id: model[:year_id],
  os_version_id: model[:os_version_id],
  brand_id: model[:brand_id]
)



# os_versions.select { |os| os.start_with? os_name }

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
puts "Seeding Smartphone Model complete!"


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


puts "Seeding Body color and Memory complete!"
#----------------------------------------
# Model Options (associating models with body colors and memories)
model_options = [
  { smartphone_model_id: 1, body_color_id: 2, memory_id: 2 },
  { smartphone_model_id: 2, body_color_id: 3, memory_id: 3 },
  { smartphone_model_id: 3, body_color_id: 4, memory_id: 1 },
]

model_options.each do |option|
  ModelOption.create!(
    smartphone_model_id: option[:smartphone_model_id],
    body_color_id: option[:body_color_id],
    memory_id: option[:memory_id]
  )
end
puts "Seeding Model Options complete!"

#
# ## Smartphone (using existing data)
smartphones = [
  { model_option_id: 1, imei: 'MTLY3LL/A6417993' },
  { model_option_id: 1, imei: 'abc2' }
]
smartphones.each do |smartphone|
  # Smartphone.create!(smartphone_model_id: smartphone[:smartphone_model_id], smartphone_option_id: smartphone[:smartphone_model_id], imei: smartphone[:imei])
  Smartphone.create!(model_option_id: smartphone[:model_option_id], imei: smartphone[:imei])
end

puts "Seeding complete!"
