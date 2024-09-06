create or replace function fn_cantidad_productos(codigo_categoria number)
return number
is
    cantidad_producto number;
begin
    select count(1) into cantidad_producto from tbl_producto where nro_categoria = 1;
    return cantidad_producto;
end;

create or replace function fn_obtener_cod_cat(categoria varchar)
return number
is
    cod_cat number;
begin
    select nro_categoria into cod_cat from tbl_categoria where nombre_categoria = categoria;
    return cod_cat;
end;

create or replace function fn_obtener_productos(categoria VARCHAR2, cantidad_productos out number)
return SYS_REFCURSOR
is
    datos_productos SYS_REFCURSOR;
    cod_cat number;
begin
    
    cod_cat := FN_OBTENER_COD_CAT(categoria);
    
    cantidad_productos := fn_cantidad_productos(cod_cat);
    
    open datos_productos for select * from tbl_producto where nro_categoria = cod_cat;
    
    return datos_productos;

end;

declare 
    cursor_pro SYS_REFCURSOR;

    type datos_pro is record (
        id_pro tbl_producto.P_CODIGO%type,
        nombre tbl_producto.NOMBRE_PRODUCTO%type,
        id_categoria tbl_producto.NRO_CATEGORIA%type,
        existencia tbl_producto.CANT_EXISTENCIA%type,
        precio tbl_producto.PRECIO_VENTA%type,
        observaciones tbl_producto.OBSERVACIONES%type
    );
    
    fila datos_pro;
    
    cant_pro number;
begin
    
    cursor_pro := FN_OBTENER_PRODUCTOS('Clothing', cant_pro);
    
        for i in 1.. cant_pro loop
            fetch cursor_pro into fila;
            dbms_output.put_line('');
            dbms_output.put_line('Codigo de producto: ' || fila.id_pro);
            dbms_output.put_line('Nombre de producto: ' || fila.nombre);
            dbms_output.put_line('Categoria de producto: ' || fila.id_categoria);
            dbms_output.put_line('Existencia de producto: ' || fila.existencia);
            dbms_output.put_line('Precio de producto: ' || fila.precio);
            dbms_output.put_line('Observaciones de producto: ' || fila.observaciones);
            dbms_output.put_line('');
        end loop;
        
        dbms_output.put_line('Cantidad de productos: ' || cant_pro);
    
    close cursor_pro;
    
end;

