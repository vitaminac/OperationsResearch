* Una empresa vende el producto P a un precio de 45 euros el kilo,
* con una demanda mínima de 2000 kilos y máxima de 3200 kilos
* (dentro de estos límites, la empresa decide qué demanda atiende).
* Cada kilo tiene un coste de producción de 30 euros.
Scalar
         precio  precio del producto de P /45/
         coste   coste de la produccion de P /30/
         max_demanda demanda maxima /3200/
         min_demanda demanda minima /2000/
;

* El producto se hace a partir de 2 componentes, A y B,
Set i componente /A, B/;

* de forma que un kilo del producto P requiere dos kilos de la
* componente A y un kilo de la componente B.
Parameter necesita(i) kilos de compoenete que necesario /A 2, B 1/;

* Estas componentes se pueden comprar a dos suministradores,
Set j subministradores   /1, 2/;

* según los precios siguientes:
Table
         precios(i,j) precios de que suministrador i proporciona componente j
                 1       2
         A       3.76    5.27
         B       7.67    3.65
;

* Además, cada suministrador exige que la cantidad suministrada
* de cada producto sea al menos el 25% del total que suministra.
Scalar min_requerido minimo cantidad de porcentaje de componente que hay que comprar /0.25/;

* Plantear un problema de programación lineal para obtener
* la cantidad que debe comprar a cada suministrador
* con el fin de maximizar la ganancia (ingresos menos gastos)
* y producir dentro de los límites de la demanda.
* Nota: la tolerancia admitida en las respuestas es 10.
* Según la solución obtenida, la política óptima es:
Free Variables
         z
;

Positive Variables
         p kilos del producto P
         componente(i, j) kilo de componente i comprado en el suministrador j
;

Equations
         obj
         balance_mezcla(i) usos de recursos
         minimo_requerido(i, j) la cantidad suministrada de cada producto sea al menos el 25% de total que suministra
;
         p.lo = min_demanda;
         p.up = max_demanda;
         obj.. z=e=(precio-coste)*p-sum((i, j), precios(i,j)*componente(i, j));
         balance_mezcla(i).. necesita(i)*p =l= sum(j, componente(i, j));
         alias(i, k);
         minimo_requerido(i, j).. componente(i, j) =g= min_requerido * sum(k, componente(k, j));

* coding area
Model sumistradora /All/;
Solve sumistradora using LP maximizing z;
