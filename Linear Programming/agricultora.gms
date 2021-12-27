* Una agricultora tiene 500 hectaareas de terreno
Scalar terreno /500/;

* Para cultivar trigo, maiz y caña de azucar.
Set
         i producto /trigo, maiz, cana/
;

* Ademas, necesita 200 toneladas de trigo y 240 de maiz

Parameter demanda(i)
         /trigo  200
          maiz   240
          cana   0/
;

* Para alimentar a su ganado, estos productos los puede
* obtener de su cosecha o comprarlos
* (a un precio de 240 y 210 euros la tonelada) de trigo y maiz respectivamente
Parameter coste_compra(i)
         /trigo  240
          maiz   210
          cana   0/
;

* Si con su produccion tiene suficiente,
* el sobrante lo puede vender
* a un precio de 170 y 150 la tonelada de trigo y maiz respectivamente
* La caña de azucar la puede vender a 36 euros por tonelada.
Parameter beneficio(i)
         /trigo  170
          maiz   150
          cana   36/
;

* Por experiencias anteriores,
* sabe que cada hectarea produce
* 2.3, 3 y 20 toneladas de trigo, maiz y cana de azucar respectivamente
Parameter produccion(i)
         /trigo  2.3
          maiz   3
          cana   20/
;

* y que el coste de plantar una hectarea
* de trigo, maiz y caña es de 150, 230 y 260 euros respectivamente.
Parameter coste_plantacion
         /trigo  150
          maiz   230
          cana   260/
;

* Plantear un modelo de Optimazacion Matematica Lineal
* que minimice el coste de la asignacion
Free Variables
         z coste total
;

Positive Variables
         x(i) hectareas empleadas para producto i
         c(i) toneladas de producto i compradas
         s(i) toneladas sobrantes de producto i
;

Equations
         obj funcion objetivo
         e_balance(i)
         r_terreno_total
;

obj.. z =e= sum(i, x(i)*coste_plantacion(i)
                  +c(i)*coste_compra(i)
                  -s(i)*beneficio(i));

e_balance(i).. x(i)*produccion(i) + c(i) =e= demanda(i) + s(i);
r_terreno_total.. sum(i, x(i)) =l= terreno;
c.fx('cana') = 0;

Model agricultora /ALL/;
Solve agricultora using LP minimizing z;

* La Union Europea ha puesto limites
* a la venta de caña de azucar,
* de forma que nuestra agricultora
* solo puede vender 6000 toneladas de caña de azucar a 36 euros,
Scalar limite /6000/;

* y todo lo que supere ese limite debe venderlo a solo 10 euros.
Positive Variable t toenladas de caña de azucar que super a 6000;
Scalar penalizacion;
penalizacion = beneficio('cana') - 10;

* Modificar el modelo convenientemente para incluir esta condicion
* penalizacion que supone cada tonelada que supere al limite
Free Variable z2 nuevo coste total;
Equations
         obj2 nueva funcion objetivo
         e_limite ecuacion de balance de limite
;

obj2.. z2 =e= z + t * penalizacion;
e_limite.. x('cana')*produccion('cana') =l= limite + t;
Model agricultora_modificada /ALL/;
Solve agricultora_modificada using LP minimizing z2;
