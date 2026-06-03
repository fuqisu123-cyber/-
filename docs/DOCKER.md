# Docker 运行指南

## 🐳 什么是 Docker？

Docker 是一个容器技术，可以把整个应用（包括数据库、后端、前端）打包在一起运行，**无需手动安装 MySQL、Node.js 等**。

## 📥 安装 Docker

### Windows 用户
1. 下载：https://www.docker.com/products/docker-desktop
2. 双击安装程序，按步骤安装
3. 重启电脑
4. 打开 PowerShell 或命令提示符，验证：
   ```
   docker --version
   ```

### Mac 用户
1. 下载：https://www.docker.com/products/docker-desktop
2. 拖动 Docker.app 到 Applications 文件夹
3. 打开 Docker 应用
4. 打开终端，验证：
   ```
   docker --version
   ```

### Linux 用户
```bash
sudo apt-get update
sudo apt-get install docker.io docker-compose
sudo systemctl start docker
docker --version
```

---

## 🚀 一键启动应用

### Windows 用户
1. 在项目根目录找到 `start.bat` 文件
2. 双击运行
3. 等待 30 秒左右
4. 自动在浏览器打开

### Mac/Linux 用户
```bash
# 进入项目目录
cd /path/to/project

# 给脚本执行权限
chmod +x start.sh

# 运行脚本
./start.sh
```

---

## 📱 访问应用

启动成功后，在浏览器打开：
- **前端应用**: http://localhost:5173
- **后端 API**: http://localhost:3000/api

---

## 🔧 常用 Docker 命令

### 查看运行的容器
```bash
docker-compose ps
```

### 查看日志
```bash
# 查看所有日志
docker-compose logs

# 实时查看日志
docker-compose logs -f

# 只看某个服务的日志
docker-compose logs -f backend
docker-compose logs -f frontend
docker-compose logs -f mysql
```

### 停止服务
```bash
# 停止但保留容器
docker-compose stop

# 停止并删除容器
docker-compose down

# 停止并删除所有数据
docker-compose down -v
```

### 重启服务
```bash
docker-compose restart
```

### 进入容器内部
```bash
# 进入后端容器
docker-compose exec backend sh

# 进入 MySQL 容器
docker-compose exec mysql bash
```

---

## 💾 数据库信息

| 项目 | 值 |
|------|-----|
| 主机 | localhost |
| 端口 | 3306 |
| 用户名 | root |
| 密码 | root |
| 数据库 | dropshipping_platform |

### 连接数据库

**使用 MySQL 客户端**：
```bash
mysql -h localhost -u root -p
# 密码：root
```

**使用图形化工具**（推荐）：
- DBeaver: https://dbeaver.io
- MySQL Workbench: https://www.mysql.com/products/workbench/
- Navicat: https://www.navicat.com

---

## 🐛 常见问题

### Q: Docker 启动很慢
A: 首次启动需要下载镜像和安装依赖，需要等待 5-10 分钟。后续启动会快得多。

### Q: 端口 3000 或 5173 被占用
A: 修改 `docker-compose.yml` 中的端口映射：
```yaml
ports:
  - "3000:3000"  # 左边改成其他端口，如 3001:3000
```

### Q: 数据库连接失败
A: 
1. 检查 MySQL 容器是否运行：`docker-compose ps`
2. 查看日志：`docker-compose logs mysql`
3. 重启 MySQL：`docker-compose restart mysql`

### Q: 前端无法访问后端 API
A: 检查 `docker-compose.yml` 中的环境变量 `VITE_API_BASE_URL` 是否正确

### Q: 如何查看真实错误？
A: 运行 `docker-compose logs -f` 查看实时日志

---

## 🧹 清理

### 删除所有容器和数据
```bash
docker-compose down -v
```

### 删除未使用的镜像
```bash
docker image prune
```

### 完全卸载 Docker
- Windows: 控制面板 → 程序 → 卸载程序 → Docker Desktop
- Mac: 打开 Finder → Applications → 拖动 Docker 到废纸篓
- Linux: `sudo apt-get remove docker.io`

---

## 📚 更多帮助

- Docker 官方文档: https://docs.docker.com
- Docker Compose 文档: https://docs.docker.com/compose

有问题？运行 `docker-compose logs -f` 查看实时日志找出问题所在！