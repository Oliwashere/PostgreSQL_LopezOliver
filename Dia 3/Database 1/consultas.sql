/*Consultas sobre una tabla

1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.*/

SELECT codigo_oficina, ciudad
FROM oficina;

/*2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.*/

SELECT ciudad, telefono
FROM oficina
WHERE pais = 'España';

/*3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo
jefe tiene un código de jefe igual a 7.*/

SELECT nombre, apellido1, apellido2, email
FROM empleado
WHERE codigo_jefe = 7;

/*4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la
empresa.*/

SELECT puesto, nombre, apellido1, apellido2, email
FROM empleado
WHERE codigo_empleado = (SELECT codigo_jefe FROM empleado WHERE codigo_jefe IS NULL);

/*5. Devuelve un listado con el nombre, apellidos y puesto de aquellos
empleados que no sean representantes de ventas.*/

SELECT nombre, apellido1, apellido2, puesto
FROM empleado
WHERE puesto != 'Representante de Ventas';

/*6. Devuelve un listado con el nombre de los todos los clientes españoles.*/

SELECT nombre_cliente, pais
FROM cliente
WHERE pais = 'Spain';

/*7. Devuelve un listado con los distintos estados por los que puede pasar un
pedido.*/

SELECT DISTINCT estado
FROM pedido;

/*8. Devuelve un listado con el código de cliente de aquellos clientes que
realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
• Utilizando la función YEAR de MySQL pero que sirva en postgresql.*/

SELECT DISTINCT codigo_cliente, fecha_pago
FROM pago
WHERE EXTRACT(YEAR FROM fecha_pago) = 2008;

/*• Sin utilizar ninguna de las funciones anteriores.*/

SELECT DISTINCT codigo_cliente, fecha_pago
FROM pago
WHERE fecha_pago BETWEEN '2008-01-01' AND '2008-12-31';

/*9. Devuelve un listado con el código de pedido, código de cliente, fecha
esperada y fecha de entrega de los pedidos que no han sido entregados a
tiempo.*/

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega > fecha_esperada;

/*10. Devuelve un listado con el código de pedido, código de cliente, fecha
esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al
menos dos días antes de la fecha esperada.
• Utilizando la función AGE.*/

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE AGE(fecha_esperada, fecha_entrega) >= INTERVAL '2 days';

/*• Utilizando el operador -.*/

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega <= (fecha_esperada - INTERVAL '2 days');

/*11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.*/

SELECT codigo_pedido, estado
FROM pedido
WHERE estado = 'Rechazado' AND EXTRACT(YEAR FROM fecha_pedido) = 2009;

/*12. Devuelve un listado de todos los pedidos que han sido entregados en el
mes de enero de cualquier año.*/

SELECT * 
FROM pedido
WHERE EXTRACT(MONTH FROM fecha_entrega) = 1;

/*13. Devuelve un listado con todos los pagos que se realizaron en el
año 2008 mediante Paypal. Ordene el resultado de mayor a menor.*/

SELECT * 
FROM pago
WHERE EXTRACT(YEAR FROM fecha_pago) = 2008 
AND forma_pago = 'PayPal'
ORDER BY total DESC;

/*14. Devuelve un listado con todas las formas de pago que aparecen en la
tabla pago. Tenga en cuenta que no deben aparecer formas de pago
repetidas.*/

SELECT DISTINCT forma_pago 
FROM pago;

/*15. Devuelve un listado con todos los productos que pertenecen a la
gama Ornamentales y que tienen más de 100 unidades en stock. El listado
deberá estar ordenado por su precio de venta, mostrando en primer lugar
los de mayor precio.*/

SELECT * 
FROM producto
WHERE gama = 'Ornamentales' 
AND cantidad_en_stock > 100
ORDER BY precio_venta DESC;

/*16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y
cuyo representante de ventas tenga el código de empleado 11 o 30.
Consultas multitabla (Composición interna)
Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con
sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.*/

SELECT * 
FROM cliente
WHERE ciudad = 'Madrid' 
AND codigo_empleado_rep_ventas IN (11, 30);

/*1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su
representante de ventas.*/

SELECT c.nombre_cliente, e.nombre, e.apellido1
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;

/*2. Muestra el nombre de los clientes que hayan realizado pagos junto con el
nombre de sus representantes de ventas.*/

SELECT c.nombre_cliente, e.nombre, e.apellido1
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente;

/*3. Muestra el nombre de los clientes que no hayan realizado pagos junto con
el nombre de sus representantes de ventas.*/

SELECT c.nombre_cliente, e.nombre, e.apellido1
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente IS NULL;

/*4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus
representantes junto con la ciudad de la oficina a la que pertenece el
representante.*/

SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente;

/*5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre
de sus representantes junto con la ciudad de la oficina a la que pertenece el
representante.*/

SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente IS NULL;

/*6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.*/

SELECT DISTINCT o.linea_direccion1, o.linea_direccion2, c.ciudad
FROM oficina o
INNER JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
INNER JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.ciudad = 'Fuenlabrada';

/*7. Devuelve el nombre de los clientes y el nombre de sus representantes junto
con la ciudad de la oficina a la que pertenece el representante.*/

SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad, o.codigo_oficina
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

/*8. Devuelve un listado con el nombre de los empleados junto con el nombre
de sus jefes.*/

SELECT e1.nombre AS nombre_empleado, e1.apellido1 AS apellido_empleado, e2.nombre AS nombre_jefe, e2.apellido1 AS apellido_jefe
FROM empleado e1
LEFT JOIN empleado e2 ON e1.codigo_jefe = e2.codigo_empleado;

/*9. Devuelve un listado que muestre el nombre de cada empleados, el nombre
de su jefe y el nombre del jefe de sus jefe.*/

SELECT e1.nombre AS nombre_empleado, e1.apellido1 AS apellido_empleado,
       e2.nombre AS nombre_jefe, e2.apellido1 AS apellido_jefe,
       e3.nombre AS nombre_jefe_jefe, e3.apellido1 AS apellido_jefe_jefe
FROM empleado e1
LEFT JOIN empleado e2 ON e1.codigo_jefe = e2.codigo_empleado
LEFT JOIN empleado e3 ON e2.codigo_jefe = e3.codigo_empleado;

/*10. Devuelve el nombre de los clientes a los que no se les ha entregado a
tiempo un pedido.*/

SELECT c.nombre_cliente
FROM cliente c
INNER JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE p.fecha_entrega IS NOT NULL
AND p.fecha_entrega > p.fecha_esperada;

/*11. Devuelve un listado de las diferentes gamas de producto que ha comprado
cada cliente.*/

SELECT DISTINCT c.nombre_cliente, p.gama, p.codigo_producto
FROM cliente c
INNER JOIN pedido pd ON c.codigo_cliente = pd.codigo_cliente
INNER JOIN detalle_pedido dp ON pd.codigo_pedido = dp.codigo_pedido
INNER JOIN producto p ON dp.codigo_producto = p.codigo_producto;

/*Consultas multitabla (Composición externa)
Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL
LEFT JOIN y NATURAL RIGHT JOIN.*/

/*1. Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pago.*/

SELECT c.nombre_cliente
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente IS NULL;

/*2. Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pedido.*/

SELECT c.nombre_cliente
FROM cliente c
LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_pedido IS NULL;

/*3. Devuelve un listado que muestre los clientes que no han realizado ningún
pago y los que no han realizado ningún pedido.*/

SELECT c.nombre_cliente, pd.codigo_pedido, p.codigo_cliente as codigo_pago
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
LEFT JOIN pedido pd ON c.codigo_cliente = pd.codigo_cliente
WHERE p.codigo_cliente IS NULL AND pd.codigo_pedido IS NULL;

/*4. Devuelve un listado que muestre solamente los empleados que no tienen
una oficina asociada.*/

SELECT e.nombre, e.apellido1
FROM empleado e
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE o.codigo_oficina IS NULL;

/*5. Devuelve un listado que muestre solamente los empleados que no tienen un
cliente asociado.*/

SELECT e.nombre, e.apellido1
FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_cliente IS NULL;

/*6. Devuelve un listado que muestre solamente los empleados que no tienen un
cliente asociado junto con los datos de la oficina donde trabajan.*/

SELECT e.nombre, e.apellido1, o.linea_direccion1, o.linea_direccion2, o.ciudad, o.pais
FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE c.codigo_cliente IS NULL;

/*7. Devuelve un listado que muestre los empleados que no tienen una oficina
asociada y los que no tienen un cliente asociado.*/

SELECT e.nombre, e.apellido1
FROM empleado e
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE o.codigo_oficina IS NULL AND c.codigo_cliente IS NULL;

/*8. Devuelve un listado de los productos que nunca han aparecido en un
pedido.*/

SELECT p.nombre
FROM producto p
LEFT JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
WHERE dp.codigo_producto IS NULL;

/*9. Devuelve un listado de los productos que nunca han aparecido en un
pedido. El resultado debe mostrar el nombre, la descripción y la imagen del
producto.*/

SELECT p.nombre, p.descripcion
FROM producto p
LEFT JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
WHERE dp.codigo_producto IS NULL;

/*10. Devuelve las oficinas donde no trabajan ninguno de los empleados que
hayan sido los representantes de ventas de algún cliente que haya realizado
la compra de algún producto de la gama Frutales.*/

SELECT o.ciudad, o.pais
FROM oficina o
WHERE o.codigo_oficina NOT IN (
    SELECT e.codigo_oficina
    FROM empleado e
    WHERE e.codigo_empleado IN (
        SELECT c.codigo_empleado_rep_ventas
        FROM cliente c
        WHERE c.codigo_cliente IN (
            SELECT p.codigo_cliente
            FROM pedido p
            JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
            JOIN producto prod ON dp.codigo_producto = prod.codigo_producto
            WHERE prod.gama = 'Frutales'
        )
    )
);

/*11. Devuelve un listado con los clientes que han realizado algún pedido pero no
han realizado ningún pago.*/

SELECT c.codigo_cliente, c.nombre_cliente
FROM cliente c
WHERE c.codigo_cliente IN (
    SELECT p.codigo_cliente
    FROM pedido p
) AND c.codigo_cliente NOT IN (
    SELECT pg.codigo_cliente
    FROM pago pg
);

/*12. Devuelve un listado con los datos de los empleados que no tienen clientes
asociados y el nombre de su jefe asociado.*/

SELECT e1.codigo_empleado, e1.nombre, e1.apellido1, e2.nombre AS jefe_nombre, e2.apellido1 AS jefe_apellido
FROM empleado e1
LEFT JOIN cliente c ON e1.codigo_empleado = c.codigo_empleado_rep_ventas
LEFT JOIN empleado e2 ON e1.codigo_jefe = e2.codigo_empleado
WHERE c.codigo_cliente IS NULL;

/*Consultas resumen*/

/*1. ¿Cuántos empleados hay en la compañía?*/

SELECT COUNT(*) AS total_empleados
FROM empleado;

/*2. ¿Cuántos clientes tiene cada país?*/

SELECT pais, COUNT(*) AS total_clientes
FROM cliente
GROUP BY pais;

/*3. ¿Cuál fue el pago medio en 2009?*/

SELECT AVG(total) AS pago_medio
FROM pago
WHERE EXTRACT(YEAR FROM fecha_pago) = 2009;

/*4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma
descendente por el número de pedidos.*/

SELECT estado, COUNT(*) AS total_pedidos
FROM pedido
GROUP BY estado
ORDER BY total_pedidos DESC;

/*5. Calcula el precio de venta del producto más caro y más barato en una
misma consulta.*/

SELECT MAX(precio_venta) AS precio_maximo, MIN(precio_venta) AS precio_minimo
FROM producto;

/*6. Calcula el número de clientes que tiene la empresa.*/

SELECT COUNT(*) AS total_clientes
FROM cliente;

/*7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?*/

SELECT COUNT(*) AS total_clientes_madrid
FROM cliente
WHERE ciudad = 'Madrid';

/*8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan
por M?*/

SELECT ciudad, COUNT(*) AS total_clientes
FROM cliente
WHERE ciudad LIKE 'M%'
GROUP BY ciudad;

/*9. Devuelve el nombre de los representantes de ventas y el número de clientes
al que atiende cada uno.*/

SELECT e.nombre, e.apellido1, COUNT(c.codigo_cliente) AS total_clientes
FROM empleado e
JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
GROUP BY e.nombre, e.apellido1;

/*10. Calcula el número de clientes que no tiene asignado representante de
ventas.*/

SELECT COUNT(*) AS total_clientes_sin_rep
FROM cliente
WHERE codigo_empleado_rep_ventas IS NULL;

/*11. Calcula la fecha del primer y último pago realizado por cada uno de los
clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.*/

SELECT c.nombre_cliente, c.nombre_contacto, c.apellido_contacto, 
       MIN(p.fecha_pago) AS primer_pago, MAX(p.fecha_pago) AS ultimo_pago
FROM cliente c
JOIN pago p ON c.codigo_cliente = p.codigo_cliente
GROUP BY c.nombre_cliente, c.nombre_contacto, c.apellido_contacto;

/*12. Calcula el número de productos diferentes que hay en cada uno de los
pedidos.*/

SELECT codigo_pedido, COUNT(DISTINCT codigo_producto) AS productos_diferentes
FROM detalle_pedido
GROUP BY codigo_pedido;

/*13. Calcula la suma de la cantidad total de todos los productos que aparecen en
cada uno de los pedidos.*/

SELECT codigo_pedido, SUM(cantidad) AS total_productos
FROM detalle_pedido
GROUP BY codigo_pedido;

/*14. Devuelve un listado de los 20 productos más vendidos y el número total de
unidades que se han vendido de cada uno. El listado deberá estar ordenado
por el número total de unidades vendidas.*/

SELECT p.nombre, SUM(dp.cantidad) AS unidades_vendidas
FROM producto p
JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
GROUP BY p.nombre
ORDER BY unidades_vendidas DESC
LIMIT 20;

/*15. La facturación que ha tenido la empresa en toda la historia, indicando la
base imponible, el IVA y el total facturado. La base imponible se calcula
sumando el coste del producto por el número de unidades vendidas de la
tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la
suma de los dos campos anteriores.*/

SELECT SUM(dp.cantidad * dp.precio_unidad) AS base_imponible,
       SUM(dp.cantidad * dp.precio_unidad) * 0.21 AS iva,
       SUM(dp.cantidad * dp.precio_unidad) * 1.21 AS total_facturado
FROM detalle_pedido dp;

/*16. La misma información que en la pregunta anterior, pero agrupada por
código de producto.*/

SELECT dp.codigo_producto, SUM(dp.cantidad * dp.precio_unidad) AS base_imponible,
       SUM(dp.cantidad * dp.precio_unidad) * 0.21 AS iva,
       SUM(dp.cantidad * dp.precio_unidad) * 1.21 AS total_facturado
FROM detalle_pedido dp
GROUP BY dp.codigo_producto;

/*17. La misma información que en la pregunta anterior, pero agrupada por
código de producto filtrada por los códigos que empiecen por OR.*/

SELECT codigo_producto, SUM(cantidad) AS total_unidades_vendidas
FROM detalle_pedido
WHERE codigo_producto LIKE 'OR%'
GROUP BY codigo_producto;

/*18. Lista las ventas totales de los productos que hayan facturado más de 3000
euros. Se mostrará el nombre, unidades vendidas, total facturado y total
facturado con impuestos (21% IVA).*/

SELECT p.nombre, 
       SUM(dp.cantidad) AS unidades_vendidas, 
       SUM(dp.precio_unidad * dp.cantidad) AS total_facturado, 
       SUM(dp.precio_unidad * dp.cantidad) * 1.21 AS total_con_iva
FROM detalle_pedido dp
JOIN producto p ON dp.codigo_producto = p.codigo_producto
GROUP BY p.nombre
HAVING SUM(dp.precio_unidad * dp.cantidad) > 3000;

/*19. Muestre la suma total de todos los pagos que se realizaron para cada uno
de los años que aparecen en la tabla pagos.*/

SELECT EXTRACT(YEAR FROM fecha_pago) AS anio, 
       SUM(total) AS total_pagos
FROM pago
GROUP BY anio;

/*Subconsultas

Con operadores básicos de comparación

1. Devuelve el nombre del cliente con mayor límite de crédito.*/

SELECT nombre_cliente 
FROM cliente
WHERE limite_credito = (SELECT MAX(limite_credito) FROM cliente);

/*2. Devuelve el nombre del producto que tenga el precio de venta más caro.*/

SELECT nombre 
FROM producto
WHERE precio_venta = (SELECT MAX(precio_venta) FROM producto);

/*3. Devuelve el nombre del producto del que se han vendido más unidades.

SELECT p.nombre 
FROM producto p
JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
GROUP BY p.nombre
ORDER BY SUM(dp.cantidad) DESC
LIMIT 1;

(Tenga en cuenta que tendrá que calcular cuál es el número total de
unidades que se han vendido de cada producto a partir de los datos de la
tabla detalle_pedido)*/

/*4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya
realizado. (Sin utilizar INNER JOIN).*/

SELECT nombre_cliente 
FROM cliente c
WHERE limite_credito > (SELECT COALESCE(SUM(p.total), 0) 
                        FROM pago p 
                        WHERE p.codigo_cliente = c.codigo_cliente);

/*5. Devuelve el producto que más unidades tiene en stock.*/

SELECT nombre 
FROM producto
WHERE cantidad_en_stock = (SELECT MAX(cantidad_en_stock) FROM producto);

/*6. Devuelve el producto que menos unidades tiene en stock.*/

SELECT nombre 
FROM producto
WHERE cantidad_en_stock = (SELECT MIN(cantidad_en_stock) FROM producto);

/*7. Devuelve el nombre, los apellidos y el email de los empleados que están a
cargo de Alberto Soria.*/

SELECT e.nombre, e.apellido1, e.email
FROM empleado e
JOIN empleado jefe ON e.codigo_jefe = jefe.codigo_empleado
WHERE jefe.nombre = 'Alberto' AND jefe.apellido1 = 'Soria';

/*Subconsultas con ALL y any

8. Devuelve el nombre del cliente con mayor límite de crédito.*/

SELECT nombre_cliente 
FROM cliente
WHERE limite_credito = (SELECT MAX(limite_credito) FROM cliente);

/*9. Devuelve el nombre del producto que tenga el precio de venta más caro.*/

SELECT nombre 
FROM producto
WHERE precio_venta = (SELECT MAX(precio_venta) FROM producto);

/*10. Devuelve el producto que menos unidades tiene en stock.*/

SELECT nombre 
FROM producto
WHERE cantidad_en_stock = (SELECT MIN(cantidad_en_stock) FROM producto);

/*Subconsultas con IN y NOT in

11. Devuelve el nombre, apellido1 y cargo de los empleados que no
representen a ningún cliente.*/

SELECT nombre, apellido1, puesto 
FROM empleado
WHERE codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);

/*12. Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pago.*/

SELECT nombre_cliente 
FROM cliente
WHERE codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);

/*13. Devuelve un listado que muestre solamente los clientes que sí han realizado
algún pago.*/

SELECT nombre_cliente 
FROM cliente
WHERE codigo_cliente IN (SELECT codigo_cliente FROM pago);

/*14. Devuelve un listado de los productos que nunca han aparecido en un
pedido.*/

SELECT nombre 
FROM producto
WHERE codigo_producto NOT IN (SELECT codigo_producto FROM detalle_pedido);

/*15. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
empleados que no sean representante de ventas de ningún cliente.*/

SELECT e.nombre, e.apellido1, e.puesto, o.telefono 
FROM empleado e
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE e.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);

/*16. Devuelve las oficinas donde no trabajan ninguno de los empleados que
hayan sido los representantes de ventas de algún cliente que haya realizado
la compra de algún producto de la gama Frutales.*/

SELECT o.ciudad 
FROM oficina o
WHERE NOT EXISTS (
    SELECT 1 
    FROM empleado e
    JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
    JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
    JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
    JOIN producto pr ON dp.codigo_producto = pr.codigo_producto
    WHERE pr.gama = 'Frutales'
      AND e.codigo_oficina = o.codigo_oficina
);

/*Subconsultas con EXISTS y NOT exists

18. Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pago.*/

SELECT nombre_cliente 
FROM cliente
WHERE NOT EXISTS (SELECT 1 FROM pago p WHERE p.codigo_cliente = cliente.codigo_cliente);

/*19. Devuelve un listado que muestre solamente los clientes que sí han realizado
algún pago.*/

SELECT nombre_cliente 
FROM cliente
WHERE EXISTS (SELECT 1 FROM pago p WHERE p.codigo_cliente = cliente.codigo_cliente);

/*20. Devuelve un listado de los productos que nunca han aparecido en un
pedido.*/

SELECT nombre 
FROM producto
WHERE NOT EXISTS (SELECT 1 FROM detalle_pedido dp WHERE dp.codigo_producto = producto.codigo_producto);

/*21. Devuelve un listado de los productos que han aparecido en un pedido
alguna vez.*/

SELECT nombre 
FROM producto
WHERE EXISTS (SELECT 1 FROM detalle_pedido dp WHERE dp.codigo_producto = producto.codigo_producto);

/*Subconsultas correlacionadas

Consultas variadas

1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos
pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no
han realizado ningún pedido.*/

SELECT c.nombre_cliente, 
       (SELECT COUNT(*) FROM pedido p WHERE p.codigo_cliente = c.codigo_cliente) AS total_pedidos
FROM cliente c;

/*2. Devuelve un listado con los nombres de los clientes y el total pagado por
cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han
realizado ningún pago.*/

SELECT c.nombre_cliente, 
       (SELECT COALESCE(SUM(p.total), 0) FROM pago p WHERE p.codigo_cliente = c.codigo_cliente) AS total_pagado
FROM cliente c;

/*3. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008
ordenados alfabéticamente de menor a mayor.*/

SELECT DISTINCT c.nombre_cliente 
FROM cliente c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE EXTRACT(YEAR FROM p.fecha_pedido) = 2008
ORDER BY c.nombre_cliente;

/*4. Devuelve el nombre del cliente, el nombre y primer apellido de su
representante de ventas y el número de teléfono de la oficina del
representante de ventas, de aquellos clientes que no hayan realizado ningún
pago.*/

SELECT c.nombre_cliente, e.nombre AS nombre_rep, e.apellido1 AS apellido_rep, o.telefono
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE NOT EXISTS (SELECT 1 FROM pago p WHERE p.codigo_cliente = c.codigo_cliente);

/*5. Devuelve el listado de clientes donde aparezca el nombre del cliente, el
nombre y primer apellido de su representante de ventas y la ciudad donde
está su oficina.*/

SELECT c.nombre_cliente, e.nombre AS nombre_rep, e.apellido1 AS apellido_rep, o.ciudad
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

/*6. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
empleados que no sean representante de ventas de ningún cliente.*/

SELECT e.nombre, e.apellido1, e.puesto, o.telefono
FROM empleado e
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE e.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);

/*7. Devuelve un listado indicando todas las ciudades donde hay oficinas y el
número de empleados que tiene.*/

SELECT o.ciudad, COUNT(e.codigo_empleado) AS numero_empleados
FROM oficina o
LEFT JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
GROUP BY o.ciudad;

