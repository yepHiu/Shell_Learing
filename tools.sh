#!/bin/bash

# shell个人工具集合
# ip:获取本机ip地址
# path: 逐行输出环境路径
# compiler：输出已经安装的编译器


# 获取本机IP地址
get_ip() {
    ip=$(hostname -I)
    echo "本机IP地址:$ip"
}

# 逐行输出环境路径
output_path() {
    IFS=":" read -ra paths <<< "$PATH"
    echo "环境路径："
    for path in "${paths[@]}"; do
        echo "$path"
    done
}

# 根据输入参数执行对应的操作
if [ "$1" = "ip" ]; then
    get_ip
elif [ "$1" = "path" ]; then
    output_path
elif [ "$1" = "compiler" ]; then
    dpkg -l | grep compiler
else
    echo "无效参数！"
fi
