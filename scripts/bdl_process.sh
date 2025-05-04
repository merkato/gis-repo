#!/bin/bash
# Rozkład pociągu zdawczego do składu leśnego Kobiór
# Konfiguracja
# Konfiguracja
export PGHOST=127.0.0.1
export PGPORT=5432
export PGDATABASE=baza
export PGUSER=uzytkownik
DB_PASSWORD=haslo
DB_SCHEMA=bdl
export PGCLIENTENCODING=WIN1250

# Gdzie jest książka pokładowa
for z in *.zip; do unzip "$z"; done
# To się ma nazywać SKRJ
for f in */*.txt; do mv -- "$f" "${f%.txt}.csv"; done
# Poszukaj stron

for i in */
do
    echo $i
#Powierzchnia z numerem wewnętrznym
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" -nln "f_arodes" $i/f_arodes.csv
#Wydzielenie
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" -nln "f_subarea" $i/f_subarea.csv
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" -nln "g_subarea" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/G_SUBAREA.shp
#Leśnictwo
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" -nln "g_forest_range" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/G_FOREST_RANGE.shp
#Oddział
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" -nln "g_compartment" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/G_COMPARTMENT.shp
#warstwy drzewostanu
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" -nln "f_arod_storey" $i/f_arod_storey.csv
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" -nln "f_storey_species" $i/f_storey_species.csv
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" -nln "f_arod_category" $i/f_arod_category.csv
#Wskazówki gospodarcze
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" -nln "f_arod_cue" $i/f_arod_cue.csv
#Siedliska przyrodnicze
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" -nln "f_arod_prot_site" $i/f_arod_prot_site.csv
done;
