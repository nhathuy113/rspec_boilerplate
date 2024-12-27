
# Manufacturer seeds
Manufacturer.create(name: 'Apple')
Manufacturer.create(name: 'Samsung')
Manufacturer.create(name: 'Google')

# SmartphoneModel seeds
SmartphoneModel.create(name: 'iPhone X', manufacturer: Manufacturer.find_by(name: 'Apple'))
SmartphoneModel.create(name: 'Galaxy S21', manufacturer: Manufacturer.find_by(name: 'Samsung'))
SmartphoneModel.create(name: 'Pixel 5', manufacturer: Manufacturer.find_by(name: 'Google'))

# Memory seeds
Memory.create(size: '64GB')
Memory.create(size: '128GB')

# Year seeds
Year.create(year: '2020')
Year.create(year: '2021')

# OS Version seeds
OsVersion.create(version: 'iOS 14')
OsVersion.create(version: 'Android 11')

# Body Color seeds
BodyColor.create(color: 'Black')
BodyColor.create(color: 'Silver')
BodyColor.create(color: 'Gold')

# Smartphone seeds
Smartphone.create(
  manufacturer: Manufacturer.find_by(name: 'Apple'),
  smartphone_model: SmartphoneModel.find_by(name: 'iPhone X'),
  memory: Memory.find_by(size: '64GB'),
  year: Year.find_by(year: '2020'),
  os_version: OsVersion.find_by(version: 'iOS 14'),
  body_color: BodyColor.find_by(color: 'Black'),
  price: 999.99
)

Smartphone.create(
  manufacturer: Manufacturer.find_by(name: 'Samsung'),
  smartphone_model: SmartphoneModel.find_by(name: 'Galaxy S21'),
  memory: Memory.find_by(size: '128GB'),
  year: Year.find_by(year: '2021'),
  os_version: OsVersion.find_by(version: 'Android 11'),
  body_color: BodyColor.find_by(color: 'Silver'),
  price: 899.99
)

# 1. Ease of retrieve and update
apple = Manufacturer.find_by 'apple'
apple.smartphone_model.all

# 2. Case study
# study business of real life system
