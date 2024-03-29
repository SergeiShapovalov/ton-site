#!/bin/bash



# Создаём раздел подкачки (иначе не на всех серверах запустится tonlib-cli)
mkdir -p /var/cache/swap/
dd if=/dev/zero of=/var/cache/swap/swap0 bs=64M count=64
chmod 0600 /var/cache/swap/swap0
mkswap /var/cache/swap/swap0
swapon /var/cache/swap/swap0
swapon -s

cd /root
mkdir TON
cd TON
apt-get update
apt install -y build-essential cmake clang openssl libssl-dev zlib1g-dev gperf wget git curl libreadline-dev ccache libmicrohttpd-dev
git clone --recurse-submodules https://github.com/ton-blockchain/ton.git
mkdir build
cd build
cmake ../ton
wget https://ton-blockchain.github.io/global.config.json
cmake --build . --target lite-client
cmake --build . --target func
cmake --build . --target fift
cmake --build . --target tonlib-cli
cmake --build . --target rldp-http-proxy
cmake --build . --target generate-random-id


