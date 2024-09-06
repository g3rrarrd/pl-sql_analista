--2. Crear un procedimiento almacenado que imrpima los nombres de todos los mecánicos 
--que trabajan en el puesto "Amortiguacion" y "Motor" 

create or replace procedure pd_imprimir_mecanicos
is
    mecanicos_data SYS_REFCURSOR;
    
    type datos is record (
        dni mecanicos.dni%type,
        nombre mecanicos.nombre%type,
        puesto mecanicos.puesto%type
    );
    
    fila datos;
    
begin
    open mecanicos_data for 
    select dni, nombre, puesto from mecanicos where puesto in ('MOTOR', 'AMORTIGUADOR');

    loop
    
    fetch mecanicos_data into fila;
    exit when mecanicos_data%notfound;
    
    dbms_output.put_line('DNI: ' || fila.dni);
    dbms_output.put_line('Nombre mecanico: ' || fila.nombre);
    dbms_output.put_line('Puesto mecanico: ' || fila.puesto);
    dbms_output.put_line('');
    
    end loop;

end;

execute PD_IMPRIMIR_MECANICOS;


--3. Agregar un campo llamado "tipo_coche" en la tabla coches y luego crear un 
--procedimiento almacenado que actualice todos los registros de la tabla coches en el 
--campo tipo_coches, este campo tendrá el valor de "camioneta" para los primeros 3 
--registros, y tendrá el valor de "turismo" para los úlimos 4 registros. Los valores camioneta 
--y turismo son enviados como parámetros al procedimiento.

create or replace procedure pd_designar_tipo_coche(tipo_coche_value SYS_REFCURSOR)
is 
    cant_coches SYS_REFCURSOR;

    coches_mat coches.mat%type;
    
    valor coches.tipo_coches%type;
begin

    open cant_coches 
    for select mat from coches;

    

    fetch tipo_coche_value into valor;
    
    loop
    fetch cant_coches into coches_mat;
    
    exit when cant_coches%notfound;
        if i = 4 then
            fetch tipo_coche_value into valor;
        end if;
        
            update coches set tipo_coches = valor
            where mat = coches_mat;   
        
    end loop;

end;







