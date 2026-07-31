# 汪潇 · NIO 求职作品集

品牌官号运营 / 内容策略 / KOC / 用户社群 / AIGC  
单页作品站，通过 **GitHub Pages** 公开链接分享给 Boss / HR。

## 本地预览

双击 `index.html`，或：

```bash
cd /Users/wangxiao/Desktop/NIO_Portfolio_WangXiao
python3 -m http.server 8080
```

浏览器打开 http://localhost:8080

## 发布到 GitHub Pages（推荐）

### 1. 注册 / 登录 GitHub

打开 [https://github.com](https://github.com)

### 2. 新建空仓库

1. 右上角 **+** → **New repository**
2. 建议设置：
   - **Repository name**：`nio-portfolio`（可自定义）
   - **Public**（公开，HR 可直接打开，免费账号一般都可选）
   - **不要**勾选 Add a README（本地已有文件）
3. 点 **Create repository**
4. 复制仓库地址，例如：  
   `https://github.com/你的用户名/nio-portfolio.git`

### 3. 本机推送

```bash
cd /Users/wangxiao/Desktop/NIO_Portfolio_WangXiao
./push-to-github.sh
```

按提示粘贴仓库地址和 **Personal Access Token**。

**Token 创建：**  
https://github.com/settings/tokens  
→ **Generate new token (classic)**  
→ 勾选 **`repo`**  
→ 生成后复制

### 4. 打开 GitHub Pages

1. 打开仓库 → **Settings → Pages**
2. **Source** 选 **GitHub Actions**
3. 到 **Actions** 页等 `Deploy GitHub Pages` 变绿
4. 再回 **Settings → Pages** 复制网址

常见地址：

```text
https://你的用户名.github.io/nio-portfolio/
```

### 5. 发给 HR

> 作品集（手机可打开）：https://你的用户名.github.io/nio-portfolio/

## 更新内容

```bash
cd /Users/wangxiao/Desktop/NIO_Portfolio_WangXiao
git add .
git commit -m "更新作品集"
./push-to-github.sh
```

## 目录

```text
.
├── index.html                 # 作品站主页
├── assets/                    # 案例图片
├── .github/workflows/pages.yml# 自动发布 Pages
├── push-to-github.sh          # 一键推送脚本
└── README.md
```
