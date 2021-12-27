* Una empresa vende el producto P a un precio de 45 euros el kilo,
* con una demanda m�nima de 2000 kilos y m�xima de 3200 kilos
* (dentro de estos l�mites, la empresa decide qu� demanda atiende).
* Cada kilo tiene un coste de producci�n de 30 euros.
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

* seg�n los precios siguientes:
Table
         precios(i,j) precios de que suministrador i proporciona componente j
                 1       2
         A       3.76    5.27
         B       7.67    3.65
;

* Adem�s, cada suministrador exige que la cantidad suministrada
* de cada producto sea al menos el 25% del total que suministra.
Scalar min_requerido minimo cantidad de porcentaje de componente que hay que comprar /0.25/;

* Plantear un problema de programaci�n lineal para obtener
* la cantidad que debe comprar a cada suministrador
* con el fin de maximizar la ganancia (ingresos menos gastos)
* y producir dentro de los l�mites de la demanda.
* Nota: la tolerancia admitida en las respuestas es 10.
* Seg�n la soluci�n obtenida, la pol�tica �ptima es:
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
