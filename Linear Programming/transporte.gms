* La compania PECE dispone de un centro de montaje
* situado en Madrid y un almacen en Zaragoza.
Set i origen /Madrid, Zaragoza/;

* Además cuenta con 8 grandes clientes situados en
* Madrid, Zaragoza, Bilbao, Barcelona, Valencia, Alicante, Albacete y Pamplona
Set j destino /Madrid, Zaragoza, Bilbao, Barcelona, Valencia, Alicante, Albacete, Pamplona/;

* La empresa disponen de 100 ordenadores de mesa en el centro de montaje
* y 45 en el almacen para servir la demanda de estos 8 clientes
Parameter ordenadres /Madrid 100, Zaragoza 45/;

Table coste(i,j)
                 Madrid          Zaragoza        Bilbao          Barcelona       Valencia        Alicante        Albacete        Pamplona
Madrid           14              24              21              20              21.5            19              17              30
Zaragoza         24              15              28              20              18.5            19.5            24              28
;

Parameter demanda(j)
/
Madrid           22
Zaragoza         14
Bilbao           18
Barcelona        17
Valencia         15
Alicante         13
Albacete         15
Pamplona         20
/;

Positive Variable x(i,j) cantidad transportada desde el origen i al destino j
Free Variable z coste total;
Equations
         obj
         r_demanda(j)
         r_recurso(i)
;

obj.. z =e= sum(i, sum(j, x(i,j)*coste(i,j)));
r_demanda(j).. demanda(j) =l= sum(i,x(i,j));
r_recurso(i).. ordenadres(i) =g= sum(j,x(i,j));

Model transporte /ALL/;
Solve transporte using LP minimizing z;