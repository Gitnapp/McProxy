#!/bin/sh

# 默认代理地址
DEFAULT_PROXY="127.0.0.1:1082"
CONFIG_FILE="$HOME/.bashrc" # 你可以根据需要修改为 ~/.zshrc 或其他 shell 配置文件

# 函数：显示当前代理设置
display_current_proxy() {
  echo "当前代理设置:"
  http_proxy_val=$(env | grep http_proxy | grep -v _REQUEST_)
  https_proxy_val=$(env | grep https_proxy | grep -v _REQUEST_)

  if [ -n "$http_proxy_val" ]; then
    echo "  HTTP 代理: $(echo "$http_proxy_val" | awk -F= '{print $2}')"
  else
    echo "  HTTP 代理: 未设置"
  fi

  if [ -n "$https_proxy_val" ]; then
    echo "  HTTPS 代理: $(echo "$https_proxy_val" | awk -F= '{print $2}')"
  else
    echo "  HTTPS 代理: 未设置"
  fi
  echo ""
}

# 函数：设置临时代理
set_temporary_proxy() {
  proxy_address="$1"
  if [ -z "$proxy_address" ]; then
    proxy_address="$DEFAULT_PROXY"
  fi
  export http_proxy="http://$proxy_address"
  export https_proxy="https://$proxy_address"
  echo "临时代理已设置为: $proxy_address"
}

# 函数：设置永久代理
set_permanent_proxy() {
  proxy_address="$1"
  if [ -z "$proxy_address" ]; then
    proxy_address="$DEFAULT_PROXY"
  fi

  if grep -q "http_proxy=" "$CONFIG_FILE"; then
    sed -i "s/export http_proxy=.*/export http_proxy=\"http:\/\/$proxy_address\"/" "$CONFIG_FILE"
  else
    echo "export http_proxy=\"http://$proxy_address\"" >> "$CONFIG_FILE"
  fi

  if grep -q "https_proxy=" "$CONFIG_FILE"; then
    sed -i "s/export https_proxy=.*/export https_proxy=\"https:\/\/$proxy_address\"/" "$CONFIG_FILE"
  else
    echo "export https_proxy=\"https://$proxy_address\"" >> "$CONFIG_FILE"
  fi

  echo "永久代理已设置为: $proxy_address"
  echo "请运行 'source $CONFIG_FILE' 或重启终端以使永久代理生效。"
}

# 函数：清除代理设置
clear_proxy() {
  unset http_proxy
  unset https_proxy
  echo "临时代理已清除"

  if grep -q "http_proxy=" "$CONFIG_FILE"; then
    sed -i "/export http_proxy=/d" "$CONFIG_FILE"
  fi
  if grep -q "https_proxy=" "$CONFIG_FILE"; then
    sed -i "/export https_proxy=/d" "$CONFIG_FILE"
  fi
  echo "永久代理设置已清除 (请运行 'source $CONFIG_FILE' 或重启终端以使永久清除生效)。"
}

# 函数：设置自定义临时代理
set_custom_proxy_temp() {
  read -p "请输入自定义代理地址 (格式: host:port): " custom_proxy
  if [[ -n "$custom_proxy" ]]; then
    set_temporary_proxy "$custom_proxy"
  else
    echo "未输入代理地址，操作取消。"
  fi
}

# 函数：设置自定义永久代理
set_custom_proxy_perm() {
  read -p "请输入自定义代理地址 (格式: host:port): " custom_proxy
  if [[ -n "$custom_proxy" ]]; then
    set_permanent_proxy "$custom_proxy"
  else
    echo "未输入代理地址，操作取消。"
  fi
}


# 主菜单循环
while true; do
  display_current_proxy
  echo "请选择操作:"
  echo "1. 设置临时代理 (默认: $DEFAULT_PROXY)"
  echo "2. 设置永久代理 (默认: $DEFAULT_PROXY)"
  echo "3. 设置自定义临时代理"
  echo "4. 设置自定义永久代理"
  echo "5. 清除代理设置"
  echo "0. 退出"
  read -p "请选择 (0-5): " choice

  case "$choice" in
  1)
    set_temporary_proxy
    ;;
  2)
    set_permanent_proxy
    ;;
  3)
    set_custom_proxy_temp
    ;;
  4)
    set_custom_proxy_perm
    ;;
  5)
    clear_proxy
    ;;
  0)
    echo "退出脚本。"
    exit 0
    ;;
  *)
    echo "无效选项，请重新选择。"
    ;;
  esac
  echo ""
done