* La empresa PECE vende ordenadores y debe hacer una planificacion
* de la produccion de la proxuma semana
* La compañia produce tres tipos de ordenadores:
* de mesa(A), portatil normal(B) y portatil de lujo(C)
Set i tipo de ordenador /A, B, C/;

* El beneficio neto por la venta un ordenador es 350, 470 y 610 euros, respectivamente
Parameter beneficio /A 350, B 470, C 610/;

* Cada semana se venden todos los equipos que se montan.
* Los ordenadores pasan un control de calidad de una hora
* y la empresa dispone de
* 120 horas para realizar los controles de los ordenadores A y B
Scalar   horas_control_ab        /120/;
* y 48 para los C
Scalar   horas_control_c         /48/;

* El resto de las operaciones de montaje requieren 10, 15, 20 horas, respectivamente
Parameter montaje /A 10, B 15, C 20/;

* Y la empresea dispone de 2000 horas a la semana
Scalar horas_montaje     /2000/;

Positive Variable x(i) cantidad de ordenaderes del tipo i
Free Variable z beneficio total;
Equations
         obj
         r_horas_control_ab
         r_horas_control_c
         r_horas_montaje
;

obj.. z =e= sum(i, x(i)*beneficio(i));
r_horas_control_ab.. x('A') + x('B') =l= horas_control_ab;
r_horas_control_c..  x('C') =l= horas_control_c;
r_horas_montaje..  sum(i,x(i)*montaje(i)) =l= horas_montaje;

Model produccion /ALL/;
Solve produccion using LP maximizing z;