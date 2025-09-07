# RSpec Boilerplate - Smartphone Management 📱

Này là project Rails API với Docker setup sẵn rồi, chỉ cần chạy là xong! 

Không cần cài Ruby, MySQL, Redis gì hết. Mọi thứ đã có trong Docker container rồi 🐳

## 🚀 Làm sao để chạy project này? (2 phút thôi!)

**Bước 1:** Clone về và copy file config
```bash
git clone <repo-url>
cd rspec_boilerplate
cp .env.example .env
```

**Bước 2:** Chạy tất cả (1 lệnh là xong)
```bash
docker-compose up -d
```

**Bước 3:** Chờ MySQL khởi động (uống cafe 30 giây), rồi setup database
```bash
docker-compose exec web rails db:create db:migrate db:seed
```

**Bước 4:** Truy cập và test
- **API:** http://localhost:3000
- **Kibana (fancy UI):** http://localhost:5601
- **Elasticsearch:** http://localhost:9200

Xong! Đơn giản vậy thôi 😎

## 🐳 Docker làm cái gì vậy?

**Trước Docker (nightmare mode):**
```bash
# Cài Ruby 3.1.6... nhưng máy đang có Ruby 2.7
# Cài MySQL... conflict với PostgreSQL có sẵn
# Cài Redis... port 6379 bị chiếm rồi
# Bundle install... gem conflict 🤬
# 2 tiếng sau vẫn chưa chạy được...
```

**Với Docker (god mode):**
```bash
docker-compose up -d
# Boom! Tất cả chạy ngay 🎉
```

### Docker containers chúng ta có:
- **web:** Rails app (Ruby 3.1.6, tất cả gems đã cài sẵn)
- **mysql:** Database chính (MySQL 8.0)
- **elasticsearch:** Search engine (để làm fancy search sau này)
- **kibana:** UI để xem dữ liệu Elasticsearch

### Tại sao dùng Docker?
- **Consistent environment:** Máy ai cũng chạy y hệt nhau
- **No dependency hell:** Không bao giờ gặp lỗi "works on my machine"
- **Easy cleanup:** Không thích thì `docker-compose down` là sạch
- **Production-ready:** Config giống production luôn

## 📱 API chính làm gì?

Project này là **hệ thống quản lý smartphone**. Tưởng tượng bạn có cửa hàng điện thoại và cần track inventory.

### API chính: Đăng ký smartphone mới
**POST http://localhost:3000/register_phone**

```json
{
  "smartphone": {
    "manufacturer_id": 1,    // Hãng (Apple, Samsung, etc.)
    "model_id": 1,          // Model (iPhone 15, Galaxy S24, etc.)
    "memory_id": 1,         // Dung lượng (64GB, 128GB, etc.)
    "year_id": 1,           // Năm sản xuất
    "os_version_id": 1,     // iOS 17, Android 14, etc.
    "body_color_id": 1,     // Màu (đen, trắng, etc.)
    "price": 999            // Giá (USD)
  }
}
```

**Response khi thành công:**
```json
{
  "id": 1,
  "manufacturer_id": 1,
  "model_id": 1,
  "price": 999,
  "created_at": "2023-11-21T05:00:00.000Z"
}
```

**Response khi lỗi:**
- **404:** ID không tồn tại (manufacturer_id, model_id sai)
- **422:** Validation lỗi (VD: iPhone phải dùng iOS, không được dùng Android)

### Test API bằng curl:
```bash
curl -X POST http://localhost:3000/register_phone \
  -H "Content-Type: application/json" \
  -d '{
    "smartphone": {
      "manufacturer_id": 1,
      "model_id": 1,
      "memory_id": 1,
      "year_id": 1,
      "os_version_id": 1,
      "body_color_id": 1,
      "price": 999
    }
  }'
```

### Health Check API:
**GET http://localhost:3000/up** - Kiểm tra app có sống không

## 🛠️ Lệnh hữu ích khi development

### Làm việc hàng ngày:
```bash
# Xem app có chạy không (và debug lỗi gì)
docker-compose logs -f web

# Vào Rails console để test code
docker-compose exec web rails console

# Chạy tests (quan trọng!)
docker-compose exec web bundle exec rspec

# Reset database (khi làm lộn data)
docker-compose exec web rails db:reset
```

### Khi có trouble:
```bash
# Xem tất cả services có chạy không
docker-compose ps

# Restart Rails app
docker-compose restart web

# MySQL bị gì thì xem logs
docker-compose logs mysql

# Hỏng quá thì reset tất cả
docker-compose down -v --remove-orphans
docker-compose up -d
```

## 🚨 Troubleshooting (Lỗi thường gặp)

**"Connection refused" khi chạy API:**
- MySQL chưa khởi động xong đâu, chờ thêm 30 giây
- Xem `docker-compose logs mysql` có thấy "ready for connections" chưa

**"Port already in use":**
- Port 3000 bị chiếm rồi: `lsof -i :3000` và kill process đó
- Hoặc đổi port trong docker-compose.yml

**"Permission denied" trên docker-entrypoint.sh:**
```bash
chmod +x docker-entrypoint.sh
```

**Lỗi gì lạ lùng:**
```bash
# Nuclear option - reset tất cả
docker-compose down -v --remove-orphans
docker system prune -f
# Rồi chạy lại từ đầu
```

## 🎓 Học được gì từ project này?

- **Docker Compose:** Setup multi-service application
- **Rails API:** Build REST API properly
- **Database Design:** Relationships giữa các models
- **Testing:** RSpec testing patterns
- **Environment Config:** Manage configs cho nhiều environments
- **Production Ready:** Deploy và scale app

## 🎯 Dành cho ai?

**✅ Phù hợp nếu bạn:**
- Đã biết Rails cơ bản, muốn học Docker
- Cần setup nhanh Rails project mới
- Muốn hiểu production-ready Rails setup
- Team cần standardized development environment

**❌ Không phù hợp nếu:**
- Chưa từng code Rails (học Rails basic trước)
- Cần frontend (đây chỉ là API)
- Muốn app đơn giản (đây là enterprise setup)

---

**🎉 Vậy thôi! Chúc coding vui vẻ!** 

*P.S: Nếu setup thành công trong 5 phút thì bạn đã giỏi rồi đấy! 😎*
