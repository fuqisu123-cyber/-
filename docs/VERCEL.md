# 部署到 Vercel

## 🚀 一键部署前端应用

点击下方按钮，自动部署前端到 Vercel（完全免费）：

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Ffuqisu123-cyber%2F-%2Ftree%2Fmain%2Ffrontend&project-name=dropshipping-frontend&repository-name=dropshipping-frontend-vercel&root-directory=frontend)

---

## 📋 部署步骤

### 第1步：点击上面的 "Deploy with Vercel" 按钮

### 第2步：使用 GitHub 账户登录
- 选择 "Sign in with GitHub"
- 授权 Vercel 访问你的 GitHub

### 第3步：配置项目
- 项目名称：可以自定义（默认：dropshipping-frontend）
- 根目录：选择 `frontend`
- 点击 "Deploy"

### 第4步：等待部署完成
- Vercel 会自动构建和部署你的应用
- 部署完成后会显示一个公网网址

### 第5步：访问你的应用
- 点击提供的网址即可访问前端应用

---

## 📊 部署完成后

你会获得一个可以直接访问的网址，格式如：
```
https://dropshipping-frontend-xxxxx.vercel.app
```

直接分享这个网址给任何人，他们都可以访问你的应用！

---

## ✨ 特点

- ✅ **完全免费**
- ✅ **自动HTTPS**
- ✅ **自动构建和部署**
- ✅ **支持自定义域名**
- ✅ **实时日志查看**
- ✅ **自动重新部署**（每次 GitHub 更新时）

---

## 🔄 后续更新

每次你在 GitHub 上更新代码，Vercel 都会自动重新构建和部署！

---

## 💡 关于后端 API

由于前端需要连接后端，如果后端还没有部署，你可以：

### 方案 1：使用本地后端
```bash
cd backend
npm run start:dev
```
然后修改前端的 API 地址指向本地：
```
http://localhost:3000/api
```

### 方案 2：部署后端到 Railway（推荐）
查看 `docs/RAILWAY.md`

---

有问题？查看 [Vercel 官方文档](https://vercel.com/docs)
