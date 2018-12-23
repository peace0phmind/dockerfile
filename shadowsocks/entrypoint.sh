#!/bin/sh

SERVER_FLAG=${SERVER_FLAG:-"false"}
KCP_FLAG=${KCP_FLAG:-"false"}

SS_PASSWORD=${SS_PASSWORD:-""}
SS_METHOD=${SS_METHOD:-"aes-256-gcm"}

SSS_SERVER_ADDR=${SSS_SERVER_ADDR:-"0.0.0.0"}
SSS_SERVER_PORT=${SSS_SERVER_PORT:-"8388"}
SSS_TIMEOUT=${SSS_TIMEOUT:-"300"}
SSS_DNS_ADDRS=${SSS_DNS_ADDRS:-"8.8.8.8,8.8.4.4"}
SSS_ARGS=${SSS_ARGS:-""}

SSC_SERVER_ADDR=${SSC_SERVER_ADDR:-"0.0.0.0"}
SSC_REMOTE_ADDR=${SSC_REMOTE_ADDR:-"127.0.0.1"}
SSC_SERVER_PORT=${SSC_SERVER_PORT:-"1080"}
SSC_ARGS=${SSC_ARGS:-""}

KCP_MODE=${KCP_MODE:-"fast2"}
KCP_PORT=${KCP_PORT:-"8400"}
KCP_ARGS=${KCP_ARGS:-""}

while getopts "skw:m:r:p:" OPT; do
    case $OPT in
        s)
            SERVER_FLAG="true";;
        k)
            KCP_FLAG="true";;
        w)
            SS_PASSWORD=$OPTARG;;
        m)
            SS_METHOD=$OPTARG;;
        r)
            SSC_REMOTE_ADDR=$OPTARG;;
        p)
            SSS_SERVER_PORT=$OPTARG;;
    esac
done

echo -e "\033[32mUse /dev/urandom to quickly generate high-quality random numbers......\033[0m"
rngd -r /dev/urandom

if [ "${SERVER_FLAG}" == "true" ]; then
    if [ "${KCP_FLAG}" == "true" ]; then
        echo -e "\033[32mStarting kcptun ......\033[0m"
        
        kcpserver \
          -t 127.0.0.1:$SSS_SERVER_PORT \
          -l :$KCP_PORT \
          -mode $KCP_MODE \
          2>&1 &
    else
        echo -e "\033[33mKcptun not started ......\033[0m"
    fi

    echo -e "\033[32mStarting shadowsocks ......\033[0m"
    ss-server \
      -s $SSS_SERVER_ADDR \
      -p $SSS_SERVER_PORT \
      -k ${SS_PASSWORD:-$(hostname)} \
      -m $SS_METHOD \
      -t $SSS_TIMEOUT \
      --fast-open \
      -d $SSS_DNS_ADDRS \
      -u \
      $SSS_ARGS
else
    if [ "${KCP_FLAG}" == "true" ]; then
        echo -e "\033[32mStarting kcptun ......\033[0m"
        
        kcpclient \
          -r $SSC_REMOTE_ADDR:$KCP_PORT \
          -l :$KCP_PORT \
          -mode $KCP_MODE \
          2>&1 &

        echo -e "\033[32mStarting shadowsocks ......\033[0m"

        ss-local \
          -s 127.0.0.1 \
          -p $KCP_MODE \
          -b $SSC_SERVER_ADDR \
          -l $SSC_SERVER_PORT \
          -m $SS_METHOD \
          -k $SS_PASSWORD \
          --fast-open \
          $SSC_ARGS
    else
        echo -e "\033[33mKcptun not started......\033[0m"
        echo -e "\033[32mStarting shadowsocks ......\033[0m"

        ss-local \
          -s $SSC_REMOTE_ADDR \
          -p $SSS_SERVER_PORT \
          -b $SSC_SERVER_ADDR \
          -l $SSC_SERVER_PORT \
          -m $SS_METHOD \
          -k $SS_PASSWORD \
          --fast-open \
          $SSC_ARGS
    fi
fi
