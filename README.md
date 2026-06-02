# 无货源电商管理平台

## 项目简介

这是一个完整的无货源电商管理平台后台系统，专为电商卖家设计。支持多渠道货源管理、价格比对、利润计算等核心功能。

## 技术栈

### 前端
- Vue 3
- Element Plus
- TypeScript
- Vite
- Pinia (状态管理)
- Axios (HTTP 请求)

### 后端
- Node.js
- NestJS
- TypeORM
- MySQL
- JWT (身份认证)

## 核心功能

### 1. 商品管理
- 商品列表管理
- 商品分类管理
- 商品详情编辑
- 商品上下架控制

### 2. 货源管理
- 1688 货源集成
- 淘宝货源集成
- 拼多多货源集成
- 货源信息管理

### 3. 比价中心
- 同款商品价格对比
- 利润自动计算
- 价格预警机制

### 4. 数据分析
- 热门商品排行
- 热门关键词排行
- 销售统计分析
- 用户行为分析

### 5. 用户系统
- 用户登录注册
- 用户管理
- 角色权限管理 (RBAC)

### 6. 仪表盘
- 商品总数统计
- 利润统计展示
- 销售数据统计
- 关键数据概览

## 项目结构

```
project/
├── frontend/                    # Vue3 前端项目
│   ├── public/
│   ├── src/
│   │   ├── components/         # 通用组件
│   │   ├── pages/              # 页面组件
│   │   ├── stores/             # Pinia 状态管理
│   │   ├── api/                # API 请求模块
│   │   ├── utils/              # 工具函数
│   │   ├── router/             # 路由配置
│   │   ├── App.vue
│   │   └── main.ts
│   ├── package.json
│   ├── vite.config.ts
│   └── tsconfig.json
│
├── backend/                     # NestJS 后端项目
│   ├── src/
│   │   ├── modules/            # 功能模块
│   │   │   ├── auth/           # 认证模块
│   │   │   ├── user/           # 用户模块
│   │   │   ├── product/        # 商品模块
│   │   │   ├── source/         # 货源模块
│   │   │   ├── price/          # 比价模块
│   │   │   ├── analysis/       # 数据分析模块
│   │   │   └── dashboard/      # 仪表盘模块
│   │   ├── common/             # 公共模块
│   │   ├── database/           # 数据库配置
│   │   ├── config/             # 配置文件
│   │   ├── app.module.ts
│   │   └── main.ts
│   ├── package.json
│   ├── tsconfig.json
│   └── .env.example
│
├── database/                    # 数据库脚本
│   ├── schema.sql              # 数据库表结构
│   └── seed.sql                # 初始数据
│
└── docs/                        # 项目文档
    ├── API.md                  # API 文档
    ├── DATABASE.md             # 数据库设计文档
    └── SETUP.md                # 项目配置指南
```

## 快速开始

### 前置要求
- Node.js >= 16.x
- MySQL >= 5.7
- npm 或 yarn

### 安装和运行

详见各模块的 README 和 `docs/SETUP.md`

## 项目规划

- [x] 项目初始化
- [ ] 数据库设计完成
- [ ] 后端 API 开发
- [ ] 前端页面开发
- [ ] 集成测试
- [ ] 上线部署

## 许可证

MIT
