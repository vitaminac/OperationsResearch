* La fábrica de cerveza produce dos tipos
Set i /Rubia, Negra/;

* La fábrica debe decidir cuantos litros de cerveza
* debe producir semanalmente teniendo en cuenta que 1000
* litros de cerveza rubia se venden a 100 euros
* y 1000 litros de cerveza negra a 125 euros

Parameter precio_venta(i) euros de cada tipo de cerveza
         / Rubia   100
           Negra   125/
;

* Para producir 1000 litros de cerveza rubia(negra)
* se necesitan 3(5) empleado

Parameter empleado(i)
         / Rubia 3
           Negra 5/
;

* La fabrica solo dispone de 15 empleados

Scalar empleados /15/;

* La compra de materias primas supone para el fabricante

Parameter precio_materia_prima(i) euros de cada tipo de cerveza
         / Rubia   90
           Negra   85/
;

* Dispone de 350 euros semanales para este concepto

Scalar presupuesto /350/;

Free Variables
         z beneficio total
;

Positive Variables
         x(i) litros de cerveza de tipo i
;

Equations
         beneficio beneficio total
         max_presupuesto Euros disponibles semanalmente
         max_empleados Empleados disponible
;

beneficio.. z =e= sum(i, precio_venta(i)*x(i));
max_presupuesto.. presupuesto =g= sum(i, precio_materia_prima(i)*x(i));
max_empleados.. empleados =g= sum(i, empleado(i)*x(i));

Model cerveza /ALL/;
Solve cerveza using LP maximizing z;
