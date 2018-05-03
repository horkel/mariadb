## horkel/mariadb
FROM horkel/archlinux:2017.11.22
MAINTAINER AlphaTr <alphatr@alphatr.com>

COPY build.sh /build.sh
RUN /build.sh

EXPOSE 3306

CMD ["mariadb-entrypoint"]
