* Una empresa tiene que planificar la jornada de sus trabajadores
* de forma que cada día de la semana
Set d dia de la semana /1*7/;
* se garantiza la presencia los trabajadores
Parameter demanda(d)
         /1        30
          2        35
          3        40
          4        35
          5        50
          6        60
          7        55/
;

* Tiene en plantilla 50 trabajadores a jornada completa
* (que trabajan 5 dias consecutivas, empezando cualquier dia de la semana)
Scalar trabajadores_total_a_jornada_completa /50/;
Positive Variable c(d) numero de trabajadores a jornada completa empiezando en el dia d;

* Y puede contratar hasta 50 trabajadores a tiempo parcial
* (que trabajan dos dias consecutivas, empezando cualquier dia de la semana)
Scalar trabajadores_total_a_jornada_parcial /50/;
Positive Variable p(d) numero de trabajadores a jornada parcial empiezando en el dia d;
Equation r_trabajadores_total_a_jornada_parcial;
r_trabajadores_total_a_jornada_parcial.. sum(d, c(d)) =l= trabajadores_total_a_jornada_parcial;

Positive Variable e(d) numero de empleado en dia d;
Equation b_empleado(d) balance del numero de enpleado en dia d;
alias(d, dd);
Table trabaja_c_en_dia(dd, d)
                 1       2       3       4       5       6       7
         1       1       1       1       1       1
         2               1       1       1       1       1
         3                       1       1       1       1       1
         4       1                       1       1       1       1
         5       1       1                       1       1       1
         6       1       1       1                       1       1
         7       1       1       1       1                       1
;
Display trabaja_c_en_dia;
Table trabaja_p_en_dia(dd, d)
                 1       2       3       4       5       6       7
         1       1       1
         2               1       1
         3                       1       1
         4                               1       1
         5                                       1       1
         6                                               1       1
         7       1                                               1
;
Display trabaja_p_en_dia;
b_empleado(d).. e(d) =e= sum(dd, c(dd)*trabaja_c_en_dia(dd,d)) + sum(dd, p(dd)*trabaja_p_en_dia(dd,d));

* El convenio establece que un trabajador a tiempo completo
* tiene un salario de 450 euros a la semana
Scalar salario_jornada_completa /450/;

* Y los trabajadores a tiempo parcial cobran un 20% más que un trabajador a tiempo completo
Scalar salario_jornada_parcial;
salario_jornada_parcial = salario_jornada_completa * 1.2;

Positive Variable salario_total;
Equation e_salario_total;
e_salario_total.. salario_total =e= sum(d,c(d)*salario_jornada_completa + p(d)*salario_jornada_parcial);

* Por cada trabajador por encima del numero requerido en un dia,
* se considera una penalizacion de 50 euros
Scalar penalizacion      /50/;
Positive Variables
         penalizacion_total
         s(d) empleados sobrantes en el dia d
;
Equations
         e_empleado_sobrando(d)
         e_penalizacion_total;
;
e_empleado_sobrando(d).. e(d) =e= demanda(d) + s(d);
e_penalizacion_total.. penalizacion_total =e= sum(d, s(d))*penalizacion;

* Si un trabajador a tiempo completa no tiene asignada una jornada,
* recibe solo el 70% de su salario
Scalar penalizacion_salario;
penalizacion_salario = 0.3 * salario_jornada_completa;
Positive Variables
         penalizacion_salarial_total
         n empleados que no tiene asignada una jornada
;
Equations
         e_penalizacion_salarial_total
         e_trabajadores_total_a_jornada_completa
;
e_penalizacion_salarial_total.. penalizacion_salarial_total =e= n * penalizacion_salario;
e_trabajadores_total_a_jornada_completa.. sum(d, c(d)) + n =e= trabajadores_total_a_jornada_completa;

* y si trabaja todo el fin de semana, recibe un plus de 100 euros por semana.
Scalar plus /100/;
Positive Variables plus_total;
Equation e_plus_total;
e_plus_total.. plus_total =e= (c('3') + c('4') + c('5') + c('6')) * plus;

* Plantear un modelo de Optimización Matemática Lineal
* para determinar cuántos trabajadores y de que tipo debe contratarse
* para garantizar la presencia requerida a coste minimo.
Free Variable z coste total;
Equation obj funcion objetivo;

obj.. z =e= salario_total + penalizacion_total - penalizacion_salarial_total + plus_total;

Model jornada /ALL/;
Solve jornada using LP minimizing z;

* Modificar el modelo para añadir la siguiente condicion
* Si en una jornada hay menos de 30 trabajadores a tiempo completo
* Hay que contratar a un coordinador, con un coste de 80 euros
Free Variable z2 nuevo coste total;
Binary Variable delta;
Equations
         obj2 funcion objetivo
         r_coste_minimo;
;
r_coste_minimo.. sum(d, c(d)) =l= 30 + (1-delta)*999999999999;
obj2.. z2 =e= z + delta * 80;
Model jornada_modificada /ALL/;
Solve jornada_modificada using MIP minimizing z;
