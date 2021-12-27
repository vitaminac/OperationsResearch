* Una industria siderurgica va a producir
* un nuevo tipo de hierro mezclando
* 4 tipos diferentes de hierro,
* cada uno de ellos con distinta composicion
Sets
         i composicion /Carbono, Silicio, Manganeso/
         j tipo de hierro producido /1 * 4/
;

* La tabla siguiente indica estos contenidos
* y el precio unitario para los cuatro tipos de hierro
Table contenido(i,j) composicion
                         1       2       3       4
         Carbono         0.02    0.05    0       0
         Silicio         0.01    0       0.6     0.2
         Manganeso       0       0.01    0.4     0.8
;

Parameter coste(j)
       / 1     0.05
         2     0.04
         3     0.25
         4     0.35/;

* Las exigencias del mercado imponen que
* el hierro que se va a producir debe cubrir
* los minimo y maximo que aparecen recogidos en la siguiente tabla
Parameters
         min(i)
                 / Carbono       0.02
                   Silicio       0.02
                   Manganeso     0/

         max(i)
                 / Carbono       0.04
                   Silicio       0.05
                   Manganeso     0.01/
;

Free Variables
         z beneficio total
;

Positive Variables
         x(j) proporcion de hierro de tipo j que contiene la mezcla
;

Equations
         obj coste total
         r_min_composition(i)
         r_max_composition(i)
         r_sum_to_one
;

obj.. z =e= sum(j, coste(j)*x(j));
r_min_composition(i).. min(i) =l= sum(j, contenido(i,j)*x(j));
r_max_composition(i).. max(i) =g= sum(j, contenido(i,j)*x(j));
r_sum_to_one.. 1 =e= sum(j,x(j));

Model siderurgica /ALL/;
Solve siderurgica using LP minimizing z;
