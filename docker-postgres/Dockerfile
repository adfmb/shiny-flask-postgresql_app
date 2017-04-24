FROM postgres:9.6

MAINTAINER Eduardo Martínez <eduardo.martinez@itam.mx>

ENV REFRESHED_AT 2017-04-24

# seleccionar el usuario para que tenga permisos sobre la carpeta creada
USER postgres
RUN mkdir -p /tmp/psql_data/

EXPOSE 5432

# copiamos el archivo de statements SQL
COPY iris.sql /tmp/psql_data/
# lo agregamos al entrypoint para que se ejecute automáticamente cuando levante la BD
COPY init_db.sh /docker-entrypoint-initdb.d/