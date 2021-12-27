* El condato de Washington incluye 6 poblacion
* que necesitan servicios de ambulancias para urgencias
Set i poblicion /1*6/;

* La estaciones de ambulacias pueden estar ubicadas
* en cualquiera de las 6 poblaciones a las que sirve
* La estacion debe estar a 15 minutos
* de distancia de las poblaciones a las que sirve
Scalar max_distancia /15/;

* Las distancias entre las poblaciones
* (en tiempo empleado en ir de una a otra) son
Alias(i,j);
Table distancia(i,j)
         1       2       3       4       5       6
1        0       23      14      18      10      32
2        23      0       24      13      22      11
3        14      24      0       60      19      20
4        18      13      60      0       55      17
5        10      22      19      55      0       12
6        32      11      20      17      12      0

Parameter cubrimiento(i,j);

cubrimiento(i,j) $ (distancia(i,j) <= max_distancia) = 1;
display cubrimiento;

Parameter coste(i)
         /1      100
          2      120
          3      90
          4      60
          5      80
          6      95/;

Variable x(i) si instala servicio de ambulancia en i

Free Variables
         z  valor objetivo
;

Equations
         obj
         r_cubrimiento(j)
;
         obj.. z =e= sum(i, coste(i)*x(i));
         r_cubrimiento(j).. sum(i, x(i)*cubrimiento(i,j))=g=1;


Model ambulancia /All/;
Solve ambulancia using MIP minimizing z;
