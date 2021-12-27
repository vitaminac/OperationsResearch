* Una refineria de petroleo
* puede destilar 4 tipos de crudo
Set i tipo de crudo /Ligero, Medio, Pesado, MuyPesado/;

Parameter coste /Ligero 11, Medio 9, Pesado 7, MuyPesado 5/;

* Dependiendo de las caracteristicas del crudo
* el proceso de refino da lugar a distintos
* derivados en diferentes porcentajes
Set j tipo de derivado
         /Gases, Naftas, Gasolina, Keroseno,
          GasOil, FuelOil, Asfalto/;

Table porcentaje(i,j) composicion
                 Gases  Naftas  Gasolina  Keroseno  GasOil  FuelOil  Asfalto
         Ligero  5      21.5    11.5      11.5      15.5    35       0
         Medio   2      18      9.0       9.0       14      48       0
         Pesado  0.4    17.1    6.5       7.4       13      55.6     100
;

Parameter demanda(j)
       / Gases        30
         Naftas       20
         Gasolina     60
         Keroseno     10
         GasOil       15
         FuelOil      40
         Asfalto      25/;

Free Variables
         z beneficio total
;

Positive Variables
         x(i) cantidad de crudo i utilizado
;

Equations
         obj coste total
         r_demanda(j)
;

obj.. z =e= sum(i, coste(i)*x(i));
r_demanda(j).. demanda(j) =l= sum(i, porcentaje(i,j)*x(i));

Model aceite /ALL/;
Solve aceite using LP minimizing z;
