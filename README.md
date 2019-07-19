# ssh_auto_login
ssh自动登录脚本

使用方法
```
function account(){
#下面是配置ssh账号的地方
#用户名	主机地址	端口号	密码/或者证书文件绝对地址
bandit	hostname.com	422
ubuntu2	hostname.com	222	xlh!@#\$1234
xulianhong	hostname.com	222	file_path.pem
}
```
1.在这个函数里面配置你的ssh账号密码，第四列可以是私钥证书或者ssh密码(遇到$要转义)  
2.需要安装expect  
3.chmod +x ssh  
4.开始连接  
```
./ssh.sh 40022
ssh bandit@home.series.com -p 422
spawn ssh bandit@home.series.com -p 422
Last login: Fri Jul 19 17:11:02 2019 from 13.11.29.52
[bandit@localhost ~]$
```
