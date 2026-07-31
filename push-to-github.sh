#!/bin/bash
# 一键推送到 GitHub 并用于 GitHub Pages
# 用法：
#   1. 在 GitHub 新建空仓库（建议 Public，不要勾选 README）
#   2. 把下面 REPO 改成你的仓库地址（若已改过可忽略）
#   3. 执行：./push-to-github.sh
#   4. 粘贴 GitHub Personal Access Token（权限勾选 repo）

set -e
cd "$(dirname "$0")"

# ========== 改成你的仓库地址 ==========
REPO_HTTPS="https://github.com/你的用户名/nio-portfolio.git"
# =====================================

if [[ "$REPO_HTTPS" == *"你的用户名"* ]]; then
  echo "请先编辑本脚本，把 REPO_HTTPS 改成你的真实仓库地址。"
  echo "例如：https://github.com/wx6243631/nio-portfolio.git"
  echo ""
  read -r -p "或现在直接粘贴仓库 HTTPS 地址后回车: " INPUT
  if [ -z "$INPUT" ]; then
    echo "已取消。"
    exit 1
  fi
  REPO_HTTPS="$INPUT"
fi

# 去掉末尾 .git 再解析用户名（用于 token URL）
REPO_PATH="${REPO_HTTPS#https://github.com/}"
REPO_PATH="${REPO_PATH%.git}"

if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "https://github.com/${REPO_PATH}.git"
else
  git remote add origin "https://github.com/${REPO_PATH}.git"
fi

git branch -M main

echo "目标仓库: https://github.com/${REPO_PATH}.git"
echo "请粘贴 GitHub Personal Access Token（输入时不显示），然后回车："
echo "（创建地址: https://github.com/settings/tokens  → 勾选 repo）"
read -r -s TOKEN
echo
if [ -z "$TOKEN" ]; then
  echo "错误：Token 为空，已取消。"
  exit 1
fi

git push -u "https://x-access-token:${TOKEN}@github.com/${REPO_PATH}.git" main

echo ""
echo "推送成功。"
echo ""
echo "接下来开启 GitHub Pages："
echo "  1. 打开 https://github.com/${REPO_PATH}/settings/pages"
echo "  2. Build and deployment → Source 选「GitHub Actions」"
echo "  3. 打开 https://github.com/${REPO_PATH}/actions 等 Deploy 变绿"
echo "  4. 作品地址通常是："
echo "     https://$(echo "$REPO_PATH" | cut -d/ -f1).github.io/$(echo "$REPO_PATH" | cut -d/ -f2)/"
echo ""
echo "若 Actions 里 Pages 报错，也可改用分支发布："
echo "  Settings → Pages → Source 选 Deploy from a branch → Branch: main → / (root) → Save"
