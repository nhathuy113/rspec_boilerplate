# RSpec Boilerplate - Hệ thống quản lý Smartphone 📱

Dự án Rails API với Docker hoàn chỉnh, cấu hình sẵn để phát triển và deploy production.

## 🎯 Tại sao project này?

**Vấn đề thường gặp khi setup Rails project:**
- Setup môi trường phức tạp, mỗi máy khác nhau
- Conflict version Ruby, MySQL, dependencies
- Mất nhiều thời gian configure từ đầu
- Không có chuẩn cho team development

**Solution:** 
Project này cung cấp **boilerplate hoàn chỉnh** với Docker, sẵn sàng development và production.

## 🚀 Quick Start (5 phút)

### Bước 1: Clone và setup
```bash
git clone <repo-url>
cd rspec_boilerplate
cp .env.example .env
```

### Bước 2: Chạy tất cả services
```bash
docker-compose up -d
```

### Bước 3: Setup database (đợi MySQL khởi động ~30s)
```bash
docker-compose exec web rails db:create db:migrate db:seed
```

### Bước 4: Truy cập ứng dụng
- **API:** http://localhost:3000
- **Kibana:** http://localhost:5601
- **Elasticsearch:** http://localhost:9200

## 📋 Tech Stack

- **Backend:** Ruby 3.1.6, Rails 7.1.1
- **Database:** MySQL 8.0 (chính), PostgreSQL 13 (legacy)
- **Search:** Elasticsearch + Kibana
- **Container:** Docker + Docker Compose
- **Testing:** RSpec với FactoryBot

## 🗄️ Database Schema

### Models chính
```ruby
Smartphone
├── belongs_to :manufacturer  # Hãng sản xuất
├── belongs_to :model         # Model máy
├── belongs_to :memory        # Dung lượng
├── belongs_to :year          # Năm sản xuất
├── belongs_to :os_version    # Phiên bản OS
└── belongs_to :body_color    # Màu sắc

Model
└── belongs_to :manufacturer
```

### API chính
**POST /register_phone** - Đăng ký smartphone mới
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

## 🐳 Docker Environments

### Main Environment (Development)
```bash
# File: docker-compose.yml
Ports:
- Rails: 3000
- MySQL: 3306  
- Elasticsearch: 9200
- Kibana: 5601
```

### DevContainer (VS Code)
```bash
# File: .devcontainer/docker-compose.yml
Ports:
- MySQL: 3307
- PostgreSQL: 5433
```

### Production
```bash
# File: docker-compose.prod.yml
# Secure, optimized cho production
```

## 🛠️ Development Workflow

### Làm việc hàng ngày
```bash
# Xem logs
docker-compose logs -f web

# Vào Rails console
docker-compose exec web rails console

# Chạy tests
docker-compose exec web bundle exec rspec

# Reset database
docker-compose exec web rails db:reset
```

### Debug và troubleshooting
```bash
# Kiểm tra services đang chạy
docker-compose ps

# Restart một service
docker-compose restart web

# Xem logs của MySQL
docker-compose logs mysql
```

## ⚙️ Configuration

### Environment Variables
```bash
# MySQL (Database chính)
DB_HOST=mysql
DB_USER=root
DB_PASSWORD=password

# Rails
RAILS_ENV=development
DATABASE_URL=mysql2://root:password@mysql:3306/rspec_boilerplate_development

# PostgreSQL (Legacy/DevContainer)
POSTGRES_PASSWORD=secret
POSTGRES_USER=rspec_boilerplate
```

### Kết nối database
```bash
# Trong Docker (default)
host: mysql, port: 3306

# Từ máy local (outside Docker)  
host: localhost, port: 3306

# DevContainer environment
host: localhost, port: 3307
```

## 🧪 Testing với RSpec

### Chạy tests
```bash
# Tất cả tests
docker-compose exec web bundle exec rspec

# Test specific file
docker-compose exec web bundle exec rspec spec/models/smartphone_spec.rb

# Test với format detail
docker-compose exec web bundle exec rspec --format documentation
```

### Test structure
```
spec/
├── controllers/     # Test API endpoints
├── models/         # Test business logic
├── factories/      # Test data factories
└── requests/       # Integration tests
```

## 🚨 Troubleshooting

### Lỗi thường gặp

**1. MySQL chưa sẵn sàng**
```bash
# Đợi MySQL khởi động hoàn toàn (30-60s)
docker-compose logs mysql
# Thấy "ready for connections" là ok
```

**2. Port conflict**
```bash
# Kiểm tra port đang dùng
lsof -i :3000
# Kill process hoặc đổi port khác
```

**3. Permission errors**
```bash
# Fix quyền executable
chmod +x docker-entrypoint.sh
```

**4. Reset hoàn toàn**
```bash
# Xóa tất cả containers và volumes
docker-compose down -v --remove-orphans
docker-compose up -d
# Đợi 60s rồi chạy lại db:create db:migrate
```

## 🎯 Use Cases

### Dành cho Developer
- **Learning:** Học Rails API development với Docker
- **Boilerplate:** Base code cho project mới
- **Reference:** Tham khảo best practices setup

### Dành cho Team
- **Onboarding:** New member setup trong 5 phút
- **Standardization:** Môi trường development thống nhất
- **CI/CD:** Ready cho automated testing

### Dành cho Business
- **Demo:** Show clients technical capability
- **Scaling:** Sẵn sàng mở rộng team
- **Production:** Deploy thật với docker-compose.prod.yml

## 📊 Project Stats

- **Lines of code:** ~2000+ (including tests)
- **Test coverage:** Comprehensive model + controller tests  
- **Docker images:** 4 environments (dev, devcontainer, prod, elasticsearch)
- **Documentation:** Complete setup + troubleshooting guides

## 🎓 Learning Outcomes

Sau khi chạy project này, bạn sẽ hiểu:

- **Docker Compose** multi-service setup
- **Rails API** development patterns  
- **MySQL + Elasticsearch** integration
- **Environment configuration** best practices
- **Testing** với RSpec và FactoryBot
- **Production deployment** considerations

## 📞 Support

**Nếu gặp vấn đề:**
1. Kiểm tra troubleshooting section trên
2. Xem logs: `docker-compose logs <service-name>`
3. Google error message cụ thể
4. Reset hoàn toàn nếu cần thiết

## 🎉 Kết luận

Đây là **production-ready boilerplate** cho Rails API development. 

**Suitable for:**
- Mid-level developers muốn học Docker + Rails
- Teams cần standardized development environment  
- Startups muốn setup nhanh và professional

**Time investment:** 10 phút setup → tiết kiệm hàng giờ sau này!

---

**Happy Coding! 🚀**
