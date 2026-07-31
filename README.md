# 汪潇 · NIO 求职作品集

品牌官号运营 / 内容策略 / KOC / 用户社群 / AIGC  
单页作品站，面向 Boss 直聘等场景通过 **GitLab Pages 链接** 分享。

## 本地预览

用浏览器直接打开 `index.html`，或在本目录执行：

```bash
python3 -m http.server 8080
```

访问 http://localhost:8080

## 发布到 GitLab Pages（推荐流程）

### 1. 在 GitLab 新建空项目

1. 打开 [https://gitlab.com](https://gitlab.com) 并登录（没有账号先注册）
2. 右上角 **New project** → **Create blank project**
3. 建议设置：
   - **Project name**：`nio-portfolio`（可自定义）
   - **Visibility**：Public（公开，HR 无需登录即可打开）
   - **不要**勾选 “Initialize repository with a README”（本地已有代码）
4. 创建后复制项目地址，例如：  
   `https://gitlab.com/你的用户名/nio-portfolio.git`

### 2. 本机推送代码

在终端进入本目录后执行（把地址换成你的）：

```bash
cd /Users/wangxiao/Desktop/NIO_Portfolio_WangXiao

git remote add origin https://gitlab.com/你的用户名/nio-portfolio.git
git branch -M main
git push -u origin main
```

若 GitLab 要求登录：

- 推荐使用 **Personal Access Token** 当密码  
  路径：GitLab → Avatar → Preferences → Access Tokens  
  勾选 `write_repository`，生成后复制保存
- 用户名填 GitLab 用户名，密码填 Token

### 3. 等待 Pages 部署完成

1. 打开项目页 → 左侧 **Build → Pipelines**
2. 等待最新流水线显示 **passed**（约 1～2 分钟）
3. 打开 **Deploy → Pages**，复制访问地址

常见地址格式：

```text
https://你的用户名.gitlab.io/nio-portfolio/
```

（若项目名或用户名不同，以 Pages 页面显示为准）

### 4. 发给 HR / 写进 Boss 简历

示例文案：

> 作品集（手机可打开）：https://你的用户名.gitlab.io/nio-portfolio/

## 更新内容

改完 `index.html` 或 `assets/` 后：

```bash
cd /Users/wangxiao/Desktop/NIO_Portfolio_WangXiao
git add .
git commit -m "更新作品集内容"
git push
```

推送后流水线会自动重新发布。

## 目录说明

```text
.
├── index.html          # 作品站主页
├── assets/             # 案例图片
├── .gitlab-ci.yml      # GitLab Pages 部署配置
└── README.md
```
