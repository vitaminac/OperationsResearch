* Los gestores de recursos de un centro de procesamiento de datos
* son componentes de software centralizados que gestionan
* la ejecucion de un gran numero de servicios.
Set j tipos de servicios /ServicioTipo1, ServicioTipo2, ServicioTipo3/;

* La colocacion de multiples servicios en una maquina
Set i tipos de servidores /ServidorTipo1, ServidorTipo2, ServidorTipo3/

* podra degradar el rendimiento y,
* por lo tanto, es critico para el gestor de recursos
* utilizar la informacion sobre los servicios y las maquinas
* para asignar efectivamente los recursos de la maquina.
Set r tipos de recursos /CPU, RAM/;

* El problema consiste en determinar la mejor asignacion
* de los servicios en los servidores para que,
Sets
         num /1*1000/
         p(i, num) servidores
         q(j, num) servicios
;

* por un lado, se cumplan las necesidades en los recursos de los servicios,
Parameters
         n(i) numero de servidores /ServidorTipo1 1, ServidorTipo2 2, ServidorTipo3 2/
         m(j) numero de servicios /ServicioTipo1 3, ServicioTipo2 3, ServicioTipo3 3/
         pr(i, num, r)  recurso r proporcionada por servidor p
         qr(j, num, r)  la demanda de recurso r por el servicio q
;

* y, por otro lado, se respeten los acuerdos de nivel de servicio (ANS).
* Ademas, el centro de procesamiento de datos quiere optimizar el numero de ordenadores involucrados.

* Cada servicio tiene las necesidades de recursos como CPU y RAM requeridos,
* y cada servidor tiene ciertos recursos de cada tipo para ofrecer.
* En las tablas de la parte inferior se indican las caracteristicas
* tanto de los servidores, como de los servicios.
* El centro de procesamiento de datos dispone de tres tipos de servidores,

Table L(i, r) recurso r proporcionada por servidor de tipo i
                         CPU   RAM
         ServidorTipo1   6       12
         ServidorTipo2   4       10
         ServidorTipo3   3       8
;

Table D(j, r) la demanda de recurso r por el servicio de tipo j
                         CPU     RAM
         ServicioTipo1   1.7     2
         ServicioTipo2   1.5     3
         ServicioTipo3   1       4
;

loop(i,
         p(i, num)$(ord(num) <= n(i)) = yes;
         pr(p(i, num), r) = L(i, r);
);

loop(j,
         q(j, num)$(ord(num) <= m(j)) = yes;
         qr(q(j, num), r) = D(j, r);
);

display p;
display q;
display pr;
display qr;

* Se supone que cada servicio debe asignarse a un unico servidor.
Binary Variable A(i, num, j, num) asignamos servicio j al servidor i; 
Equation servicio(j, num) cada servicio debe asignarse a un unico servidor;
servicio(q).. sum(p, A(p, q)) =e= 1;

* Los acuerdos de nivel de servicio (SLA) implican que
* la carga de los ordenadores debe estar equilibrada.
* Este requisito se plasma en el siguiente objetivo:
* se requiere minimizar la maxima ocupacion relativa de cada recurso
* en cada maquina. Por la ocupacion relativa de un recurso en una maquina
* se entiende la ratio de la ocupacion del recurso en la maquina
* entre la disponibilidad maxima del mismo.
Free Variable maxRelOcc la máxima ocupacion relativa de cada recurso en cada maquina;
Equation SLA(i, num, r) la maxima ocupacion relativa;
SLA(p, r).. maxRelOcc =g= sum(q, A(p, q) * qr(q, r))/pr(p, r);

* El segundo objetivo del centro de procesamiento es
* minimizar el numero de ordenadores que se ocupan por indicados servicios.
* Aproximad la frontera de Pareto.

Free Variable nServidores numero de ordenadores involucrados;

Binary Variable e(i, num) servidor encendido 1 si 0 no;

Equations
         numeroDeServidores numero de servidores involucrados
         ANS(i, num, r) la capacidad de servidor se cumplan las necesidades en los recursos de los servicios
;

* coding area
         ANS(p, r).. sum(q, A(p, q)*qr(q, r)) =l= e(p) * pr(p, r);
         numeroDeServidores.. nServidores =e= sum(p, e(p));

Model practica3 /ALL/;
* The GAMS default for OPTCR is 0.1
practica3.OPTCR = 0;

file output /pareto.txt/;
put output;
put 'pareto points:'/;
put 'num de servidores   maximo nivel de servicio'/;

scalar servidoresTotal, counter;
servidoresTotal = sum(i, n(i));
FOR (counter = 0 TO servidoresTotal,
         nServidores.fx = counter;
         solve practica3 using MIP minimizing maxRelOcc;
         put counter;
         If(practica3.Modelstat > %ModelStat.Optimal%,
                 put practica3.Tmodstat;
         else
                 put maxRelOcc.l;
         );
         put /;
);
