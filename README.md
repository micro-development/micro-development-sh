# MicroDevelopmentCli Tool By sh


## 安装


```bash
git clone https://github.com/micro-development/micro-development-sh.git
cd micro-development-sh
cp it-md.sh /usr/bin/it-md # mac 会提示没有权限，前面加 sudo 即可
```


## 测试

然后在终端输入 `it-md` ， 看到下面的提示代表成功：

```bash
配置文件 config.sh 没找到
```

## API

###  配置文件

你的项目中会有个 `shell` 配置文件：`config.sh` , 格式内容如下：

```bash
all_module=("common" "basic" "devops" "write")

git_ssh_url='root@47.93.119.76'
git_namespace='micro-development-demo'
git_repo_prefix='it-admin-'
clone_target_path='src/base-resource/'
```

#### clone_target_path

依赖的仓库存储目录，基于 `config.sh` ，也就是执行命令时所在目录。

#### git_ssh_url

仓库主机地址，暂时支持 `ssh` 协议。

#### git_namespace

用户名或组织名。

#### git_repo_prefix

如果依赖的仓库命名有规律且规范，比如统一以什么开头，那么这就是仓库名称的前缀，没有规律可设置为空。

#### all_module

依赖的所有仓库列表，如果设置了 `git_repo_prefix` ，这个列表的名称则不需要增加前缀，如果没有前缀，这里需要写完整的前缀。

**最终在执行下面命令的时候，会通过上面的配置自动组装信息。**


### install

安装全部仓库或指定的仓库。

```bash
it-md install
```

不加 option ，安装全部，加了，安装指定仓库。

option 仓库名，如果传了这个参数，则必须存在 all_module 中。

内部执行 `git clone` 。

### update

更新全部仓库或指定的仓库。

```bash
it-md update [option?]
```


不加 option ，更新全部，加了，更新指定仓库。

option 仓库名，如果传了这个参数，则必须存在 all_module 中。

内部执行 `git pull` 。

### remove

移除指定的仓库。

```bash
it-md remove [option?]
```

option 仓库名，必传，必须存在 all_module 中。

内部仅删除依赖的仓库文件夹，不影响主仓库。（依赖的仓库如果变更时，需谨慎操作）

### commit

提交指定仓库的变更。

```bash
it-md commit repoName commitContent
```

内部对 `repoName`  执行  `git add . && git commit -am commitContent && git pull && git push` 。

**注意：**  commitContent 需要加引号。

### clear

删除安装的所有仓库文件夹。（直接删除 clone_target_path 路径）

