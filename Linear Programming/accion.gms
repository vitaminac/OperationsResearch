* Disponemos de 252000 euros para invertir en bolsa.
* Nos recomiendan tres tipos de acciones:
* sector bancario (tipo A), sector energ�tico (tipo B) y sector distribuci�n (tipo C).
* Las del tipo A tienen un rendimiento esperado del 4.7%,
* las de tipo B del 6.8% y las del tipo C del 9.9%.
* Decidimos invertir un m�ximo de 137500 euros en las del tipo A,
* como m�nimo 47500 euros en las de tipo B y entre 56500 y 133000 en las de tipo C.
* Adem�s queremos invertir al menos 136500 en total,
* al menos el doble en el sector bancario que en el sector energ�tico
* y en el sector distribuci�n no m�s que en cualquiera de los otros dos.
* Resolver el problema que permite conocer la distribuci�n de la inversi�n
* para obtener el m�ximo inter�s anual.

Sets
         i sector /bancario, energetico, distribucion/
         j tipo /maximo, minimo/
;
Scalar
         capital /252000/
         inversion_min /136500/
;
Parameters
         rendimiento(i) rendimiento esperado del sector i
                 / bancario             0.047
                   energetico           0.068
                   distribucion         0.099/
;

Table
         inversion(i,j) porcentaje de crudo j que tiene la gasolina i
                         maximo          minimo
         bancario        137500          0
         energetico      +inf            47500
         distribucion    133000          56500
;

Free Variables
         z    coste
;

Positive Variables
         invert(i) inversion en el sector
;

Equations
         obj
         r_inversion_total capital disponible
         r_inversion_minima inversion minima
         r_double_sector_bancario al menos doble en el sector bancario que en el secor energetico
         r_min_distribucion(i) sector distribucion no mas que en cualquiera de los otros dos
;
         obj.. z =e= sum(i, invert(i) * rendimiento(i));
         r_inversion_total.. sum(i, invert(i)) =l= capital;
         invert.up(i) = inversion(i, 'maximo');
         invert.lo(i) = inversion(i, 'minimo');
         r_inversion_minima.. sum(i, invert(i)) =g= inversion_min;
         r_double_sector_bancario.. invert('bancario') =g= 2 * invert('energetico');
         r_min_distribucion(i).. invert(i) =g= invert('distribucion')


* coding area
Model accion /All/;
Solve accion using LP maximizing z;
