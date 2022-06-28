ARG VERSION=18.04

FROM ubuntu:${VERSION}

LABEL creator="Lester Kubalalika"

RUN apt-get update \
    && apt-get -y install curl \
    && apt-get install wget \
    && apt-get install -y gnupg \
    && apt-get clean 

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN apt-get -y install postgresql

USER postgres

# RUN rm /var/run/postgresql/.s.PGSQL.5432.lock

RUN /etc/init.d/postgresql start \
    && psql --command "CREATE USER lkubalalika WITH SUPERUSER PASSWORD '#pass123';" \
    && createdb -O lkubalalika lkubalalika

RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/10/main/pg_hba.conf  

RUN echo "listen_addresses='*'" >> /etc/postgresql/10/main/postgresql.conf

EXPOSE 5432

VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

CMD ["/usr/lib/postgresql/10/bin/postgres", "-D", "/var/lib/postgresql/10/main", "-c", "config_file=/etc/postgresql/10/main/postgresql.conf"]






