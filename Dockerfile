FROM alpine:latest

# 安装 openssh
RUN apk add --no-cache openssh-server zstd

# 设置 root 密码
RUN echo "root:1234" | chpasswd

# 允许 root 登录
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#Port 22/Port 10086/' /etc/ssh/sshd_config

# 生成 host key
RUN ssh-keygen -A

# 暴露端口
EXPOSE 10086

# 启动 sshd
CMD ["/usr/sbin/sshd","-D","-e"]
