# gis-repo

Repozytorium użytecznych materiałów dla QGIS

## models

Modele podzielone na kategorie:

### lmn-analizy
1. gdzie_jest_straznik - Obliczanie granic runtów leśnych z gruntami obcymi w nadleśnictwie w podziale na leśnictwie. Pozdrawiamy 16-15
2. geupowanie_przyrody - Przypisanie do wydzieleń i tyld informacji o obszarach chronionych wg GDOŚ
3. wyznaczanie_stref_lasy_spoleczne - Wyznaczanie stref kategorii dla lasów społecznych (Work in progress, strefa 1)

### slmn-analizy
1. rozliczanie_tyld - Maszyna do oceny jakości rozliczania powierzchni użytko-wydzieleń oraz tyld
2. podzial_opodst_pod_droge - Na podstawie danych wyliczonych w rozliczanie_tyld oraz geometrii drogi projektowanej wytworzenie użytko-wydzieleń i tyld pod zmiany w SILP
3. zgodnosc_geometrii_dzialek - Porównywanie działek z SLMN oraz EGiB (dane WFS powiatów)

### slmn-kontrole

Mechanizmy kontroli zgodne z definicjami kontroli SLMN w Edytorze.

### ratownictwo
1. dojazdy_pozarowe_z_lesnictwem - Pobieranie aktualnych danych z Banku Danych o Lasach i podział dojazdów pożarowych na jednolite odcinki wewnątrz leśnictwa.
2. widocznosc_pozaru - Analiza widoczności zdarzenia z wskazanych punktów obserwacyjnych - typowanie miejsca wystąpienia zdarzenia.
3. gpr_ocena_dokladnosci_szybkich_trojek - Model do szkolenia GIS w OSP/ZK. Obliczenie obszarów niedostatecznie przeszukanych na podstawie danych BDL oraz SIRON
4. gpr_stozki_zapachowe_psa - Model pracy psa poszukiwawczego z tzw. stożkiem zapachowym - jakość przeszukania. (Work in Progress)

## scripts

Skrypty do importu danych SLMN, LMN (pochodne), BDL, OSM do Imposm (wymaga Imposm3).

## styles

### bdl

Style do wykorzystania z warstwami Banku Danych o Lasach

### egib-porownania

Style warstw wynikowych dla algorytmu zgodnosc_geometrii_dzialek

### lmn
Style dla wykorzystania z danymi warstw pochodnych

### slmn
Style do wykorzystania z danymi SLMN oraz jako style wynikowe dla algorytmu rozliczanie_tyld (slmn-analizy)

## svg

Symbole SVG do kompozycji map topograficznych, oraz tematycznych
