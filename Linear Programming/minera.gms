* Una empresa minera produce lignito y antracita
Set i /lignito, antracita/;

* Puede vender toda la produccion que obtenga
* de ambos minerales con un beneficio unitario
* de 24 y 18 euros por tonelada vendida, respectivamente
Parameter beneficio(i)
         / lignito       24
           antracita     18/
;

* El proceso de produccion esta dividido en tres fases

Set j /Corte, Tamizado, Lavado/;

* La produccion requiere del uso de las tres fases
* durante los tiempo
Table tiempo(i,j)
                         Corte           Tamizado        Lavado
         lignito         3               3               4
         antracita       4               3               2
;

* Y la disponibilidad maxima de cada tipo de maquinas

Parameter disponibilidad(j)
         / Corte         12
           Tamizado      10
           Lavado        8 /

Free Variables
         z beneficio total
;

Positive Variables
         x(i) tonelada de producto i
;

Equations
         obj beneficio total
         max_recurso(j) recursos disponibles
;

obj.. z =e= sum(i, beneficio(i)*x(i));
max_recurso(j).. disponibilidad(j) =g= sum(i, tiempo(i,j)*x(i));

Model minera /ALL/;
Solve minera using LP maximizing z;
