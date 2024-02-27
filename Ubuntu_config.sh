#!/bin/bash

install_software() {
    software_name=$1

    echo "安装 $software_name"

    # 检查是否已经安装了软件
    if command -v "" &>/dev/null; then
        echo "$software_name 已经安装在系统中。"
        return 0
    fi

    # 安装软件
    echo "开始安装 $software_name ..."
    sudo apt update
    sudo apt install -y "$software_name"

    # 验证安装结果
    if command -v "$software_name" &>/dev/null; then
        echo "$software_name 安装成功！"
        return 0
    else
        echo "安装 $software_name 过程中出现问题，请检查错误信息。"
        return 1
    fi
}


echo "更换软件源:"
if [ -f "/etc/apt/sources.list" ]; then
    # 检查是否使用USTC源
    if grep -q "http://mirrors.ustc.edu.cn/ubuntu/" "/etc/apt/sources.list"; then
        echo "Ubuntu已更换为USTC软件源。"
    else
        echo "Ubuntu未更换为USTC软件源。"
	sudo sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list
	sudo sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
    fi
else
    echo "未找到Ubuntu的源配置文件。"
fi


cmd()
{
    shell=$1
    echo $shell
    $shell
}


echo "=============================================================="
echo "安装环境必要工具"
echo "=============================================================="

# 安装编译相关依赖
cmd "sudo apt install build-essential"

# 安装系统需要的工具
cmd "sudo apt install net-tools git net net-tools cmake wget"

# 安装内核编译需要的环境
cmd "sudo apt install git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc flex libelf-dev bison libncurses5-dev"

# 安装交叉编译器
cmd “sudo apt install”

# 关闭防火墙
cmd "sudo ufw disable"


# 获取环境路径，并使用":"为分隔符拆分为数组
IFS=":" read -ra paths <<< "$PATH"

# 逐行输出环境路径
for path in "${paths[@]}"; do
    echo "$path"
done