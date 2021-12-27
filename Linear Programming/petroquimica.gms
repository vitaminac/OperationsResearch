* Una petroquimica se dedica a producir
* fibra textil y plastico para botellas
* a partir de PTA Y EtG
Sets
         i /fibra, plastico/
         j /PTA, EtG/
;

* Las cantidades, expresadas en toneladas,
* de cada producto necesarias para producir
* una tonelada de cada uno de estos derivados
* viene dadas por

Table composition(i,j) composicion
                         PTA     EtG
         fibra           0.912   0.344
         plastico        0.966   0.365
;

* La venta en el mercado de fibra textil y de plastico
* da un beneficio de 30 t 36 euros por tonelada

Parameter precio_venta(i)
         / fibra    30
           plastico 36/
;

* Dispone de 260 toneladas de PTA y 150 toneladas

Parameter recurso(j)
         / PTA   260
           EtG   150/
;

Free Variables
         z beneficio total
;

Positive Variables
         x(i) tonelada de producto i
;

Equations
         beneficio beneficio total
         max_recurso(j) recursos disponibles
;

beneficio.. z =e= sum(i, precio_venta(i)*x(i));
max_recurso(j).. recurso(j) =g= sum(i, composition(i,j)*x(i));

Model petroquimica /ALL/;
Solve petroquimica using LP maximizing z;
