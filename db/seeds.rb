# db/seeds.rb

years = [2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024]

# why no use
# years = (2018..2023).to_a => 2018 1/2

years.each { |year| Year.create!(number: year) }

# Brands
brands = %w[Apple Samsung Google Huawei OnePlus]
model_suffixes = {
  'Apple'    => 'iPhone',
  'Samsung'  => 'Galaxy',
  'Google'   => 'Pixel',
  'Huawei'   => 'Mate',
  'OnePlus'  => 'OnePlus'
}
brands.each { |brand_name| Brand.create!(name: brand_name) }

# OS Versions
os_versions = %w[iOS\ 12 iOS\ 13 iOS\ 14 Android\ 11 Android\ 12 Android\ 13]
os_versions.each { |ver| OsVersion.create!(version: ver.gsub('\\', '')) }

# Define possible options for storage and colors
storage_options = [64, 128, 256, 512]
color_options = %w[Black White Gold Blue Red Green]
edition_labels  = %w[Standard Pro Plus Lite]

brands_records = Brand.all.index_by(&:name)
years_records = Year.all.index_by(&:number)
os_records = OsVersion.all.index_by(&:version)



# os_versions.select { |os| os.start_with? os_name }

# SmartPhone Models
smartphone_models = [
  { name: 'iPhone 12', year: 2022, os_version: 'iOS 14', brand: 'Apple' },
  { name: 'Galaxy S21', year: 2022, os_version: 'Android 13', brand: 'Samsung' },
  { name: 'Pixel 6', year: 2022, os_version: 'Android 13', brand: 'Google' },
  { name: 'OnePlus 9 Pro', year: 2022, os_version: 'Android 13', brand: 'OnePlus' }
]

smartphone_models.each do |m|
  SmartphoneModel.create!(
    name: m[:name],
    year: years_records[m[:year]],
    os_version: os_records[m[:os_version]],
    brand: brands_records[m[:brand]]
  )
end
puts "Seeding Smartphone Model complete!"


# Body Colors
body_colors = %w[Space\ Gray Graphite Silver Black White]
body_colors.each { |c| BodyColor.create!(color: c.gsub('\\', '')) }

# Memories
memories = %w[64GB 128GB 256GB 512GB]
memories.each { |m| Memory.create!(size: m) }


puts "Seeding Body color and Memory complete!"
#----------------------------------------
# Model Options (associating models with body colors and memories)
created_models = SmartphoneModel.all
colors = BodyColor.all
mems = Memory.all

created_models.each do |mdl|
  [colors.sample, colors.sample].uniq.each do |c|
    [mems.sample, mems.sample].uniq.each do |mem|
      ModelOption.create!(smartphone_model: mdl, body_color: c, memory: mem)
    end
  end
end
puts "Seeding Model Options complete!"

#
# ## Smartphone (using existing data)
first_option = ModelOption.first
Smartphone.create!(model_option: first_option, imei: 'A12345678901234')
Smartphone.create!(model_option: first_option, imei: 'B98765432109876')

puts "Seeding complete!"
