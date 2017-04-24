FROM postgres:9.6

MAINTAINER Eduardo Martínez <eduardo.martinez@itam.mx>

ENV REFRESHED_AT 2017-04-24

## Actualizamos
## RUN apt-get update \
##  && apt-get install -y postgresql postgresql-contrib \
##  && apt-get install sudo \
##  && apt-get clean \
##  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## Arreglamos el LOCALE
## RUN echo "es_MX.UTF-8 UTF-8" >> /etc/locale.gen \
##    && locale-gen es_MX.utf8 \
##    && /usr/sbin/update-locale LANG=es_MX.UTF-8 \
##    && dpkg-reconfigure locales


## Requerimientos
## ADD requirements.txt /tmp/requirements.txt
## RUN pip install -r /tmp/requirements.txt

USER postgres
RUN mkdir -p /tmp/psql_data/


## Copiamos nuestro hola mundo
## ADD iris.csv /tmp/iris.csv

EXPOSE 5432

## CMD ["/bin/bash","/etc/init.d/postgresql","start"]
## CMD ["/bin/bash","psql","postgres","-c","'createdb dpa'"] # createuser
## CMD ["csvsql","-i","postgresql","/tmp/iris.csv"]

COPY iris.sql /tmp/psql_data/
COPY init_db.sh /docker-entrypoint-initdb.d/