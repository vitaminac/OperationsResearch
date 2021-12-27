* La empresa de productos l�cteos produce
* leche en polvo, postres l�cteos y quesos.
Set i producto /leche_polvo, postre, queso/;

* La fabricaci�n de cada producto requiere leche y
* dos tipos de procesos: esterilizaci�n y preparaci�n.
Set j recurso  /leche, esterilizacion, preparacion/;

* La cantidad de cada recurso necesaria para producir un kilogramo
* de cada producto aparece en la tabla siguiente:
Table
         necesita(i,j) recursos necesarios
                         leche     esterilizacion      preparacion
         leche_polvo     8         4                   3
         postre          6         2                   1.5
         queso           6         1.5                 0.5
;

* En la actualidad se dispone de 57 litros de leche,
* 21 horas de esterilizaci�n y 16 horas de preparaci�n.
Parameter recursos(j) recursos disponibles /leche 57, esterilizacion 21, preparacion 16/;

* El beneficio obtenido por la venta de un kilo de leche en polvo es 61 euros,
* por un kilo de postre l�cteo 32 euros y por un kilo de queso 17 euros.
Parameter precios(i) beneficio obtenido por la venta
         / leche_polvo      61
           postre           32
           queso            17/
;

* La empresa cree que puede vender toda la producci�n.
* Formular y resolver el problema al que se enfrenta la direcci�n de la empresa
* si su objetivo es maximizar beneficios. La soluci�n �ptima del problema es
Free Variables
         z
;

Positive Variables
         produccion(i) kilos de producto
;

Equations
         obj
         r_recurso(j) restriccion de limite de recurso
;
         obj.. z=e=sum(i, precios(i)*produccion(i));
         r_recurso(j).. sum(i, necesita(i, j)*produccion(i))=l=recursos(j)
* coding area
Model  ex1 /All/;
Solve ex1 using LP maximizing z;
