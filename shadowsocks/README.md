## shadowsocks

- **shadowsocks-libev version=3.2.3**
- **kcptun version=20181114**

### usage

**Client**

``` sh
docker run -dt --name ssc -p 1080:1080 buds/shadowsocks -r "remote_ip" -p "remote_port" -w "password" -m "mode"
```

**Server**

``` sh
TODO
```

### options

- `-s` : 指定运行在什么模式下，默认运行在客户端模式，指定则运行在服务端模式
- `-k` : 是否支持KCP，客户端模式下开启KCP则要求服务端也必须开启KCP,默认不开启，指定该参数则开启
- `-w` : ss的password参数
- `-m` : ss的method参数
- `-r` : 运行在客户端模式下时，远端服务器地址
- `-p` : 运行在客户端模式下时，远端服务器端口

### environments

| enviroment | comment | values |
|------------|---------|--------|
|SERVER_FLAG|是否为服务端，默认false| true, false |
|KCP_FLAG|是否开启 kcptun 支持, 默认为 fasle 禁用 kcptun| true, false |
|SS_PASSWORD|创建和链接ss时的password| 字符串 |
|SS_METHOD|创建和链接ss是的method, 默认aes-256-gcm | 参见ss的method参数 |
|SSS_SERVER_ADDR|创建ss服务端的ipv4地址，默认0.0.0.0 | |
|SSS_SERVER_PORT|创建ss服务端的端口号，默认8388 | |
|SSS_TIMEOUT|创建ss服务端的timeout参数，默认300 | |
|SSS_DNS_ADDRS|创建ss服务端的dns参数，默认"8.8.8.8,8.8.4.4" | |
|SSS_ARGS|其他未列举的ss服务端支持的参数,默认""| |

|SSC_SERVER_ADDR|创建ss客户端的ipv4地址，默认0.0.0.0| |
|SSC_REMOTE_ADDR|创建ss客户端时链接的远程服务器的ipv4地址，默认127.0.0.1| |
|SSC_REMOTE_ADDR|创建ss客户端时的端口号，默认1080| |
|SSC_ARGS|其他未列举的ss客户端支持的参数,默认""| |

|KCP_MODE|kcp服务端和客户端的工作模式, 默认fast2| 参见kcptun的mode参数 |
|KCP_MODE|kcp服务端或客户端的工作端口号, 默认8400| |
|KCP_ARGS|其他未列举的KCP支持的参数,默认""| |

使用时可指定环境变量，如下:

``` sh
TODO
```

### changelog

- 2018-12-23 first version

shadowsocks 3.2.3
