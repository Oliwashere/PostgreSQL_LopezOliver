/*1. Lista el nombre de todos los productos que hay en la tabla producto.*/
SELECT nombre 
FROM producto;

/*2. Lista los nombres y los precios de todos los productos de la tabla producto.*/
SELECT nombre, precio 
FROM producto;

/*3. Lista todas las columnas de la tabla producto.*/
SELECT * 
FROM producto;

/*4. Lista el nombre de los productos, el precio en euros y el precio en dólares
estadounidenses (USD).*/
SELECT nombre, precio as precio_usd, precio * 0.90 as precio_euro
FROM producto;

/*5. Lista el nombre de los productos, el precio en euros y el precio en dólares
estadounidenses (USD). Utiliza los siguientes alias para las columnas: nombre
de producto, euros, dólares.*/
SELECT nombre as "nombre de producto", precio as dólares, precio * 0.90 as euros
FROM producto;

/*6. Lista los nombres y los precios de todos los productos de la tabla producto,
convirtiendo los nombres a mayúscula.*/
SELECT upper(nombre) as nombre, precio 
FROM producto;

/*7. Lista los nombres y los precios de todos los productos de la tabla producto,
convirtiendo los nombres a minúscula.*/
SELECT lower(nombre) as nombre, precio
FROM producto;

/*8. Lista el nombre de todos los fabricantes en una columna, y en otra columna
obtenga en mayúsculas los dos primeros caracteres del nombre del
fabricante.*/
SELECT nombre, upper(substring(nombre, 1, 2)) as dos_mayúsculas
FROM fabricante;

/*9. Lista los nombres y los precios de todos los productos de la tabla producto,
redondeando el valor del precio.*/
SELECT nombre, round(precio) as precio
FROM producto;

/*10. Lista los nombres y los precios de todos los productos de la tabla producto,
truncando el valor del precio para mostrarlo sin ninguna cifra decimal.*/
SELECT nombre, trunc(precio) as precio
FROM producto;

/*11. Lista el identificador de los fabricantes que tienen productos en la
tabla producto.*/
SELECT DISTINCT codigo_fabricante
FROM producto;
  
/*12. Lista el identificador de los fabricantes que tienen productos en la
tabla producto, eliminando los identificadores que aparecen repetidos.*/
SELECT DISTINCT codigo_fabricante
FROM producto;

/*13. Lista los nombres de los fabricantes ordenados de forma ascendente.*/
SELECT nombre
FROM fabricante
ORDER BY nombre ASC;

/*14. Lista los nombres de los fabricantes ordenados de forma descendente.*/
SELECT nombre
FROM fabricante
ORDER BY nombre DESC;

/*15. Lista los nombres de los productos ordenados en primer lugar por el
nombre de forma ascendente y en segundo lugar por el precio de forma
descendente.*/
SELECT nombre, precio
FROM producto
ORDER BY nombre ASC, precio DESC;

/*16. Devuelve una lista con las 5 primeras filas de la tabla fabricante.*/
SELECT *
FROM fabricante
LIMIT 5;

/*17. Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante.
La cuarta fila también se debe incluir en la respuesta.*/
SELECT *
FROM fabricante
OFFSET 3 LIMIT 2;

/*18. Lista el nombre y el precio del producto más barato. (Utilice solamente las
cláusulas ORDER BY y LIMIT)*/
SELECT nombre, precio
FROM producto
ORDER BY precio ASC
LIMIT 1;

/*19. Lista el nombre y el precio del producto más caro. (Utilice solamente las
cláusulas ORDER BY y LIMIT)*/
SELECT nombre, precio
FROM producto
ORDER BY precio DESC
LIMIT 1;

/*20. Lista el nombre de todos los productos del fabricante cuyo identificador de
fabricante es igual a 2.*/
SELECT nombre, codigo_fabricante 
FROM producto
WHERE codigo_fabricante = 2;

/*21. Lista el nombre de los productos que tienen un precio menor o igual a 120€.*/
SELECT nombre, precio
FROM producto
WHERE precio <= 120;

/*22. Lista el nombre de los productos que tienen un precio mayor o igual a 400€.*/
SELECT nombre, precio
FROM producto
WHERE precio >= 400;

/*23. Lista el nombre de los productos que no tienen un precio mayor o igual a
400€.*/
SELECT nombre, precio
FROM producto
WHERE precio < 400;

/*24. Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar
el operador BETWEEN.*/
SELECT nombre, precio
FROM producto
WHERE precio >= 80 AND precio <= 300;

/*25. Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando
el operador BETWEEN.*/
SELECT nombre, precio
FROM producto
WHERE precio BETWEEN 60 AND 200;

/*26. Lista todos los productos que tengan un precio mayor que 200€ y que el
identificador de fabricante sea igual a 6.*/
SELECT nombre, precio
FROM producto
WHERE precio > 200 AND codigo_fabricante = 6;

/*27. Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5.
Sin utilizar el operador IN.*/
SELECT nombre, codigo_fabricante 
FROM producto
WHERE codigo_fabricante = 1 OR codigo_fabricante = 3 OR codigo_fabricante = 5;

/*28. Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5.
Utilizando el operador IN.*/
SELECT nombre, codigo_fabricante 
FROM producto
WHERE codigo_fabricante IN (1, 3, 5);

/*29. Lista el nombre y el precio de los productos en céntimos (Habrá que
multiplicar por 100 el valor del precio). Cree un alias para la columna que
contiene el precio que se llame céntimos.
30. Lista los nombres de los fabricantes cuyo nombre*/
SELECT nombre, precio * 100 AS centimos
FROM producto;

/*31. Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.*/
SELECT nombre
FROM fabricante
WHERE nombre LIKE '%e';

/*32. Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.*/
SELECT nombre
FROM fabricante
WHERE nombre LIKE '%w%';

/*33. Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.*/
SELECT nombre
FROM fabricante
WHERE LENGTH(nombre) = 4;

/*34. Devuelve una lista con el nombre de todos los productos que contienen la
cadena Portátil en el nombre.*/
SELECT nombre
FROM producto
WHERE nombre LIKE '%Portátil%';

/*35. Devuelve una lista con el nombre de todos los productos que contienen la
cadena Monitor en el nombre y tienen un precio inferior a 215 €.*/
SELECT nombre, precio 
FROM producto
WHERE nombre LIKE '%Monitor%' AND precio < 215;

/*36. Lista el nombre y el precio de todos los productos que tengan un precio
mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en
orden descendente) y en segundo lugar por el nombre (en orden
ascendente).*/
SELECT nombre, precio
FROM producto
WHERE precio >= 180
ORDER BY precio DESC, nombre ASC;

/*1. Devuelve una lista con el nombre del producto, precio y nombre de
fabricante de todos los productos de la base de datos.*/
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricante
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;

/*2. Devuelve una lista con el nombre del producto, precio y nombre de
fabricante de todos los productos de la base de datos. Ordene el resultado
por el nombre del fabricante, por orden alfabético.*/
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricante
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
ORDER BY fabricante.nombre ASC;

/*3. Devuelve una lista con el identificador del producto, nombre del producto,
identificador del fabricante y nombre del fabricante, de todos los productos
de la base de datos.*/
SELECT producto.codigo, producto.nombre, fabricante.codigo AS codigo_fabricante, fabricante.nombre AS fabricante
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;

/*4. Devuelve el nombre del producto, su precio y el nombre de su fabricante,
del producto más barato.*/
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricante
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
ORDER BY producto.precio ASC
LIMIT 1;

/*5. Devuelve el nombre del producto, su precio y el nombre de su fabricante,
del producto más caro.*/
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricante
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
ORDER BY producto.precio DESC
LIMIT 1;

/*6. Devuelve una lista de todos los productos del fabricante Lenovo.*/
SELECT producto.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Lenovo';

/*7. Devuelve una lista de todos los productos del fabricante Crucial que tengan
un precio mayor que 200€.*/
SELECT producto.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Crucial' AND producto.precio > 200;

/*8. Devuelve un listado con todos los productos de los
fabricantes Asus, Hewlett-Packardy Seagate. Sin utilizar el operador IN.*/
SELECT producto.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Asus' OR fabricante.nombre = 'Hewlett-Packard' OR fabricante.nombre = 'Seagate';

/*9. Devuelve un listado con todos los productos de los
fabricantes Asus, Hewlett-Packardy Seagate. Utilizando el operador IN.*/
SELECT producto.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

/*10. Devuelve un listado con el nombre y el precio de todos los productos de los
fabricantes cuyo nombre termine por la vocal e.*/
SELECT producto.nombre, producto.precio
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre LIKE '%e';

/*11. Devuelve un listado con el nombre y el precio de todos los productos cuyo
nombre de fabricante contenga el carácter w en su nombre.*/
SELECT producto.nombre, producto.precio
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre LIKE '%w%';

/*12. Devuelve un listado con el nombre de producto, precio y nombre de
fabricante, de todos los productos que tengan un precio mayor o igual a
180€. Ordene el resultado en primer lugar por el precio (en orden
descendente) y en segundo lugar por el nombre (en orden ascendente)*/
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE producto.precio >= 180
ORDER BY producto.precio DESC, producto.nombre ASC;

/*13. Devuelve un listado con el identificador y el nombre de fabricante,
solamente de aquellos fabricantes que tienen productos asociados en la
base de datos.*/
SELECT fabricante.codigo, fabricante.nombre
FROM fabricante
WHERE fabricante.codigo IN (
    SELECT DISTINCT producto.codigo_fabricante
    FROM producto
);
