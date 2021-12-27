* Nota: la tolerancia admitida en las respuestas es 4.

* Una empresa tiene una f�brica en la que produce piensos para animales.
* Ya se conocen los pedidos de los meses de
* febrero, marzo y abril: 3100, 3900 y 3800, respectivamente.
Sets
         i meses /enero, febrero, marzo, abril/
         t(i) meses que habilita para la venta /febrero, marzo, abril/
;

Parameter
         demanda(t) los pedidos de los siguientes meses
                 / febrero       3100
                   marzo         3900
                   abril         3800/
;

* La compa��a no est� obligada a satisfacer toda la demanda,
* aunque en la medida de lo posible lo har�.
* El mes de febrero tiene 20 d�as de producci�n,
* el mes de marzo 23 y el mes de abril 22
Parameter
         dias(t) dias de produccion
                 / febrero       20
                   marzo         23
                   abril         22/
;

* y la planta tiene una capacidad de producir 190 toneladas cada d�a.
Scalar produccion produccion por dia /190/;

* Al final del mes de enero tendr� un inventario de 150 toneladas
* que puede utilizar para servir la demanda del mes de febrero.
Scalar inventario_inicial inventario de mes enero /150/;

* Adem�s, tiene suficiente capacidad de inventario para 1200 toneladas,
* de forma que todo lo que produce y no dedica a atender la demanda de ese mes,
* se almacena para utilizarlo el mes siguiente.
Scalar capacidad capacidad maxima de inventario /1200/;

* Por motivos de seguridad, al final del mes de abril debe mantener un stock de 180.
Scalar inventario_final inventario de mes final de abril /180/;

* El coste de mantener el inventario de esta manera es de 6 euros por tonelada y mes.
Scalar coste_almacenamiento coste de mantener el inventario por tonelada y mes /6/;

* El coste de producci�n depende de cada mes (ya que debe comprar la matertia prima)
* y la estimaci�n es que ser� de 64, 71 y 69 euros por tonelada en febrero, marzo y abril, respectivamente.
Parameter
         coste(t) coste de produccion depende de cada mes
                 / febrero       64
                   marzo         71
                   abril         69/
;

* El ingreso neto por ventas (precio de venta menos costes de env�o normal)
* que recibe la compa��a por cada tonelada es de 76.

Scalars ingreso_neto ingreso neto por venta /76/;

* La compa��a debe determinar cu�nto fabricar cada mes y cu�nto debe vender cada mes.
* El objetivo es determinar la pol�tica que maximice la ganancia total
* (ingresos netos por la venta menos la suma de los costes de producci�n y de inventario).
* Formular un modelo completo de programaci�n lineal y resolverlo.
* La pol�tica �ptima es:
Free Variables
         z    ganancia total
;

Positive Variables
         p(t) produccion de mes i
         v(t) venta de mes i
         s(i) stock final de cada mes
;

Equations
         obj
         r_stock_balance(t) la cantidad de stock que queda al final de mes
         r_maxima_produccion(t) maxima produccion de mes i
         r_capacidad_stock(t) capacidad de almacenamiento
         r_demanda(t) maxima demanda de i mes
;
         obj.. z =e= sum(t, v(t)*ingreso_neto - p(t)*coste(t) - s(t)*coste_almacenamiento);
         r_stock_balance(t(i)).. s(t) =e= s(i-1)+p(t)-v(t);
         s.fx('enero') = inventario_inicial;
         s.lo('abril') = inventario_final;
         r_maxima_produccion(t).. p(t) =l= produccion * dias(t);
         r_capacidad_stock(t).. s(t) =l= capacidad;
         r_demanda(t).. v(t) =l= demanda(t);

* coding area
Model piensos /All/;
Solve piensos using LP maximizing z;
