#!/bin/bash

# cur_path=$(pwd)
# echo $cur_path

if [ ! -f "config.sh" ];then
    echo -e "\033[31m 配置文件 config.sh 没找到 \033[0m"
    exit
fi

. config.sh

if [ ! -n $clone_target_path ];then
    echo -e "\033[31m 克隆目标路径不存在 \033[0m"
    help
    exit
fi

repo_name=$git_repo_prefix$2
# 仓库克隆到本地之后的完整路径，方便后面移除和更新使用
repo_path=$clone_target_path$repo_name
# 仓库远端ssh的完整URL
repo_url="$git_ssh_url:$git_namespace/$repo_name"

echo "repo_name：$repo_name"
echo "repo_path：$repo_path"
echo "repo_url：$repo_url"

# exit

# 上面的配置 install 和 update 和 remove 和 target 的时候都会需要，所以定义成变量
#=================================

# install all module
install (){
    # echo "start install all modules"
    for module in ${all_module[@]};
        do
            clone $module
    done
}

# update all module
update (){
    # echo "start update all modules"
    for module in ${all_module[@]};
        do
           pull $module
    done
}

# clone target repo
clone () {
    if [ ! -d "$repo_path$1" ];then
        echo "$repo_url$1.git <===> $repo_path <===>  $1"
        git clone "$repo_url$1.git" $repo_path$1
    else
        echoError "$repo_path$1 已存在"
    fi
}

# pull target repo
pull () {
    # debug log
    echo "repo path：$repo_path$1"
    if [ ! -d "$repo_path$1" ];then
        echoError "$repo_path$1 不存在"
    else
        git -C $repo_path$1 pull
    fi
}

# commit target repo
# exec add,commit,pull,push,pull
# 如果这种方式冲突，那么正常操作也必然会冲突，放心使用
commit () {
    # commit target path
    git -C $repo_path add . && git -C $repo_path commit -m "$2" && git -C $repo_path pull && git -C $repo_path push && git -C $repo_path pull
}

# help 帮助说明，命令不合法报错时，会给出提示，直接执行 ./it.sh 等同于输出此帮助
help () {
    echoGreen "<Help Start> <===================================> </Help Start>"
    echoError "！！！ 这个脚本的用途：用来操作 git仓库 作为 子目录 存在的场景，慎用 ！！！"
    echoGreen "it-md [command_name] [option]"
    echoGreen "Example"
    echoGreen "        it-md install                                      #安装本脚本内所有内置模块"
    echoGreen "        it-md install  module_name                         #安装本指定模块"
    echoGreen "        it-md update                                       #更新本脚本内所有内置模块"
    echoGreen "        it-md update   module_name                         #更新指定模块"
    echoGreen "        it-md commit   module_name     commit_contnet      #对子模块提交对子模块提交,注意：commit_content 必须加引号，这条git(add && commit && pull && push)"
    echoGreen "        it-md remove   module_name                         #删除指定模块"
    echoGreen "        it-md clear                                        #删除所有模块"
    echoGreen "<Help End> <=========================================> </Help End>"
}

# 输出成功颜色
echoGreen () {
    echo -e "\033[32m $1 \033[0m"
}

# 输出错误颜色
echoError () {
    echo -e "\033[31m $1 \033[0m"
}

case $1 in
    "install")
        if [ ! -n "$2" ]
            then
                install
                exit
        fi
        # echo "install $2 module"
        clone
        exit
        ;;
    "update")
        if [ ! -n "$2" ]
            then
                update
                exit
        fi
        # echo "update $2 module"
        pull
        ;;
    "commit")
        if [ ! -n "$2" ]
            then
                echoError "缺少第二个参数：提交代码必须指定模块名"
                help
                exit
        fi
        if [ ! -d $repo_path ]
            then
                echoError "模块不存在：$repo_path"
                help
                exit
        fi
        if [ ! -n "$3" ]
            then
                echoError "提交内容不能为空"
                help
                exit
        fi
        commit $2 $3
        ;;
    "remove")
        if [ ! -n "$2" ]
            then
                echoError "缺少第二个参数：模块名"
                help
                exit
        fi
        if [ ! -d $repo_path ];then
            echoError "该模块不存在：$repo_name"
            exit
        fi
        rm -rf  "$repo_path"
        ;;
    "clear")
        # echo "clear all module"
        rm -rf  $clone_target_path
        ;;
    *)
        help
esac