# NestJS 后端项目

## 项目介绍

这是无货源电商管理平台的后端服务，采用 NestJS + TypeORM + MySQL 技术栈。

## 技术栈

- **框架**: NestJS 9.x
- **ORM**: TypeORM 0.3.x
- **数据库**: MySQL 5.7+
- **认证**: JWT + Passport
- **加密**: bcryptjs
- **验证**: class-validator

## 项目结构

```
src/
├── modules/              # 业务模块
│   ├── auth/            # 认证模块
│   │   ├── auth.controller.ts
│   │   ├── auth.service.ts
│   │   ├── auth.module.ts
│   │   ├── dto/
│   │   ├── strategies/
│   │   └── guards/
│   ├── user/            # 用户模块
│   │   ├── user.controller.ts
│   │   ├── user.service.ts
│   │   ├── user.module.ts
│   │   ├── entities/
│   │   └── dto/
│   ├── product/         # 商品模块
│   │   ├── product.controller.ts
│   │   ├── product.service.ts
│   │   ├── product.module.ts
│   │   ├── entities/
│   │   └── dto/
│   ├── source/          # 货源模块
│   │   ├── source.controller.ts
│   │   ├── source.service.ts
│   │   ├── source.module.ts
│   │   ├── entities/
│   │   └── dto/
│   ├── price/           # 比价模块
│   │   ├── price.controller.ts
│   │   ├── price.service.ts
│   │   ├── price.module.ts
│   │   ├── entities/
│   │   └── dto/
│   ├── analysis/        # 数据分析模块
│   │   ├── analysis.controller.ts
│   │   ├── analysis.service.ts
│   │   ├── analysis.module.ts
│   │   └── dto/
│   └── dashboard/       # 仪表盘模块
│       ├── dashboard.controller.ts
│       ├── dashboard.service.ts
│       ├── dashboard.module.ts
│       └── dto/
├── common/              # 公共模块
│   ├── filters/         # 异常过滤器
│   ├── interceptors/    # 拦截器
│   ├── pipes/           # 管道
│   ├── guards/          # 守卫
│   ├── decorators/      # 装饰器
│   └── utils/           # 工具函数
├── config/              # 配置管理
│   ├── database.config.ts
│   ├── jwt.config.ts
│   └── app.config.ts
├── database/            # 数据库配置
│   └── typeorm.config.ts
├── app.module.ts        # 主模块
└── main.ts              # 入口文件
```

## 安装

```bash
# 安装依赖
npm install

# 创建 .env 文件
cp .env.example .env
```

## 运行

```bash
# 开发环境
npm run start:dev

# 生产环境
npm run build
npm run start:prod
```

## 数据库初始化

```bash
# 导入 schema.sql
mysql -u root -p dropshipping_platform < ../database/schema.sql
```

## API 文档

详见 `docs/API.md`

## 模块说明

### Auth 模块
- 用户登录
- 用户注册
- JWT 令牌管理
- 权限验证

### User 模块
- 用户管理
- 用户信息编辑
- 角色权限管理

### Product 模块
- 商品增删改查
- 商品分类管理
- 商品上下架

### Source 模块
- 货源管理
- 多渠道货源集成（1688、淘宝、拼多多）
- 货源信息同步

### Price 模块
- 价格对比
- 利润计算
- 价格预警

### Analysis 模块
- 销售数据分析
- 热门商品排行
- 热门关键词排行
- 用户行为分析

### Dashboard 模块
- 数据概览
- 销售统计
- 利润统计
- 关键指标展示

## 常见问题

### 1. 数据库连接失败
检查 .env 文件中的数据库配置是否正确

### 2. JWT 令牌过期
更新 JWT_EXPIRATION 配置或刷新令牌

### 3. 第三方 API 集成
填写 .env 中的相应 API Key 和 Secret

## 开发建议

1. 遵循 NestJS 最佳实践
2. 使用 TypeORM Repository 模式
3. 添加适当的错误处理和日志
4. 编写单元测试和 E2E 测试
5. 定期进行代码审查

## 许可证

MIT
