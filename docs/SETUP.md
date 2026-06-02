# 项目设置指南

## 快速开始

本指南将帮助你快速搭建和运行无货源电商管理平台。

## 前置要求

- Node.js >= 16.x
- npm >= 8.x 或 yarn >= 1.22.x
- MySQL >= 5.7
- Git

## 项目初始化

### 1. 数据库初始化

```bash
# 登录 MySQL
mysql -u root -p

# 执行初始化脚本
source database/schema.sql

# 验证数据库创建
USE dropshipping_platform;
SHOW TABLES;
```

### 2. 后端项目配置

```bash
cd backend

# 安装依赖
npm install

# 创建环境配置文件
cp .env.example .env

# 编辑 .env 文件，填写数据库连接信息
# DATABASE_HOST=localhost
# DATABASE_PORT=3306
# DATABASE_USER=root
# DATABASE_PASSWORD=your_password
# DATABASE_NAME=dropshipping_platform

# 启动开发服务器
npm run start:dev

# 服务器运行在 http://localhost:3000
```

### 3. 前端项目配置

```bash
cd frontend

# 安装依赖
npm install

# 创建环境配置文件
cat > .env.development << EOF
VITE_API_BASE_URL=http://localhost:3000/api
VITE_APP_TITLE=无货源电商管理平台
EOF

# 启动开发服务器
npm run dev

# 应用运行在 http://localhost:5173
```

## 项目结构说明

```
project/
├── frontend/                # Vue3 前端项目
│   ├── src/
│   ├── package.json
│   ├── vite.config.ts
│   ├── tsconfig.json
│   └── README.md
│
├── backend/                 # NestJS 后端项目
│   ├── src/
│   ├── package.json
│   ├── tsconfig.json
│   ├── .env.example
│   └── README.md
│
├── database/                # 数据库脚本
│   ├── schema.sql           # 数据库表结构和初始数据
│   └── README.md
│
├── docs/                    # 项目文档
│   ├── API.md              # API 文档
│   ├── DATABASE.md         # 数据库设计文档
│   ├── SETUP.md            # 本文件
│   └── README.md
│
└── README.md               # 项目总体说明
```

## 开发工作流

### 后端开发

```bash
cd backend

# 开发模式（自动重启）
npm run start:dev

# 构建项目
npm run build

# 运行生产版本
npm run start:prod

# 运行测试
npm run test

# 代码检查
npm run lint
```

### 前端开发

```bash
cd frontend

# 开发模式（热更新）
npm run dev

# 生产构建
npm run build

# 本地预览构建结果
npm run preview

# 代码检查
npm run lint

# 代码格式化
npm run format
```

## 功能模块开发指南

### 1. 添加新的后端 API

后端采用模块化设计，每个功能模块包含：
- Controller（路由处理）
- Service（业务逻辑）
- Entity（数据库实体）
- DTO（数据传输对象）
- Module（模块定义）

```bash
# 在 backend/src/modules 下创建新模块
backend/src/modules/
├── your-module/
│   ├── your-module.controller.ts
│   ├── your-module.service.ts
│   ├── your-module.module.ts
│   ├── entities/
│   │   └── your-entity.entity.ts
│   └── dto/
│       ├── create-your-module.dto.ts
│       └── update-your-module.dto.ts
```

### 2. 添加新的前端页面

前端采用 Vue 3 Composition API，主要包括：
- Pages（页面组件）
- Components（可复用组件）
- Stores（Pinia 状态）
- API（数据请求）

```bash
# 在 frontend/src/pages 下创建新页面
frontend/src/pages/
├── your-page/
│   ├── YourPage.vue
│   └── components/
│       └── YourComponent.vue

# 在 frontend/src/api 下添加 API 请求
frontend/src/api/
└── your-module.ts

# 在 frontend/src/stores/modules 下添加状态管理
frontend/src/stores/modules/
└── your-module.ts
```

## 常见开发任务

### 添加新的数据表

1. 修改 `database/schema.sql`
2. 在后端创建 Entity 类
3. 配置 TypeORM 关系
4. 创建对应的 DTO 和 Controller

### 集成第三方 API

1. 在 `.env` 中添加 API Key
2. 创建新的 Service 处理 API 调用
3. 添加错误处理和日志
4. 在 Controller 中暴露接口

### 数据库查询优化

1. 为常用查询字段添加索引
2. 使用 TypeORM 的关系加载优化 N+1 查询
3. 定期运行数据库分析命令
4. 监控慢查询日志

## 部署

### 前端部署

```bash
cd frontend

# 构建生产版本
npm run build

# 将 dist 目录下的文件部署到 Web 服务器
# 例如：Nginx、Apache、CDN 等
```

### 后端部署

```bash
cd backend

# 构建项目
npm run build

# 设置生产环境变量
# 编辑 .env 文件，更新数据库、JWT 等配置

# 启动服务
npm run start:prod

# 建议使用 PM2 进行进程管理
pm2 start dist/main.js --name "dropshipping-api"
```

### 使用 Docker

```bash
# 创建 Dockerfile
# 构建镜像
docker build -t dropshipping-backend .

# 运行容器
docker run -d -p 3000:3000 \
  -e DATABASE_HOST=mysql \
  -e DATABASE_NAME=dropshipping_platform \
  dropshipping-backend
```

## 监控和维护

### 日志管理
- 后端日志：使用 NestJS 内置日志或集成 winston
- 前端日志：使用浏览器开发者工具和远程日志服务

### 性能监控
- 使用 APM 工具监控性能
- 定期检查数据库性能
- 监控 API 响应时间

### 备份策略
- 定期备份数据库
- 使用 Git 进行代码版本控制
- 备份环境配置文件（除去敏感信息）

## 故障排查

### 常见问题

#### 1. 数据库连接失败
```
检查清单：
- MySQL 服务是否启动
- 数据库主机、用户名、密码是否正确
- 防火墙是否允许数据库连接
- 数据库是否已创建
```

#### 2. 后端服务无法启动
```
检查清单：
- Node.js 版本是否满足要求
- 依赖是否安装完整（npm install）
- 端口 3000 是否被占用
- 环境变量是否正确设置
```

#### 3. 前端 API 请求失败
```
检查清单：
- 后端服务是否运行
- API 地址是否正确
- 跨域配置是否正确
- 认证令牌是否有效
```

## 获取帮助

- 查看各模块的 README 文档
- 查看 API 文档：`docs/API.md`
- 查看数据库文档：`docs/DATABASE.md`
- 检查项目 Issue 和讨论

## 下一步

1. 根据业务需求扩展功能模块
2. 添加单元测试和集成测试
3. 设置 CI/CD 流程
4. 部署到测试/生产环境
5. 收集用户反馈，持续优化

---

**最后更新**: 2026-06-02
**维护者**: Your Team
**许可证**: MIT
