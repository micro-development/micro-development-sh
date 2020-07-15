## MicroDevelopmentCli Tool By sh

### 安装


```bash
git clone https://github.com/micro-development/micro-development-sh.git
cd micro-development-sh
cp it-md.sh /usr/bin/it-md # mac 会提示没有权限，前面加 sudo 即可
```


### 测试

然后在终端输入 `it-md` ， 看到下面的提示代表成功：

```bash
配置文件 config.sh 没找到
```

### API

### install

```bash
it-md install
```

安装 配置文件  `config.sh` 中的依赖仓库。 

### update

```bash
it-md update [repoName]
```

更新 配置文件  `config.sh` 中的依赖仓库。  

- repoName 指定仓库名

### remove

```bash
it-md remove repoName
```

移除 配置文件  `config.sh` 中指定的仓库。  

### commit

```bash
it-md commit repoName commitContent
```

提交 repoName , 提交日志为：commitContent

**注意：**  commitContent 需要加引号。

### clear

删除安装的所有仓库。

