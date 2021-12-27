* Juan es el jefe de un bufete de jovenes abogados y esta interesado
* en la utilizacion mas efectiva de sus recursos de personal buscando
* la forma de hacer las mejores asignaciones de abogado-cliente
Sets
         j client /divorcio, fucion_empresarial, desfalco, herencias/
         i abogado/Ana, Bruno, Carmen, Domingo/
;

* Para decdir la mejor asignacion
* Juan tiene en cuenta una tasa de efectividad
* construida sobre actuaciones anteriores de dichos abogados
* ya que no todos son igual de buenos en todo tipo de procesos
Table efectividad(i,j)
         divorcio        fucion_empresarial      desfalco        herencias
Ana      6               2                       8               5
Bruno    9               3                       5               8
Carmen   4               8                       3               4
Domingo  6               7                       6               4
;

Binary Variable x(i,j) si el abogado i lleva el caso de cliente j

Free Variables
         z  valor objetivo
;

Equations
         obj
         r_tarea(j)
         r_trabajador(i)
;
         obj.. z =e= sum((i,j), efectividad(i,j)*x(i,j));
         r_tarea(j).. sum(i, x(i,j))=e=1;
         r_trabajador(i).. sum(j, x(i,j))=e=1;


Model abogado /All/;
Solve abogado using MIP maximizing z;
