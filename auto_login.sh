#!/usr/bin/env bash
function account(){
#用户名	主机地址	端口号	密码/或者证书文件绝对地址
bandit	hostname.com	40022
ubuntu2	hostname.com	20022	xlh!@#\$1234
xulianhong	hostname.com	222	file_path.pem
}

num=(`wc -l $0`)
echo $num
accountStr=`head -n 10 $0 |grep $1`

account=(`echo $accountStr | tr '	' ' '`)
length=${#account[@]}
echo $length

sshCmd="ssh ${account[0]}@${account[1]} -p ${account[2]}"
if test $length -eq 4
then
	if test -e ${account[3]};
	then
		echo "auth by pem file"
		echo ${account[3]}
		sshCmd="ssh ${account[0]}@${account[1]} -p ${account[2]} -i ${account[3]}"
	else
		echo "auth by password"
	fi
fi
echo $sshCmd

TMP=$(mktemp)
# create expect script
cat > $TMP << EOF
#exp_internal 1 # Uncomment for debug
spawn $sshCmd
match_max 100000
expect {
"*yes/no" { send "yes\r"; exp_continue}  # 第一次ssh连接会提示yes/no,继续
"*?assword:*" { send_user ${account[3]};send ${account[3]}\r }    # 出现密码提示,发送密码
}
send -- "\r"
interact
EOF

/usr/bin/expect -f $TMP
rm $TMP
