* Nota: la tolerancia m�xima admitida en las respuestas es 0.5.

* Un proceso de producci�n se compone de dos fases
Set i fases /1, 2/;

* y cada fase requiere de una maquinaria espec�fica.
* En el mercado hay varias m�quinas posibles para cada una de las fases,
* con caracter�sticas diferentes.
* La siguiente tabla muestra el coste de compra de cada m�quina,
* el coste de procesar una unidad de producto en cada m�quina
* y la capacidad m�nima y m�xima a la que deben funcionar:

* Fase 1
* Coste       Capacidad
* M�q.        Compra        Prod.        m�n        m�x
* M11         3750          8            700        950
* M12         750           9            850        1000
* M13         4500          10           550        850

* Fase 2
* Coste       Capacidad
* M�q.        Compra        Prod.        m�n        m�x
* M21         3000          12           400        600
* M22         6500          13           550        1200
* M23         250           11           550        600

Sets
         j Maquina /M11, M12, M13,
                    M21, M22, M23/
         f(i,j) fase /1.M11, 1.M12, 1.M13
                      2.M21, 2.M22, 2.M23/
;

Parameters
         precio(j) /M11 3750, M12 750,  M13 4500,
                    M21 3000, M22 6500, M23 250/

         coste(j)  /M11 8,    M12 9,    M13 10,
                    M21 12,   M22 13,   M23 11/

         min(j)    /M11 700,  M12 850,  M13 550,
                    M21 400,  M22 550,  M23 550/

         max(j)    /M11 950,  M12 1000, M13 850,
                    M21 600,  M22 1200, M23 600/
;

* Determinar la soluci�n que permite minimizar el coste de producci�n.
Free Variable z    coste total;

* Para resolver este roblema debe plantearse un modelo
* de optimizaci�n matem�tica con las siguientes variables:
* B ij, variable binaria que toma el valor 1
* si en la fase i se selecciona la m�quina j.
Binary Variable b(i, j) toma el valor 1 si en la fase i se selecciona la m�quina j;

* X ij, variable continua no negativa que
* representa la cantidad producida en la fase i por la m�quina j.

* El producto debe pasar por las dos fases.
Positive Variable x(i, j) la cantidad producida en la fase i por la maquina j;
Equation b_fase balance entre fase;
b_fase.. sum(j, x('1', j)) =e= sum(j, x('2', j));

* En la fase 1 no pueden seleccionarse m�s de una m�quina
Equation r_asignacion_1 En la fase 1 no pueden seleccionarse m�s de una m�quina;
r_asignacion_1.. sum(j, b('1',j))=l=1;

* En la fase 2 no pueden seleccionarse m�s dos m�quinas
Equation r_asignacion_2 En la fase 2 no pueden seleccionarse m�s de dos m�quina;
r_asignacion_2.. sum(j, b('2',j))=l=2;

* Relaci�n entre la m�quina M23 y la cantidad producida por dicha m�quina:
* 550*B23 <= X23 <= 600*B23.
Equations
         p_min(i,j) Relacion entre la maquina M23 y la cantidad producidad por dicha maquina
         p_max(i,j) Relacion entre la maquina M23 y la cantidad producidad por dicha maquina
;
p_min(i,j).. x(i,j)=g=min(j)*b(i,j);
p_max(i,j).. x(i,j)=l=max(j)*b(i,j);

* Las M�quinas M11 y M21 son incompatibles
Equation r_incompatible Las M�quinas M11 y M21 son incompatibles;
r_incompatible.. b('1','M11')+b('2','M21')=l=1;

Equations
         obj
*        El producto debe pasar por las dos fases
*        Cada fase requiere de una maquinaria especifica
         r_demanda(i) al menos una maquina para cada fase
;

* coding area
         obj.. z =e= sum((i,j), b(i,j)*precio(j)+x(i,j)*coste(j));
         r_demanda(i).. sum(j,b(i,j))=g=1;
*        asocia maquina con su fase
         b.up(i,j) = f(i,j);

option optcr = 0.001
Model maquinaria /All/;
Solve maquinaria using MIP minimizing z;
