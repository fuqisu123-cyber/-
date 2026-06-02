-- 无货源电商管理平台数据库初始化脚本
-- MySQL 5.7+

-- 创建数据库
CREATE DATABASE IF NOT EXISTS dropshipping_platform CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE dropshipping_platform;

-- ==================== 用户系统表 ====================

-- 角色表
CREATE TABLE IF NOT EXISTS roles (
  id INT PRIMARY KEY AUTO_INCREMENT COMMENT '角色ID',
  name VARCHAR(50) UNIQUE NOT NULL COMMENT '角色名称',
  description VARCHAR(255) COMMENT '角色描述',
  status ENUM('active', 'inactive') DEFAULT 'active' COMMENT '状态',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色表';

-- 权限表
CREATE TABLE IF NOT EXISTS permissions (
  id INT PRIMARY KEY AUTO_INCREMENT COMMENT '权限ID',
  name VARCHAR(100) UNIQUE NOT NULL COMMENT '权限名称',
  description VARCHAR(255) COMMENT '权限描述',
  resource VARCHAR(100) COMMENT '资源',
  action VARCHAR(50) COMMENT '操作',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='权限表';

-- 角色权限关联表
CREATE TABLE IF NOT EXISTS role_permissions (
  id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'ID',
  role_id INT NOT NULL COMMENT '角色ID',
  permission_id INT NOT NULL COMMENT '权限ID',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  UNIQUE KEY unique_role_permission (role_id, permission_id),
  FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
  FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色权限关联表';

-- 用户表
CREATE TABLE IF NOT EXISTS users (
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

-- ==================== 商品系统表 ====================

-- 商品分类表
CREATE TABLE IF NOT EXISTS categories (
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

-- 商品表
CREATE TABLE IF NOT EXISTS products (
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

-- ==================== 货源系统表 ====================

-- 货源表
CREATE TABLE IF NOT EXISTS sources (
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

-- ==================== 比价系统表 ====================

-- 价格对比表
CREATE TABLE IF NOT EXISTS price_comparisons (
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

-- 价格预警表
CREATE TABLE IF NOT EXISTS price_alerts (
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

-- ==================== 销售系统表 ====================

-- 销售订单表
CREATE TABLE IF NOT EXISTS orders (
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

-- 销售统计表
CREATE TABLE IF NOT EXISTS sales_statistics (
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

-- ==================== 数据分析表 ====================

-- 搜索关键词表
CREATE TABLE IF NOT EXISTS search_keywords (
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

-- ==================== 初始数据插入 ====================

-- 插入默认角色
INSERT INTO roles (name, description, status) VALUES 
('admin', '管理员', 'active'),
('seller', '卖家', 'active'),
('viewer', '查看者', 'active');

-- 插入默认权限
INSERT INTO permissions (name, description, resource, action) VALUES 
('user.create', '创建用户', 'user', 'create'),
('user.read', '查看用户', 'user', 'read'),
('user.update', '更新用户', 'user', 'update'),
('user.delete', '删除用户', 'user', 'delete'),
('product.create', '创建商品', 'product', 'create'),
('product.read', '查看商品', 'product', 'read'),
('product.update', '更新商品', 'product', 'update'),
('product.delete', '删除商品', 'product', 'delete'),
('source.create', '创建货源', 'source', 'create'),
('source.read', '查看货源', 'source', 'read'),
('source.update', '更新货源', 'source', 'update'),
('source.delete', '删除货源', 'source', 'delete'),
('order.read', '查看订单', 'order', 'read'),
('analysis.read', '查看分析', 'analysis', 'read'),
('dashboard.read', '查看仪表盘', 'dashboard', 'read');

-- 为管理员角色分配所有权限
INSERT INTO role_permissions (role_id, permission_id)
SELECT 1, id FROM permissions;

-- 为卖家角色分配部分权限
INSERT INTO role_permissions (role_id, permission_id)
SELECT 2, id FROM permissions WHERE resource IN ('product', 'source', 'order', 'analysis', 'dashboard');

-- 为查看者角色分配查看权限
INSERT INTO role_permissions (role_id, permission_id)
SELECT 3, id FROM permissions WHERE action = 'read';

-- 插入默认商品分类
INSERT INTO categories (name, description, parent_id, sort, status) VALUES 
('女装', '女士服装', NULL, 1, 'active'),
('男装', '男士服装', NULL, 2, 'active'),
('鞋类', '各类鞋履', NULL, 3, 'active'),
('配饰', '服装配饰', NULL, 4, 'active'),
('家居', '家居用品', NULL, 5, 'active');

-- ==================== 数据库优化 ====================

-- 分析所有表
ANALYZE TABLE roles;
ANALYZE TABLE permissions;
ANALYZE TABLE role_permissions;
ANALYZE TABLE users;
ANALYZE TABLE categories;
ANALYZE TABLE products;
ANALYZE TABLE sources;
ANALYZE TABLE price_comparisons;
ANALYZE TABLE price_alerts;
ANALYZE TABLE orders;
ANALYZE TABLE sales_statistics;
ANALYZE TABLE search_keywords;
