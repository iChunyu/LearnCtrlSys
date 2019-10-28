# 自动控制简介

本仓库包含自动控制系统的基础仿真及参数整定函数示例，旨在用于向非自动化专业而对自动控制感兴趣的同学分享基础的控制系统建模。

仓库使用前建议安装[Git]( https://git-scm.com/ )。

初次使用Git的用户，在第一次使用前需要打开**Git Bash**进行初始化配置，运行以下代码：

```git
git config --global user.name username  			# username替换为自己的用户名，建议英文
git config --global user.email 'emael@email.com' 	# 邮箱用单引号括起来
```



## 克隆仓库

对于Windows用户，安装Git后，在目标文件夹下打开**Git Bash Here**，运行以下命令即可：

```git
git clone https://github.com/iChunyu/SimpleCtrlSys.git
```



## 使用规则

为避免分支冲突，建议用户克隆仓库后新建分支，在新分支上进行自己的操作，当调试完成后，可合并到主分支上。简单起见，主分支选为默认分支**master**。

Git的使用规则可参考[Git官方教程]( https://git-scm.com/book/zh/v2 )。



## 常用命令

### 本地处理

尖括号如*<demo>*仅作为示例，使用时连同尖括号一起替换为相应命令。

```git
添加文件：		git add .
提交文件：		git commit
查看状态：		git status
查看历史：		git log --oneline --graph --all
创建分支：		git branch <myBranch>
切换分支：		git switch <myBranch>
分支合并：		git merge <myBranch>
冲突解决：		git checkout <FileName> --theirs (或--ours)
删除分支：		git branch -d <myBranch>
```

### 协同工作
```git
更新远程仓库到本地：	git fetch
合并远程分支到当前：	git merge origin/master
拉取远程分支到当前：	git pull		（更新并合并，等价于上面两命令之和）
推送本地分支到远程：	git push
```

