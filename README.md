# magisk-juicity

自动启用 `Juicity` ，配置好节点后你只需要使用支持 `SOCKS5`/ `HTTP` 的代理工具使用 `127.0.0.1:[配置文件中的 listen 端口]` 即可连接 `Juicity` 节点

> 你需要在代理工具中将你的节点 IP 设置为绕过/直连，暂时发现通过magisk启动不支持使用域名节点因为无法将域名解析成IP，只能使用ip。

配置文件在 `/data/adb/Juicity/config.json`

开机自动启动 `juicity` 服务，如果不想要自动启动服务请在 magisk 模块中关闭该模块（关闭后不会自动启动服务，但可以手动启动服务）

启动：`/data/adb/modules/Juicity/juicity.init start`

重启：`/data/adb/modules/Juicity/juicity.init restart`

停止：`/data/adb/modules/Juicity/juicity.init stop`