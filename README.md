# MicroDevelopmentCli Tool By sh


## 注意注意注意

此脚本属于使用 `shell` 语言编写，所以安装需要一些条件。

## 安装

**如果是 Linux or Mac 系统，直接按照下面操作即可。**

**如果是 Windows 系统，不可以直接在系统自带 cmd 终端，不支持，不支持，不支持。
建议安装 [git bash](https://gitforwindows.org/) , 安装成功之后，在 `git bash` 终端中执行下面命令即可。**

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

你的项目中会有个 `shell` 配置文件：`config.sh` , 格式内容,示例：

```bash
all_module=("common" "basic" "devops" "write")

git_ssh_url='git@github.com'
git_namespace='micro-development-demo'
git_repo_prefix='vue-admin-'
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
it-md install [option]
```

不加 option ，安装全部，加了，安装指定仓库。

option 仓库名，如果传了这个参数，则必须存在 all_module 中。

内部执行 `git clone` 。

示例

```bash
it-md install # 安装全部
it-md install common # 安装 common
```

### update

更新全部仓库或指定的仓库。

```bash
it-md update [option?]
```


不加 option ，更新全部，加了，更新指定仓库。

option 仓库名，如果传了这个参数，则必须存在 all_module 中。

内部执行 `git pull` 。


示例

```bash
it-md update # 更新全部
it-md update common # 更新 common
```

### remove

移除指定的仓库。

```bash
it-md remove [option?]
```

option 仓库名，必传，必须存在 all_module 中。

内部仅删除依赖的仓库文件夹，不影响主仓库。（依赖的仓库如果变更时，需谨慎操作）

示例

```bash
it-md remove common # 移除 common
```


### commit

提交指定仓库的变更。

```bash
it-md commit repoName commitContent
```

- repoName 必须，仓库名。
- commitContent 必须，提交日志信息。

内部对 `repoName`  执行  `git add . && git commit -am commitContent && git pull && git push` 。

**注意：**  commitContent 需要加引号。

示例

```bash
it-md commit common '修复xxxbug' # 提交 common 仓库，日志信息为：修复xxxbug
```

### clear

删除安装的所有仓库文件夹。（直接删除 clone_target_path 路径）

