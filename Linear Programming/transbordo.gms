* El objetivo del problema consiste en llevar un producto
* desde una serie de nodos origen (A y F)
* a nodos destino (B y G a traves de nodos intermedios (C, D y E)
Set i nodo /A, B, C, D, E, F, G/;

Alias(i,j)
* con minimo coste conociendo
* el coste uniitario de transporte de un nodo i a un nodo j
Table coste(i,j)
         A       B       C       D       E       F       G
A        999     45      30      20      999     999     999
B        999     999     999     999     10      999     999
C        999     25      999     999     999     7       15
D        999     999     20      999     999     999     999
E        999     999     999     999     999     10      999
F        999     999     999     999     999     999     5
G        999     999     999     999     999     999     999
;
* We have use 999 as infinity

* Cada nodo de la red tendrá una generación/ consumo
* Nodo origen genera unidades: positivo
* Nodo destino consume unidades: negativo^
Parameter genera_consume(i)
/
A        30
B        -25
C        0
D        0
E        0
F        20
G        -25
/;


Positive Variable x(i,j) cantidad de producto transportado del nodo i al nodo j
Free Variable z coste total;
Equations
         obj
         r_balance(i)
;

obj.. z =e= sum(i, sum(j, x(i,j)*coste(i,j)));
r_balance(i).. sum(j,x(j,i)) + genera_consume(i) =e= sum(j,x(i,j));

Model transbordo /ALL/;
Solve transbordo using LP minimizing z;
