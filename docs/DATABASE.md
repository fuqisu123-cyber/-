# 数据库设计文档

## 数据库概述

本项目使用 MySQL 数据库，采用 TypeORM 进行 ORM 管理。

## 表结构设计

### 1. 用户表 (users)

```sql
CREATE TABLE users (
  id INT PRIMARY KEY AUTO_INCREMENT COMMENT '用户ID',
  username VARCHAR(50) UNIQUE NOT NULL COMMENT '用户名',
  email VARCHAR(100) UNIQUE NOT NULL COMMENT '邮箱',
  password VARCHAR(255) NOT NULL COMMENT '密码（加密）',
  phone VARCHAR(20) COMMENT '电话号码',
  real_name VARCHAR(50) COMMENT '真实姓名',
  avatar_url VARCHAR(255) COMMENT '头像URL',
  status ENUM('active', 'inactive', 'banned') DEFAULT 'active' COMMENT '用户状态',
  role_id INT COMMENT '角色ID',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  deleted_at TIMESTAMP NULL COMMENT '删除时间（软删除）',
  FOREIGN KEY (role_id) REFERENCES roles(id),
  INDEX idx_username (username),
  INDEX idx_email (email),
  INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';
```

### 2. 角色表 (roles)

```sql
CREATE TABLE roles (
  id INT PRIMARY KEY AUTO_INCREMENT COMMENT '角色ID',
  name VARCHAR(50) UNIQUE NOT NULL COMMENT '角色名称',
  description VARCHAR(255) COMMENT '角色描述',
  status ENUM('active', 'inactive') DEFAULT 'active' COMMENT '状态',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色表';
```

### 3. 权限表 (permissions)

```sql
CREATE TABLE permissions (
  id INT PRIMARY KEY AUTO_INCREMENT COMMENT '权限ID',
  name VARCHAR(100) UNIQUE NOT NULL COMMENT '权限名称',
  description VARCHAR(255) COMMENT '权限描述',
  resource VARCHAR(100) COMMENT '资源',
  action VARCHAR(50) COMMENT '操作',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='权限表';
```

### 4. 角色权限关联表 (role_permissions)

```sql
CREATE TABLE role_permissions (
  id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'ID',
  role_id INT NOT NULL COMMENT '角色ID',
  permission_id INT NOT NULL COMMENT '权限ID',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  UNIQUE KEY unique_role_permission (role_id, permission_id),
  FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
  FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色权限关联表';
```

### 5. 商品分类表 (categories)

```sql
CREATE TABLE categories (
  id INT PRIMARY KEY AUTO_INCREMENT COMMENT '分类ID',
  name VARCHAR(100) NOT NULL COMMENT '分类名称',
  description VARCHAR(255) COMMENT '分类描述',
  parent_id INT COMMENT '父分类ID',
  sort INT DEFAULT 0 COMMENT '排序',
  status ENUM('active', 'inactive') DEFAULT 'active' COMMENT '状态',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE SET NULL,
  INDEX idx_parent_id (parent_id),
  INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品分类表';
```

### 6. 商品表 (products)

```sql
CREATE TABLE products (
  id INT PRIMARY KEY AUTO_INCREMENT COMMENT '商品ID',
  sku VARCHAR(100) UNIQUE NOT NULL COMMENT 'SKU',
  name VARCHAR(255) NOT NULL COMMENT '商品名称',
  description TEXT COMMENT '商品描述',
  category_id INT COMMENT '分类ID',
  price DECIMAL(10, 2) NOT NULL COMMENT '售价',
  cost_price DECIMAL(10, 2) COMMENT '成本价',
  profit DECIMAL(10, 2) COMMENT '利润',
  profit_rate DECIMAL(5, 2) COMMENT '利润率（%）',
  stock INT DEFAULT 0 COMMENT '库存',
  cover_image VARCHAR(255) COMMENT '封面图片',
  images JSON COMMENT '商品图片数组',
  status ENUM('on_sale', 'off_shelf') DEFAULT 'on_sale' COMMENT '商品状态',
  user_id INT NOT NULL COMMENT '创建者ID',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  deleted_at TIMESTAMP NULL COMMENT '删除时间（软删除）',
  FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  INDEX idx_sku (sku),
  INDEX idx_category_id (category_id),
  INDEX idx_status (status),
  INDEX idx_created_at (created_at),
  FULLTEXT INDEX ft_name_description (name, description)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品表';
```

### 7. 货源表 (sources)

```sql
CREATE TABLE sources (
  id INT PRIMARY KEY AUTO_INCREMENT COMMENT '货源ID',
  product_id INT NOT NULL COMMENT '商品ID',
  source_type ENUM('1688', 'taobao', 'pdd') NOT NULL COMMENT '货源类型',
  source_url VARCHAR(500) COMMENT '货源链接',
  source_sku VARCHAR(100) COMMENT '货源SKU',
  source_price DECIMAL(10, 2) COMMENT '货源价格',
  stock INT DEFAULT 0 COMMENT '货源库存',
  shop_name VARCHAR(255) COMMENT '店铺名称',
  shop_rating DECIMAL(3, 2) COMMENT '店铺评分',
  quality_score INT COMMENT '质量评分',
  user_id INT NOT NULL COMMENT '创建者ID',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id),
  INDEX idx_product_id (product_id),
  INDEX idx_source_type (source_type),
  INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='货源表';
```

### 8. 价格对比表 (price_comparisons)

```sql
CREATE TABLE price_comparisons (
  id INT PRIMARY KEY AUTO_INCREMENT COMMENT '对比ID',
  product_id INT NOT NULL COMMENT '商品ID',
  source_1688_price DECIMAL(10, 2) COMMENT '1688价格',
  source_1688_url VARCHAR(500) COMMENT '1688链接',
  source_taobao_price DECIMAL(10, 2) COMMENT '淘宝价格',
  source_taobao_url VARCHAR(500) COMMENT '淘宝链接',
  source_pdd_price DECIMAL(10, 2) COMMENT '拼多多价格',
  source_pdd_url VARCHAR(500) COMMENT '拼多多链接',
  lowest_price DECIMAL(10, 2) COMMENT '最低价',
  lowest_source VARCHAR(50) COMMENT '最低价来源',
  user_id INT NOT NULL COMMENT '创建者ID',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id),
  INDEX idx_product_id (product_id),
  INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='价格对比表';
```

### 9. 价格预警表 (price_alerts)

```sql
CREATE TABLE price_alerts (
  id INT PRIMARY KEY AUTO_INCREMENT COMMENT '预警ID',
  product_id INT NOT NULL COMMENT '商品ID',
  alert_type ENUM('price_drop', 'stock_low', 'competitor_lower') NOT NULL COMMENT '预警类型',
  threshold DECIMAL(10, 2) COMMENT '阈值',
  trigger_value DECIMAL(10, 2) COMMENT '触发值',
  status ENUM('active', 'inactive', 'triggered') DEFAULT 'active' COMMENT '状态',
  user_id INT NOT NULL COMMENT '创建者ID',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id),
  INDEX idx_product_id (product_id),
  INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='价格预警表';
```

### 10. 销售订单表 (orders)

```sql
CREATE TABLE orders (
  id INT PRIMARY KEY AUTO_INCREMENT COMMENT '订单ID',
  order_no VARCHAR(50) UNIQUE NOT NULL COMMENT '订单号',
  user_id INT NOT NULL COMMENT '用户ID',
  product_id INT NOT NULL COMMENT '商品ID',
  quantity INT NOT NULL COMMENT '数量',
  price DECIMAL(10, 2) NOT NULL COMMENT '单价',
  total_amount DECIMAL(10, 2) NOT NULL COMMENT '总金额',
  status ENUM('pending', 'paid', 'shipped', 'delivered', 'cancelled') DEFAULT 'pending' COMMENT '订单状态',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (product_id) REFERENCES products(id),
  INDEX idx_order_no (order_no),
  INDEX idx_user_id (user_id),
  INDEX idx_status (status),
  INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='销售订单表';
```

### 11. 销售统计表 (sales_statistics)

```sql
CREATE TABLE sales_statistics (
  id INT PRIMARY KEY AUTO_INCREMENT COMMENT '统计ID',
  user_id INT NOT NULL COMMENT '用户ID',
  date DATE NOT NULL COMMENT '统计日期',
  total_orders INT DEFAULT 0 COMMENT '订单总数',
  total_sales DECIMAL(10, 2) DEFAULT 0 COMMENT '销售总额',
  total_profit DECIMAL(10, 2) DEFAULT 0 COMMENT '利润总额',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  FOREIGN KEY (user_id) REFERENCES users(id),
  UNIQUE KEY unique_user_date (user_id, date),
  INDEX idx_date (date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='销售统计表';
```

### 12. 搜索关键词表 (search_keywords)

```sql
CREATE TABLE search_keywords (
  id INT PRIMARY KEY AUTO_INCREMENT COMMENT '关键词ID',
  keyword VARCHAR(255) NOT NULL COMMENT '关键词',
  search_count INT DEFAULT 0 COMMENT '搜索次数',
  user_id INT COMMENT '用户ID',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
  INDEX idx_keyword (keyword),
  INDEX idx_search_count (search_count)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='搜索关键词表';
```

## 关键字段说明

- **status**: 枚举类型字段，用于标记各实体的状态
- **created_at/updated_at**: 时间戳字段，自动记录创建和更新时间
- **deleted_at**: 用于实现软删除，保留历史数据
- **JSON**: 用于存储复杂结构的数据
- **FULLTEXT INDEX**: 用于全文搜索

## 性能优化建议

1. **索引策略**:
   - 为频繁查询的字段添加索引
   - 为外键添加索引，加快关联查询
   - 避免索引过多，影响写入性能

2. **查询优化**:
   - 使用分页查询，避免一次加载大量数据
   - 定期进行表分析和优化

3. **数据备份**:
   - 定期备份数据库
   - 建议使用主从复制提高数据可用性

## 扩展建议

- 根据业务发展，可能需要添加审计日志表
- 可以添加消息通知表用于记录系统消息
- 可以添加操作日志表记录用户行为
