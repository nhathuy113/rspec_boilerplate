# RSpec Boilerplate

A comprehensive Rails application with testing infrastructure, Docker containerization, and Google OAuth authentication.

## Features

- ✅ **RSpec testing framework** with FactoryBot, DatabaseCleaner, Shoulda Matchers
- ✅ **Google OAuth authentication** with secure session management
- ✅ **Smartphone management API** with comprehensive validation
- ✅ **MySQL database** with Docker containerization
- ✅ **Elasticsearch integration** for search functionality
- ✅ **Modern Bootstrap UI** with responsive design
- ✅ **Docker Compose** with health checks and proper service dependencies

## Quick Start

### Prerequisites

- Docker and Docker Compose
- Google OAuth credentials (see setup below)

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

# The application will be available at:
# - Main app: http://localhost:3000
# - Elasticsearch: http://localhost:9200
# - Kibana: http://localhost:5601
```

## Usage

1. **Visit the login page** at `http://localhost:3000`
2. **Sign in with Google** using the OAuth button
3. **Access the welcome page** (only available to authenticated users)
4. **Use the smartphone API** at `POST /register_phone`

## API Endpoints

### Smartphone Management

```bash
POST /register_phone
Content-Type: application/json

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

## Development

### Running Tests

```bash
# Run all tests
docker compose exec web bundle exec rspec

# Run specific test file
docker compose exec web bundle exec rspec spec/models/smartphone_spec.rb
```

### Database

```bash
# Run migrations
docker compose exec web bundle exec rails db:migrate

# Reset database
docker compose exec web bundle exec rails db:reset
```

## Architecture

- **Rails 7.1.1** with API and web interface
- **MySQL 8.0** for primary database
- **Elasticsearch 8.8.0** for search functionality
- **Docker Compose** for container orchestration
- **Google OAuth 2.0** for authentication
- **Bootstrap 5** for responsive UI

## Security Features

- ✅ **OAuth 2.0 authentication** with Google
- ✅ **Session management** with secure cookies
- ✅ **CSRF protection** enabled
- ✅ **Input validation** on all API endpoints
- ✅ **Database constraints** and validations

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Ensure all tests pass
5. Submit a pull request
