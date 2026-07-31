#!/bin/bash
# 一键推送到 GitHub Pages
# Token 只在本机保存一次，之后自动使用，无需重复输入
# 仓库: https://github.com/AdelaideWangXio/personaljd.git
#
# 用法:
#   ./push-to-github.sh           # 正常推送
#   ./push-to-github.sh --reset   # 清除已存 Token，下次重新输入

set -e
cd "$(dirname "$0")"

REPO_PATH="AdelaideWangXio/personaljd"
# 本机私密文件（已加入 .gitignore，不会上传到 GitHub）
TOKEN_FILE="$(pwd)/.github_token"
# 也可放在用户目录（二选一，优先项目内）
HOME_TOKEN_FILE="${HOME}/.config/github/adelaidewangxio.token"

if [[ "${1:-}" == "--reset" || "${1:-}" == "-r" ]]; then
  rm -f "$TOKEN_FILE" "$HOME_TOKEN_FILE"
  # 顺带清掉钥匙串里 github.com 凭证（可选，失败忽略）
  printf "protocol=https\nhost=github.com\n\n" | git credential-osxkeychain erase 2>/dev/null || true
  echo "已清除本地保存的 Token。下次推送时会再问一次。"
  exit 0
fi

if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "https://github.com/${REPO_PATH}.git"
else
  git remote add origin "https://github.com/${REPO_PATH}.git"
fi

# 用 macOS 钥匙串记住 HTTPS 密码，之后 git push 也不用输
git config --local credential.helper osxkeychain 2>/dev/null || true
git branch -M main

load_token() {
  if [[ -f "$TOKEN_FILE" ]]; then
    TOKEN="$(tr -d '[:space:]' < "$TOKEN_FILE")"
    return 0
  fi
  if [[ -f "$HOME_TOKEN_FILE" ]]; then
    TOKEN="$(tr -d '[:space:]' < "$HOME_TOKEN_FILE")"
    return 0
  fi
  return 1
}

save_token() {
  umask 077
  printf '%s\n' "$TOKEN" > "$TOKEN_FILE"
  chmod 600 "$TOKEN_FILE"
  # 写入钥匙串，方便以后直接 git push
  printf "protocol=https\nhost=github.com\nusername=x-access-token\npassword=%s\n\n" "$TOKEN" \
    | git credential-osxkeychain store 2>/dev/null || true
  echo "Token 已保存到本机（仅你电脑可见，不会提交到 GitHub）。"
}

if load_token && [[ -n "$TOKEN" ]]; then
  echo "目标仓库: https://github.com/${REPO_PATH}.git"
  echo "使用本机已保存的 Token 推送…"
else
  echo "目标仓库: https://github.com/${REPO_PATH}.git"
  echo "首次推送：请粘贴 GitHub Personal Access Token（输入时不显示），然后回车："
  echo "（classic Token，勾选 repo；保存后下次不用再输）"
  read -r -s TOKEN
  echo
  TOKEN="$(echo "$TOKEN" | tr -d '[:space:]')"
  if [[ -z "$TOKEN" ]]; then
    echo "错误：Token 为空，已取消。"
    exit 1
  fi
  save_token
fi

if git push -u "https://x-access-token:${TOKEN}@github.com/${REPO_PATH}.git" main; then
  echo ""
  echo "推送成功。"
  echo "作品页: https://adelaidewangxio.github.io/personaljd/"
  echo ""
  echo "之后直接运行 ./push-to-github.sh 即可，无需再输 Token。"
  echo "若 Token 失效，执行: ./push-to-github.sh --reset"
else
  echo ""
  echo "推送失败。若提示 401/403，可能是 Token 过期或权限不足。"
  echo "请执行: ./push-to-github.sh --reset  后重新粘贴新 Token。"
  exit 1
fi
