create table fabricante(
codigo INT not null primary key,
nombre VARCHAR(100) not null
);

create table producto(
codigo INT not null primary key,
nombre VARCHAR(100) not null,
precio DOUBLE precision not null,
codigo_fabricante INT not null,
foreign key (codigo_fabricante) references fabricante(codigo)
);
