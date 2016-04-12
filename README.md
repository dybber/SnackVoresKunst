\#SnackVoresKunst
=================
Dette projekt blev til ifbm. Statens Kunstfonds weekend-hackathon:
"Hack vores kunst", 8.-10. april 2016.

Idéen er at gengive repræsentationer af værker fra kunstfondens
samling, i postkort-størrelse. Med konceptet håber vi at kunstfonden
kan gøre modtagerne nysgerrige og opsøge værket, hvor det er placeret
eller via fondens hjemmeside: <http://vores.kunst.dk>.

Postkorts-printeren vil kunne opstilles i et offentligt rum (station,
torv, posthus), så brugere kan få et unikt postkort printet fra
samlingen, mens de f.eks. venter på toget.

*Koncept:* Camilla Wriedt, Maja Laungaard Andersson, Annette
Finnsdottir, Anna Kirstine Rasmussen, Martin Dybdal

*Programmering:* Martin Dybdal

XY-plotter venligst udlånt af Morten Ydefeldt (<http://ydefeldt.com/>).

Programmering
-------------
Postkort-generatoren er skrevet i Processing, og  postkortet i både en
PDF-format og som en GCode fil (plotter instruktioner).

Først oversættes programmet:

    make

Derefter kan postkort genereres ved at kalde

    ./run.sh 12051

For at generere et postkort baseret på værket med OBJECT_ID 12051 i
<http://vores.kunst.dk> databasen.

### XY-plotter
XY-plotteren programmeres ved at sende den en sekvens af følgende 3
kommandoer (GCode):

Flyt til x,y (i lige linje):

    G1 X<float> Y<float> F4000

hvor 4000 er hastigheden i mm per minut.

Pen op:

    M03 S50

Pen ned:

    M03 S0

### Skriftsnit
Til at skrive tekst med plotteren har vi benyttet den meget simple
font fra spillet Asteroids (1979): <https://trmm.net/Asteroids_font>
