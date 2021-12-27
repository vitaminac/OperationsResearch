* Una empresa de instalaciones dispone de 210 kg de cobre,
* 16 kg de titanio y 22 kg de aluminio.
Set j metal /cobre, titanio, alumnio/;

Parameter recurso(j) precios de venta de ordenadores
         / cobre         210
           titanio       16
           alumnio       22/
;

* Para fabricar 100 metros de cable de tipo A
* se necesitan 10 kg de cobre, 2 de titanio y 2 de aluminio,
* mientras que para fabricar 100 metros de cable de tipo B
* se necesitan 21 kg de cobre, 1 de titanio y 2 de aluminio.
Sets i cabre  /A, B/;

Table
         necesita(i,j) recursos necesarios
                         cobre     titanio      alumnio
         A               10        2            2
         B               21        1            2
;

* El beneficio que se obtiene por 100 metros de tipo A
* es de 1100 euros, y por 100 metros de tipo B, 700 euros.
Parameters
         beneficio(i) recurso necesario para fabricar cabre
                 / A             1100
                   B              700/
;

* Calcular los metros de cable de cada tipo que hay que fabricar
* para maximizar el beneficio de la empresa. Obtener dicho beneficio.
Free Variables
         z   beneficio total obtenido
;

Positive Variables
         x(i) centenas de cabre fabricado
;

Equations
         obj
         r_recurso(j) limite de recurso
;
         obj.. z =e= sum(i, x(i) * beneficio(i));
         r_recurso(j).. sum(i, x(i)*necesita(i,j)) =l= recurso(j);

* coding area
Model  cabre /All/;
Solve cabre using LP maximizing z;
