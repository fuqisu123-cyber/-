#!/bin/bash

echo "=========================================="
echo "🚀 启动无货源电商管理平台"
echo "=========================================="
echo ""

# 检查 Docker 是否安装
if ! command -v docker &> /dev/null; then
    echo "❌ Docker 未安装！"
    echo "请先下载安装 Docker Desktop:"
    echo "Windows/Mac: https://www.docker.com/products/docker-desktop"
    echo "Linux: sudo apt-get install docker.io"
    exit 1
fi

# 检查 Docker Compose 是否安装
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose 未安装！"
    exit 1
fi

echo "✅ Docker 已安装"
echo ""

# 创建必要的目录
echo "📁 创建项目目录..."
mkdir -p backend/dist
mkdir -p frontend/dist
mkdir -p database

echo ""
echo "🔨 构建 Docker 镜像..."
docker-compose build

echo ""
echo "🐳 启动 Docker 容器..."
docker-compose up -d

echo ""
echo "⏳ 等待服务启动（约30秒）..."
sleep 30

echo ""
echo "=========================================="
echo "✅ 启动完成！"
echo "=========================================="
echo ""
echo "📍 访问地址:"
echo "   前端: http://localhost:5173"
echo "   后端 API: http://localhost:3000/api"
echo ""
echo "🗄️ 数据库信息:"
echo "   Host: localhost"
echo "   Port: 3306"
echo "   Username: root"
echo "   Password: root"
echo "   Database: dropshipping_platform"
echo ""
echo "📝 查看日志:"
echo "   docker-compose logs -f"
echo ""
echo "🛑 停止服务:"
echo "   docker-compose down"
echo ""