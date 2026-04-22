# Centos firewall

## open ports to acess firewall
- 查看防火墙是否开启： `systemctl status firewalld`
- 开启防火墙： `systemctl start firewalld`  关闭则start改为stop
- 查看所有开启的端口: `firewall-cmd --list-ports`
- 防火墙开启端口访问: `firewall-cmd --zone=public --add-port=80/tcp --permanent`
- 开启后需要重启防火墙才生效， 【重启命令】：  `firewall-cmd --reload`

## 其他常用命令

- `firewall-cmd --state`                          ##查看防火墙状态，是否是running
- `firewall-cmd --reload  `                        ##重新载入配置，比如添加规则之后，需要执行此命令
- `firewall-cmd --get-zones`                      ##列出支持的zone
- `firewall-cmd --get-services`                    ##列出支持的服务，在列表中的服务是放行的
- `firewall-cmd --query-service ftp`              ##查看ftp服务是否支持，返回yes或者no
- `firewall-cmd --add-service=ftp `               ##临时开放ftp服务
- `firewall-cmd --add-service=ftp --permanent `   ##永久开放ftp服务
- `firewall-cmd --remove-service=ftp --permanent`  ##永久移除ftp服务
- `firewall-cmd --add-port=80/tcp --permanent`    ##永久添加80端口 
- `firewall-cmd --remove-port=80/tcp --permanent`    ##永久添加80端口 
- `firewall-cmd --zone=public --list-ports`       ##查看已开放的端口
- 
- `iptables -L -n `                               ##查看规则，这个命令是和iptables的相同的
- `man firewall-cmd  ` 