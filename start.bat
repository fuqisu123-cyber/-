@echo off
echo =========================================
echo 启动无货源电商管理平台
echo =========================================
echo.

REM 检查 Docker 是否安装
where docker >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Docker 未安装！
    echo 请先下载安装 Docker Desktop:
    echo https://www.docker.com/products/docker-desktop
    pause
    exit /b 1
)

REM 检查 Docker Compose 是否安装
where docker-compose >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Docker Compose 未安装！
    pause
    exit /b 1
)

echo Docker 已安装
echo.

echo 构建 Docker 镜像...
docker-compose build

echo.
echo 启动 Docker 容器...
docker-compose up -d

echo.
echo 等待服务启动（约30秒）...
timeout /t 30 /nobreak

echo.
echo =========================================
echo 启动完成！
echo =========================================
echo.
echo 访问地址:
echo    前端: http://localhost:5173
echo    后端 API: http://localhost:3000/api
echo.
echo 查看日志:
echo    docker-compose logs -f
echo.
echo 停止服务:
echo    docker-compose down
echo.
pause