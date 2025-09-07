#!/bin/bash
set -e

echo "🚀 RSpec Boilerplate - Docker Development Setup"
echo "================================================"

# Check prerequisites
echo "🔍 Checking prerequisites..."
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is required. Install from: https://www.docker.com/products/docker-desktop"
    exit 1
fi

if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose is required."
    exit 1
fi

echo "✅ Docker prerequisites met"

# Setup environment
if [ ! -f .env ]; then
    cp .env.example .env
    echo "✅ Created .env from template"
fi

# Fix permissions
chmod +x docker-entrypoint.sh
echo "✅ Fixed docker-entrypoint.sh permissions"

# Start services
echo "🐳 Starting Docker services..."
docker-compose up -d

# Wait for MySQL
echo "⏳ Waiting for MySQL to initialize (this may take 60+ seconds)..."
sleep 10

# Check MySQL health
attempt=0
max_attempts=30
while [ $attempt -lt $max_attempts ]; do
    if docker-compose exec -T mysql mysqladmin ping -h localhost -u root -ppassword --silent; then
        echo "✅ MySQL is ready"
        break
    fi
    attempt=$((attempt + 1))
    echo "   Waiting for MySQL... ($attempt/$max_attempts)"
    sleep 3
done

if [ $attempt -eq $max_attempts ]; then
    echo "❌ MySQL failed to start. Check logs:"
    docker-compose logs mysql
    exit 1
fi

# Setup database
echo "🗄️ Setting up Rails database..."
docker-compose exec -T web bundle exec rails db:create
docker-compose exec -T web bundle exec rails db:migrate

# Optional seed data
read -p "📊 Load sample data? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    docker-compose exec -T web bundle exec rails db:seed
    echo "✅ Sample data loaded"
fi

echo ""
echo "🎉 Development environment ready!"
echo ""
echo "📍 Access Points:"
echo "   📱 Rails API:      http://localhost:3000"
echo "   🔍 Elasticsearch:  http://localhost:9200"  
echo "   📊 Kibana:         http://localhost:5601"
echo ""
echo "🛠️  Useful Commands:"
echo "   View logs:         docker-compose logs -f web"
echo "   Rails console:     docker-compose exec web rails console"
echo "   Run tests:         docker-compose exec web bundle exec rspec"
echo "   Stop services:     docker-compose down"
echo "   Full reset:        docker-compose down -v && ./scripts/dev-setup.sh"


