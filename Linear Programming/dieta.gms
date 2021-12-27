* Las necesidades minima diarias en la alimentacion de una persona son
Set i necesidades /proteina, calcio, vitamina/;
Parameter demanda(i)
         /proteina       700
          calcio         28
          vitamina       150/;

* Los alimentos disponible son cereales y lacteos,
Set j alimentos /cereal, lacteo/;
* cuyos costes son 0.3 y 0.35 euros respectivamente.
Parameter coste /cereal 0.3, lacteo 0.35/;
* La composicion por kg de alimento viene dada en la siguiente tabla
Table composicion(j, i)
         proteina        calcio          vitamina
cereal   30              2               10
lacteo   45              1               5
;

* Se pide determinar la cantidad diaria optima de cada alimento
Positive Variable x(j) kg de alimento j;
* minimizando el coste toal de alimentacion
Free Variable z;
Equations
         obj
         d_necesidades(i);
obj.. z =e= sum(j, x(j)*coste(j));
d_necesidades(i).. demanda(i) =l= sum(j,x(j)*composicion(j,i));

Model dieta /ALL/;
Solve dieta using LP minimizing z;