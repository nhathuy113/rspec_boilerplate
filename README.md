# RSpec Boilerplate - Smartphone Management System with OAuth Authentication

A comprehensive Ruby on Rails application with Google OAuth authentication, smartphone inventory management API, and extensive RSpec testing framework. This project serves as a robust boilerplate for building modern Rails applications with authentication and testing best practices.

## 🚀 Features

- ✅ **Google OAuth authentication** with secure session management
- ✅ **RESTful API** for smartphone registration and management
- ✅ **Comprehensive RSpec Testing** with FactoryBot, DatabaseCleaner, Shoulda Matchers
- ✅ **MySQL database** with proper associations and validations
- ✅ **Elasticsearch integration** for search functionality
- ✅ **Modern Bootstrap UI** with responsive design
- ✅ **Docker Compose** with health checks and proper service dependencies
- ✅ **Code Quality Tools** (RuboCop, Pry debugging)

## 📋 Prerequisites

- Docker and Docker Compose
- Google OAuth credentials (see setup below)
- Ruby 3.1.6 (for local development)
- Rails 7.1.1

## 🐳 Quick Start with Docker

### 1. Google OAuth Setup

1. Go to [Google Cloud Console](https://console.developers.google.com/)
2. Create a new project or select existing one
3. Enable Google+ API
4. Go to Credentials → Create Credentials → OAuth 2.0 Client IDs
5. Set authorized redirect URIs to: `http://localhost:3000/auth/google_oauth2/callback`
6. Copy your Client ID and Client Secret

### 2. Environment Variables

Create a `.env` file in the root directory:

```bash
GOOGLE_CLIENT_ID=your_google_client_id_here
GOOGLE_CLIENT_SECRET=your_google_client_secret_here
```

### 3. Run the Application

```bash
# Build and start all services
docker compose up --build

# Wait ~30 seconds for MySQL to initialize, then setup database
docker compose exec web bundle exec rails db:create db:migrate db:seed
```

### 4. Access the Application

- **Main app**: http://localhost:3000
- **Elasticsearch**: http://localhost:9200
- **Kibana**: http://localhost:5601

## 🌐 Usage

1. **Visit the login page** at `http://localhost:3000`
2. **Sign in with Google** using the OAuth button
3. **Access the welcome page** (only available to authenticated users)
4. **Use the smartphone API** at `POST /register_phone`

## 🔌 API Endpoints

### Smartphone Management

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

## 🗄️ Database Schema

The application uses a MySQL database with the following models:

### Core Models
- **Smartphone** - Main entity with associations to all other models
- **User** - OAuth authenticated users
- **Brand** - Phone manufacturers (Apple, Samsung, etc.)
- **SmartphoneModel** - Phone models (iPhone 15, Galaxy S24, etc.)
- **Memory** - Storage options (64GB, 128GB, 256GB, etc.)
- **Year** - Release years
- **OsVersion** - Operating system versions
- **BodyColor** - Available colors

### Relationships
```
Smartphone
├── belongs_to :model_option
│   ├── belongs_to :smartphone_model
│   ├── belongs_to :body_color
│   └── belongs_to :memory

SmartphoneModel
├── belongs_to :brand
├── belongs_to :year
└── belongs_to :os_version

User (OAuth)
├── email (unique)
├── provider
└── uid
```

## 🧪 Testing

This project includes comprehensive RSpec testing setup:

### Running Tests
```bash
# Run all tests (Docker)
docker compose exec web bundle exec rspec

# Run specific test file
docker compose exec web bundle exec rspec spec/models/smartphone_spec.rb

# Run all tests (local)
bundle exec rspec

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
│   ├── brand_spec.rb
│   ├── smartphone_model_spec.rb
│   ├── memory_spec.rb
│   ├── year_spec.rb
│   ├── os_version_spec.rb
│   └── body_color_spec.rb
├── is_palindrome_spec.rb
├── rotate_matrix_spec.rb
├── rails_helper.rb
└── spec_helper.rb
```

### Test Features
- **Model Specs** - Test associations, validations, and methods
- **Controller Specs** - Test API endpoints and responses
- **Algorithm Tests** - Palindrome and matrix rotation tests
- **Factory Support** - FactoryBot integration for test data

## 🔍 Elasticsearch Integration

The project includes Elasticsearch configuration for search functionality:

### Configuration
- **Elasticsearch 8.8.0** with Docker
- **Kibana 8.8.0** for data visualization
- **Health checks** and proper service dependencies
- **Ports** - 9200 (HTTP), 9300 (Transport), 5601 (Kibana)

## 🛠️ Development

### Database Management
```bash
# Run migrations
docker compose exec web bundle exec rails db:migrate

# Reset database
docker compose exec web bundle exec rails db:reset

# Access Rails console
docker compose exec web bundle exec rails console

# View logs
docker compose logs -f web
```

### Code Quality
- **RuboCop** - Ruby style guide enforcement
- **Pry** - Interactive debugging
- **Awesome Print** - Pretty printing for debugging

### Debugging
```bash
# Run RuboCop
bundle exec rubocop

# Run RuboCop with auto-fix
bundle exec rubocop -a
```

## 🏗️ Architecture

- **Rails 7.1.1** with API and web interface
- **MySQL 8.0** for primary database
- **Elasticsearch 8.8.0** for search functionality
- **Docker Compose** for container orchestration
- **Google OAuth 2.0** for authentication
- **Bootstrap 5** for responsive UI

## 🔒 Security Features

- ✅ **OAuth 2.0 authentication** with Google
- ✅ **Session management** with secure cookies
- ✅ **CSRF protection** enabled
- ✅ **Input validation** on all API endpoints
- ✅ **Database constraints** and validations

## 📁 Project Structure

```
rspec_boilerplate/
├── app/
│   ├── controllers/
│   │   ├── application_controller.rb
│   │   ├── pages_controller.rb
│   │   ├── sessions_controller.rb
│   │   └── smartphones_controller.rb
│   ├── models/
│   │   ├── user.rb
│   │   ├── smartphone.rb
│   │   ├── brand.rb
│   │   ├── smartphone_model.rb
│   │   └── ... (other models)
│   └── views/
│       ├── layouts/
│       └── pages/
├── config/
│   ├── routes.rb
│   ├── routes/
│   │   └── auth.rb
│   └── initializers/
│       └── omniauth.rb
├── db/
│   ├── migrate/
│   └── schema.rb
├── spec/ (comprehensive test suite)
├── docker-compose.yml
├── Dockerfile
└── README.md
```

## 🚀 Contributing

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes** and write tests
4. **Run the test suite**
   ```bash
   docker compose exec web bundle exec rspec
   ```
5. **Ensure code quality**
   ```bash
   bundle exec rubocop
   ```
6. **Commit your changes** using the project's commit format
7. **Submit a pull request**

## 📚 Additional Resources

- [Rails Guides](https://guides.rubyonrails.org/)
- [RSpec Documentation](https://rspec.info/)
- [Google OAuth 2.0 Documentation](https://developers.google.com/identity/protocols/oauth2)
- [Elasticsearch Documentation](https://www.elastic.co/guide/)
- [Docker Documentation](https://docs.docker.com/)

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🤝 Support

For questions or support, please open an issue in the repository.

---

**Happy Coding! 🚀**
