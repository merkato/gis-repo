#!/bin/bash

# Nazwa pliku CSV z konfiguracją
CONFIG_CSV_FILE="wfs_config.csv"

# Separator kolumn w pliku CSV (tabulator)
IFS=$'\t'

# Nagłówek dla komunikatów
echo "--- Skrypt pobierający dane WFS ---"

# Sprawdź, czy plik CSV istnieje
if [ ! -f "$CONFIG_CSV_FILE" ]; then
    echo "Błąd: Plik konfiguracyjny '$CONFIG_CSV_FILE' nie istnieje."
    echo "Stwórz plik '$CONFIG_CSV_FILE' z kolumnami: URL_WFS<tab>NAZWA_WARSTWY<tab>PLIK_GEOPACKAGE<tab>POLA_ATRYBUTOWE"
    exit 1
fi

echo "Przetwarzanie pliku konfiguracyjnego: '$CONFIG_CSV_FILE'"

# Przetwarzaj każdą linię z pliku CSV
# Używamy '<' do przekierowania pliku do pętli while
# -r: Zapobiega interpretacji backslashy
# || [ -n "$line" ]: Ważne dla ostatniej linii w pliku, jeśli nie kończy się znakiem nowej linii
while read -r wfs_url layer_name output_geopackage fields_to_select || [ -n "$wfs_url" ]; do

    # Usuń białe znaki na początku i końcu każdej zmiennej
    wfs_url=$(echo "$wfs_url" | xargs)
    layer_name=$(echo "$layer_name" | xargs)
    output_geopackage=$(echo "$output_geopackage" | xargs)
    fields_to_select=$(echo "$fields_to_select" | xargs)

    # Pomiń puste linie lub linie z nagłówkiem (jeśli pierwsza linia to nagłówek)
    if [[ -z "$wfs_url" || "$wfs_url" == "URL_WFS" ]]; then
        continue
    fi

    echo ""
    echo "--- Przetwarzanie wpisu ---"
    echo "  URL WFS: $wfs_url"
    echo "  Warstwa: $layer_name"
    echo "  Docelowy GeoPackage: $output_geopackage"
    echo "  Wybrane pola: $fields_to_select"

    # Tworzenie zapytania SQL do ogr2ogr
    # Zapewnij, że nazwa warstwy w SQL jest w podwójnych cudzysłowach, bo może zawierać dwukropki
    # Pamiętaj, że zawsze kopiujemy geometrię
    SQL_QUERY="SELECT "

    # Dodaj pola atrybutowe, jeśli są określone
    if [ -n "$fields_to_select" ]; then
        # Jeśli lista pól zawiera przecinki, podziel ją na poszczególne pola
        # i zabezpiecz każde pole przed problemami z nazwami w SQL (np. z kropkami)
        # Przykładowo, jeśli fields_to_select to "ID_DZIALKI,NAZWA"
        # to po modyfikacji będzie to "ID_DZIALKI", "NAZWA"
        IFS_OLD=$IFS
        IFS=',' read -ra ADDR <<< "$fields_to_select"
        IFS=$IFS_OLD
        FIELD_LIST=""
        for i in "${ADDR[@]}"; do
            if [ -n "$FIELD_LIST" ]; then
                FIELD_LIST+=","
            fi
            FIELD_LIST+="\"$i\""
        done
        SQL_QUERY+="$FIELD_LIST FROM \"$layer_name\""
    else
        # Jeśli brak pól atrybutowych, wybierz wszystko (tylko geometrię)
        SQL_QUERY+="* FROM \"$layer_name\""
    fi

    echo "  Zapytanie SQL: $SQL_QUERY"


    # Użyj ogr2ogr do pobrania warstwy
    # -f GPKG: Format wyjściowy GeoPackage
    # -update: Jeśli plik wyjściowy już istnieje, otwórz go do aktualizacji
    # -append: Dołącz nowe dane do istniejącej warstwy (o nazwie '$layer_name') lub utwórz nową
    #          Ważne: Jeśli chcemy wszystkie warstwy do jednego GPKG, ale w różnych warstwach w tym GPKG,
    #          to -append jest kluczowe w połączeniu z podaniem nazwy warstwy docelowej.
    # WFS:<URL>: Określa źródło danych WFS.
    # $layer_name: Nazwa warstwy, która ma być utworzona/zaktualizowana w docelowym GeoPackage.
    ogr2ogr -f GPKG -update -append \
            "$output_geopackage" \
            "WFS:$wfs_url" \
            -sql "$SQL_QUERY" \
            -nlt PROMOTE_TO_MULTI \
            -nln "$layer_name" # Określa nazwę warstwy docelowej w GeoPackage

    # Sprawdź kod wyjścia ogr2ogr
    if [ $? -ne 0 ]; then
        echo "  Błąd podczas pobierania z $wfs_url (warstwa: $layer_name). Kontynuowanie."
    else
        echo "  Pobrano pomyślnie."
    fi

done < "$CONFIG_CSV_FILE"

echo ""
echo "--- Zakończono przetwarzanie wszystkich wpisów. ---"
echo "Sprawdź wygenerowane pliki GeoPackage."

first_file=true
for f in *.gpkg; do
    if [ "$first_file" = true ]; then
        # Tworzymy nowy plik dzialki.gpkg z pierwszego pliku
        ogr2ogr dzialki.gpkg "$f" -nln dzialki
        first_file=false
    else
        # Dołączamy kolejne pliki, ignorując istniejącą warstwę i dodając nowe
        ogr2ogr -update -append dzialki.gpkg "$f" -nln dzialki -f GPKG
    fi
done

echo ""
echo "--- Zakończono łączenie plików ---"
echo "Sprawdź wygeneroway plik GeoPackage dla działek."