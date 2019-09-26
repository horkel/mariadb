## horkel/mariadb
FROM horkel/archlinux:2019.09.26
MAINTAINER AlphaTr <alphatr@alphatr.com>

COPY build.sh /build.sh
RUN /build.sh

EXPOSE 3306

CMD ["maria"]
