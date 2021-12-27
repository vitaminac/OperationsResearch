* Se desea maximizar la utilidad total de la seleccion dentro de un conjunto
* de n objetos de tal modo que no se sobrepase la capacidad b disponible
* conociendo tanto las utilidades v_j de cada objeto
* como los pesos de los mismo p_j

* En un camion se desean cargar mercanias de 5 tipos diferentes
* en cuanto a su peso, valor y volumen
Set i objeto /1*5/;

Binary Variable s(i) si el objeto j es seleccionado

Parameter peso(i)
         /1      5
          2      8
          3      3
          4      2
          5      7/;

Parameter volumen(i)
         /1      1
          2      8
          3      6
          4      5
          5      4/;

Parameter valor(i)
         /1      4
          2      7
          3      6
          4      5
          5      4/;

* Solo admite un peso mazimo de 112 y un volumen maximo de 109
Scalars
         max_peso        /112/
         max_volumen     /109/
;

Free Variables
         z  valor objetivo
;

Equations
         obj
         r_peso
         r_volumen
;
         obj.. z =e= sum(i, valor(i)*s(i));
         r_peso.. sum(i, s(i) * peso(i))=l=max_peso;
         r_volumen.. sum(i, s(i) * volumen(i))=l=max_volumen;


Model mochila /All/;
Solve mochila using MIP maximizing z;
