#!/bin/sh

# 1. 配置LAN口: 使用DHCP协议
uci set network.lan.proto='dhcp'

# 2. [优化可选] 设置 WAN 口为“无协议”，屏蔽其功能，避免干扰
# uci set network.wan.proto='none'

# 3. 删除旧的默认网关和DNS服务器设置，避免冲突
uci -q delete network.lan.gateway
uci -q delete network.lan.dns

# 4. 关闭LAN口的DHCP服务，由主路由负责分配IP地址
uci set dhcp.lan.ignore='1'

# 5. 放宽LAN区域的防火墙规则，确保可以访问Web后台
uci set firewall.@zone[0].input='ACCEPT'
uci set firewall.@zone[0].output='ACCEPT'
uci set firewall.@zone[0].forward='ACCEPT'

# 6. 提交所有更改
uci commit

# 7. 删除脚本本身，确保它只在第一次启动时运行
exit 0
