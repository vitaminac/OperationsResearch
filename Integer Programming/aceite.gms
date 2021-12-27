* Una empresa elabora un cierto alimento
* refinando diferentes tipos de aceite y mezclandolos
* Los tipos de aceite se clasifican en dos categorias
* vegetales (VEG1 y VEG2) y no vegetales (OIL1, OIL2 Y OIL3)
Sets
         i aceites /VEG1, VEG2, OIL1, OIL2, OIL3/
;

* La capacidad maxima de refino es de
* 200 Toneladas de aceite vegetal
Scalar max_vegetal /200/;
* Y 250 Tonelada de no vegetal
Scalar max_no_vegetal /250/;

* Por restricciones tecnologica
* la dureza del producto final
* debe estar entre 3 y 6 unidades
Scalar min_dureza /3/;
Scalar max_dureza /6/;

* Se puede asumir que la dureza se mezcla linealmente
* La dureza final es la media ponderada
* de la dureza de los distintos aceites utilizados en la mezcla
Parameters
         coste(i)
       / VEG1       110
         VEG2       120
         OIL1       130
         OIL2       110
         OIL3       115 /

         dureza
       / VEG1       8.8
         VEG2       6.1
         OIL1       2.0
         OIL2       4.2
         OIL3       5.0 /
;

* Cada tonelada de producto final se vende a un precio de 150
Scalar beneficio /150/;

Free Variables
         z beneficio total
;

Positive Variables
         x(i) cantidad de producto i
;

Equations
         obj beneficio total
         r_max_vegetal
         r_max_no_vegetal
         r_min_dureza
         r_max_dureza
;

obj.. z =e= sum(i, (beneficio-coste(i))*x(i));
r_max_vegetal.. max_vegetal =g= x('VEG1') + x('VEG2');
r_max_no_vegetal.. max_no_vegetal =g= x('OIL1') + x('OIL2') + x('OIL3');
r_min_dureza.. min_dureza*sum(i,x(i)) =l= sum(i,x(i)*dureza(i));
r_max_dureza.. max_dureza*sum(i,x(i)) =g= sum(i,x(i)*dureza(i));
Model aceite /ALL/;
Solve aceite using LP maximizing z;

* Se imponen las siguientes condiciones adicionales al problema

* El alimento final no puede contener mas de tres tipos de aceite diferentes
Binary Variable d(i) si usa i aceite;
Scalar M /9999999999/;
Scalar max_aceite /3/;
Equations
         r_max_aceite
         r_aceite_d(i) si no utiliza aceite i su cantidad se va 0
;
r_max_aceite.. sum(i,d(i)) =l= max_aceite;
r_aceite_d(i).. x(i) =l= M*d(i);

* Si el producto final contiene un cierto tipo de aceite,
* debe contener al menos 20 toneladas del mismo
Scalar min_cantidad /20/;
Equation r_min_cantidad(i);
r_min_cantidad(i).. x(i) =g= d(i) * min_cantidad;

* Si la mezcla contiene algun tipo de aceite vegetal (VEG1 O VEG2),
* entonces tambien debe contener aceite no vegetal de tipo 3 (OIL3)
Equation r_equilibrio;
r_equilibrio.. d('VEG1') + d('VEG2') =l= 2 * d('OIL3');

Model aceite_modificado /ALL/;
Solve aceite_modificado using MIP maximizing z;
