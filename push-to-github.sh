#!/bin/bash
# 一键推送到 GitHub Pages 仓库
# 仓库: https://github.com/AdelaideWangXio/personaljd.git
# Token 需勾选: repo（classic）

set -e
cd "$(dirname "$0")"

REPO_PATH="AdelaideWangXio/personaljd"

if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "https://github.com/${REPO_PATH}.git"
else
  git remote add origin "https://github.com/${REPO_PATH}.git"
fi

git branch -M main

echo "目标仓库: https://github.com/${REPO_PATH}.git"
echo "请粘贴 GitHub Personal Access Token（输入时不显示），然后回车："
echo "（classic Token，勾选 repo 即可）"
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
echo "开启 GitHub Pages（只需做一次）："
echo "  1. 打开 https://github.com/${REPO_PATH}/settings/pages"
echo "  2. Build and deployment → Source 选「Deploy from a branch」"
echo "  3. Branch 选 main，文件夹选 / (root)，点 Save"
echo "  4. 等 1～2 分钟后访问："
echo "     https://adelaidewangxio.github.io/personaljd/"
