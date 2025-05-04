#!/bin/bash
# Rozkład pociągu zdawczego do składnicy drewna

# Konfiguracja
export PGHOST=127.0.0.1
export PGPORT=5432
export PGDATABASE=baza
export PGUSER=uzytkownik
DB_PASSWORD=haslo
DB_SCHEMA=lmn
export PGCLIENTENCODING=WIN1250


#Wykaz pojazdów kolejowych w składzie pociągu
for i in */
do
    echo $i
    echo "Ewidencja"
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "obre_pol" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/obre_pol.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "dzew_pol" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/dzew_pol.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "gr_pkt" -a_srs "EPSG:2180" $i/gr_pkt.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "uzyt_pol" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/uzyt_pol.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "gmin_pol" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/gmin_pol.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "pow_pol" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/pow_pol.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "woj_pol" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/woj_pol.shp
    echo "Podział powierzchniowy"
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "oddz_pol" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/oddz_pol.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "wydz_pol" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/wydz_pol.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "od_pkt" -a_srs "EPSG:2180" $i/od_pkt.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "ow_pkt" -a_srs "EPSG:2180" $i/ow_pkt.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "oddz_lin" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/oddz_lin.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "pnsw_pol" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/pnsw_pol.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "les_pol" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/les_pol.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "obrl_pol" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/obrl_pol.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "nadl_pol" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/nadl_pol.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "siedl_pol" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/siedl_pol.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "siedl_lin" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/siedl_lin.shp
    echo "Komunikacja"
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "kom_lin" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/kom_lin.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "komp_lin" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/komp_lin.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "koms_lin" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/koms_lin.shp
    echo "Sytuacja"
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "bud_pol" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/bud_pol.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "ciek_lin" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/ciek_lin.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "syt_pol" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/syt_pol.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "syt_pkt" -a_srs "EPSG:2180" $i/syt_pkt.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "inz_pkt" -a_srs "EPSG:2180" $i/inz_pkt.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "uzbr_lin" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/uzbr_lin.shp
    #Ppoz
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "ppoz_pol" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/ppoz_pol.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "ppoz_pkt" -a_srs "EPSG:2180" $i/ppoz_pkt.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "kl_pal_dst_pol" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/kl_pal_dst_pol.shp
    #Ochrona przyrody
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "oprz_pol" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/oprz_pol.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "oprz_pkt" -a_srs "EPSG:2180" $i/oprz_pkt.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "hcvf_pol" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/hcvf_pol.shp
    #Użytkowanie lasu
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "low_pol" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/low_pol.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "low_pkt" -a_srs "EPSG:2180" $i/low_pkt.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "zreb_pol" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/zreb_pol.shp
    #Turystyka
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "tur_pkt" -a_srs "EPSG:2180" $i/tur_pkt.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "tur_lin" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/tur_lin.shp
    #Inne
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "npc" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/npc.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "tps" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/tps.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "ref_pol" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" $i/ref_pol.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "ol_pkt" -a_srs "EPSG:2180" $i/ol_pkt.shp
    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "os_p_pkt" -a_srs "EPSG:2180" $i/os_p_pkt.shp
done;
