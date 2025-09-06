# RSpec Boilerplate - Smartphone Management System

A Ruby on Rails API application with comprehensive RSpec testing framework for managing smartphone inventory. This project serves as a boilerplate for building robust Rails applications with proper testing practices.

## 🚀 Features

- **RESTful API** for smartphone registration and management
- **Comprehensive RSpec Testing** with model and controller specs
- **Database Models** with proper associations and validations
- **Elasticsearch Integration** ready for search functionality
- **Docker Support** for Elasticsearch deployment
- **Code Quality Tools** (RuboCop, Pry debugging)

## 📋 Prerequisites

- Ruby 3.2.2
- Rails 7.1.1
- SQLite3
- Docker (for Elasticsearch)

## 🛠️ Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd rspec_boilerplate
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Setup the database**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Start the Rails server**
   ```bash
   rails server
   ```

The API will be available at `http://localhost:3000`

## 🗄️ Database Schema

The application uses a relational database with the following models:

### Core Models
- **Smartphone** - Main entity with associations to all other models
- **Manufacturer** - Phone manufacturers (Apple, Samsung, etc.)
- **Model** - Phone models (iPhone 15, Galaxy S24, etc.)
- **Memory** - Storage options (64GB, 128GB, 256GB, etc.)
- **Year** - Release years
- **OsVersion** - Operating system versions
- **BodyColor** - Available colors

### Relationships
```
Smartphone
├── belongs_to :manufacturer
├── belongs_to :model
├── belongs_to :memory
├── belongs_to :year
├── belongs_to :os_version
└── belongs_to :body_color

Model
└── belongs_to :manufacturer
```

## 🔌 API Endpoints

### Register Smartphone
**POST** `/register_phone`

Creates a new smartphone record with validation.

**Request Body:**
```json
{
  "smartphone": {
    "manufacturer_id": 1,
    "model_id": 1,
    "memory_id": 1,
    "year_id": 1,
    "os_version_id": 1,
    "body_color_id": 1,
    "price": 999
  }
}
```

**Success Response (201):**
```json
{
  "id": 1,
  "manufacturer_id": 1,
  "model_id": 1,
  "memory_id": 1,
  "year_id": 1,
  "os_version_id": 1,
  "body_color_id": 1,
  "price": 999,
  "created_at": "2023-11-21T05:00:00.000Z",
  "updated_at": "2023-11-21T05:00:00.000Z"
}
```

**Error Responses:**
- **404 Not Found** - Invalid reference IDs
- **422 Unprocessable Entity** - Validation errors or manufacturer-model mismatch

### Health Check
**GET** `/up`

Returns application health status.

## 🧪 Testing

This project includes comprehensive RSpec testing setup:

### Running Tests
```bash
# Run all tests
bundle exec rspec

# Run specific test files
bundle exec rspec spec/models/
bundle exec rspec spec/controllers/

# Run with coverage
bundle exec rspec --format documentation
```

### Test Structure
```
spec/
├── controllers/
│   └── smartphones_controller_spec.rb
├── models/
│   ├── smartphone_spec.rb
│   ├── manufacturer_spec.rb
│   ├── model_spec.rb
│   ├── memory_spec.rb
│   ├── year_spec.rb
│   ├── os_version_spec.rb
│   └── body_color_spec.rb
├── rails_helper.rb
└── spec_helper.rb
```

### Test Features
- **Model Specs** - Test associations, validations, and methods
- **Controller Specs** - Test API endpoints and responses
- **Factory Support** - Ready for FactoryBot integration
- **Database Cleaner** - Automatic test database cleanup

## 🔍 Elasticsearch Integration

The project includes Elasticsearch configuration for future search functionality:

### Setup Elasticsearch with Docker
```bash
# Build and run Elasticsearch container
cd elastic_search
docker build -t elasticsearch-custom .
docker run -d -p 9200:9200 -p 9300:9300 elasticsearch-custom
```

### Configuration
- **Dockerfile** - Custom Elasticsearch 7.15.2 image
- **elasticsearch.yml** - Cluster configuration
- **Ports** - 9200 (HTTP), 9300 (Transport)

## 🛠️ Development Tools

### Code Quality
- **RuboCop** - Ruby style guide enforcement
- **Pry** - Interactive debugging
- **Awesome Print** - Pretty printing for debugging

### Debugging
```bash
# Start Rails console with debugging
rails console

# Run RuboCop
bundle exec rubocop

# Run RuboCop with auto-fix
bundle exec rubocop -a
```

## 📁 Project Structure

```
rspec_boilerplate/
├── app/
│   ├── controllers/
│   │   └── smartphones_controller.rb
│   └── models/
│       ├── smartphone.rb
│       ├── manufacturer.rb
│       ├── model.rb
│       ├── memory.rb
│       ├── year.rb
│       ├── os_version.rb
│       └── body_color.rb
├── config/
│   └── routes.rb
├── db/
│   ├── migrate/
│   └── schema.rb
├── elastic_search/
│   ├── Dockerfile
│   └── elastic_search_docker
├── spec/
│   ├── controllers/
│   ├── models/
│   ├── rails_helper.rb
│   └── spec_helper.rb
├── Gemfile
└── README.md
```

## 🚀 Getting Started with Development

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes**
4. **Write tests** for new functionality
5. **Run the test suite**
   ```bash
   bundle exec rspec
   ```
6. **Commit your changes**
   ```bash
   git commit -m "feat/add-your-feature"
   ```
7. **Push to your branch**
   ```bash
   git push origin feature/your-feature-name
   ```

## 📝 Contributing

1. Follow the existing code style (RuboCop enforced)
2. Write tests for all new functionality
3. Ensure all tests pass before submitting
4. Use descriptive commit messages with the `feat/` prefix
5. Update documentation as needed

## 🔧 Configuration

### Environment Variables
Create a `.env` file for environment-specific configurations:
```bash
# Database
DATABASE_URL=sqlite3:db/development.sqlite3

# Elasticsearch
ELASTICSEARCH_URL=http://localhost:9200
```

### RSpec Configuration
The project uses a custom `.rspec` file with:
- Documentation format for better test output
- Color output enabled
- Rails-specific configurations

## 📚 Additional Resources

- [Rails Guides](https://guides.rubyonrails.org/)
- [RSpec Documentation](https://rspec.info/)
- [Elasticsearch Documentation](https://www.elastic.co/guide/)
- [Docker Documentation](https://docs.docker.com/)

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🤝 Support

For questions or support, please open an issue in the repository or contact the development team.

---

**Happy Coding! 🚀**