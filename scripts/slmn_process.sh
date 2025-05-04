#!/bin/bash

# Konfiguracja
export PGHOST=127.0.0.1
export PGPORT=5432
export PGDATABASE=baza
export PGUSER=uzytkownik
DB_PASSWORD=haslo
DB_SCHEMA=slmn
export PGCLIENTENCODING=WIN1250

# Parametryzacja ogr2ogr z własnym SQL
function import_layer() {
    local layer_name="$1"
    local sql_query="SELECT *, SUBSTR('${f%.zip}', 5, 5) AS nadl, SUBSTR('${f%.zip}', 14, 6) AS dataimportu FROM $layer_name"
    ogr2ogr -update -append -f PostgreSQL \
        PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" \
        --config PG_USE_COPY YES -nln "$layer_name" -nlt PROMOTE_TO_MULTI -a_srs "EPSG:2180" "$i/$layer_name.shp" -sql "$sql_query"
}
function import_layer_dbf() {
    local layer_name="$1"
    local sql_query="SELECT *, SUBSTR('${f%.zip}', 5, 5) AS nadl, SUBSTR('${f%.zip}', 14, 6) AS dataimportu FROM $layer_name"

    ogr2ogr -update -append -f PostgreSQL PG:"password=$DB_PASSWORD active_schema=$DB_SCHEMA" --config PG_USE_COPY YES -nln "$layer_name" "$i/$layer_name.dbf" -sql "$sql_query"
}
# Main script
for f in *.zip; do
    unzip "$f" -d "${f%.zip}" > /dev/null 2>&1

    for i in */; do
        echo $i

        echo "Ewidencja"
        import_layer "a_dzew_pol"
        import_layer "a_gran_pkt"
        import_layer "a_uzyt_pol"

        echo "Podział powierzchniowy"
        import_layer "a_oddz_pol"
        import_layer "a_wydz_pol"
        import_layer "a_op_oddz_pkt"
        import_layer "a_op_wydz_pkt"
        import_layer "a_pnsw_pow"
        import_layer "a_les_pol"
        import_layer "a_les_pkt"
        import_layer "a_nadl_pkt"

        echo "Komunikacja"
        import_layer "a_kom_lin"
        import_layer_dbf "a_kom_a"
        import_layer "a_line_lin"
        import_layer_dbf "a_line_a"

        echo "Sytuacja"
        import_layer "a_bud_pol"
        import_layer "a_ciek_lin"
        import_layer_dbf "a_ciek_a"
        import_layer "a_infra_pow"
        import_layer "a_infra_pkt"
        import_layer "a_oprz_pow"
        import_layer "a_l_os_lin"

        echo "Ppoz"
        import_layer "a_pozar_pow"
        import_layer "a_pozar_pkt"

        echo "Ochrona przyrody"
        import_layer "a_os_prz_pow"
        import_layer "a_os_prz_pkt"

        rm -rf "$i"
    done
done