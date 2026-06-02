# Vue3 + Element Plus 前端项目

## 项目介绍

这是无货源电商管理平台的前端应用，采用 Vue 3 + Element Plus + TypeScript + Vite 技术栈。

## 技术栈

- **框架**: Vue 3.x
- **UI 框架**: Element Plus 2.x
- **路由**: Vue Router 4.x
- **状态管理**: Pinia
- **HTTP 客户端**: Axios
- **构建工具**: Vite
- **语言**: TypeScript

## 项目结构

```
src/
├── components/           # 通用组件
│   ├── common/          # 公共组件
│   ├── layout/          # 布局组件
│   └── ...
├── pages/               # 页面组件
│   ├── auth/            # 认证相关页面
│   │   ├── Login.vue
│   │   └── Register.vue
│   ├── dashboard/       # 仪表盘页面
│   │   └── Dashboard.vue
│   ├── product/         # 商品管理页面
│   │   ├── ProductList.vue
│   │   ├── ProductAdd.vue
│   │   └── ProductEdit.vue
│   ├── source/          # 货源管理页面
│   │   ├── SourceList.vue
│   │   └── SourceAdd.vue
│   ├── price/           # 比价中心页面
│   │   └── PriceComparison.vue
│   ├── analysis/        # 数据分析页面
│   │   ├── SalesAnalysis.vue
│   │   ├── HotProducts.vue
│   │   └── Keywords.vue
│   └── user/            # 用户管理页面
│       ├── UserList.vue
│       └── UserProfile.vue
├── stores/              # Pinia 状态管理
│   ├── modules/
│   │   ├── user.ts      # 用户状态
│   │   ├── product.ts   # 商品状态
│   │   ├── auth.ts      # 认证状态
│   │   └── app.ts       # 应用状态
│   └── index.ts
├── api/                 # API 请求模块
│   ├── auth.ts
│   ├── product.ts
│   ├── source.ts
│   ├── price.ts
│   ├── analysis.ts
│   ├── user.ts
│   └── request.ts       # Axios 实例配置
├── utils/               # 工具函数
│   ├── storage.ts       # 本地存储
│   ├── formatters.ts    # 格式化函数
│   ├── validators.ts    # 验证函数
│   └── ...
├── router/              # 路由配置
│   ├── index.ts
│   ├── guards.ts        # 路由守卫
│   └── routes/          # 路由定义
├── styles/              # 全局样式
│   ├── variables.scss   # 变量
│   ├── mixins.scss      # 混入
│   ├── index.scss       # 主样式
│   └── ...
├── types/               # TypeScript 类型定义
│   ├── index.ts
│   ├── api.ts
│   ├── entity.ts
│   └── ...
├── App.vue              # 根组件
├── main.ts              # 入口文件
└── env.d.ts             # 环境变量类型
```

## 安装

```bash
# 安装依赖
npm install

# 或使用 pnpm
pnpm install
```

## 运行

```bash
# 开发环境（含热更新）
npm run dev

# 生产环境构建
npm run build

# 本地预览构建结果
npm run preview
```

## 环境配置

在项目根目录创建以下文件：

```bash
# .env.development
VITE_API_BASE_URL=http://localhost:3000/api
VITE_APP_TITLE=无货源电商管理平台

# .env.production
VITE_API_BASE_URL=https://api.example.com/api
VITE_APP_TITLE=无货源电商管理平台
```

## 主要功能页面

### 1. 登录/注册
- 用户登录
- 用户注册
- 密码重置

### 2. 仪表盘
- 销售统计
- 利润统计
- 商品总数
- 关键指标

### 3. 商品管理
- 商品列表
- 添加商品
- 编辑商品
- 商品分类管理
- 商品上下架

### 4. 货源管理
- 货源列表
- 添加货源
- 货源编辑
- 多渠道货源集成

### 5. 比价中心
- 价格对比
- 利润计算
- 价格预警设置

### 6. 数据分析
- 销售数据分析
- 热门商品排行
- 热门关键词排行
- 用户行为分析

### 7. 用户管理
- 用户列表
- 用户编辑
- 角色权限管理

## 代码规范

### 命名规范
- 组件名使用 PascalCase
- 变量/函数名使用 camelCase
- 常量使用 UPPER_SNAKE_CASE
- 文件名使用 kebab-case 或 PascalCase

### 目录规范
- 所有组件放在 components 目录
- 所有页面放在 pages 目录
- 所有状态管理放在 stores 目录
- 所有 API 请求放在 api 目录

### 类型定义
- 使用 TypeScript 定义所有类型
- 在 types 目录下定义通用类型
- 在各模块下定义模块特定类型

## 常用命令

```bash
# 格式化代码
npm run format

# 代码检查
npm run lint

# 构建生产版本
npm run build

# 本地预览
npm run preview
```

## 浏览器支持

- Chrome/Edge: 最新两个版本
- Firefox: 最新两个版本
- Safari: 最新两个版本

## 常见问题

### 1. API 跨域问题
配置 vite.config.ts 中的 proxy 选项

### 2. 路由 404
检查路由配置和页面文件是否存在

### 3. 状态管理问题
确保在组件中正确导入和使用 store

## 许可证

MIT
