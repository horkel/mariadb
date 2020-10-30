## horkel/mariadb
FROM horkel/archlinux:2020.10.30
MAINTAINER AlphaTr <alphatr@alphatr.com>

COPY build.sh /build.sh
RUN /build.sh

EXPOSE 3306

CMD ["maria"]
