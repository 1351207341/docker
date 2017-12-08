FROM scratch

LABEL maintainer "lorenwe <lorenwe@kaolanet.com>" architecture="AMD64/x86_64"  alpineversion="3.7"

ADD alpine-minirootfs-3.7.0-x86_64.tar.gz /

RUN echo -e "http://mirrors.ustc.edu.cn/alpine/v3.7/main\nhttp://mirrors.ustc.edu.cn/alpine/v3.7/community" > /etc/apk/repositories

CMD ["/bin/sh"]