

Select * from Region
-- Creando Mensaje personalizado del Sistema de BD
sP_addmessage 50002,1, 'El registro con ID:%d, ha sido eliminado por el usuario: %s',
                        'us_english', 'true'

-- Creación de Procedimientos Almacenados Insertar / Delete

Create procedure Insertar_Region
@RegionID int,
@NombreRegion varchar(60)
as
Insert into Region values(@RegionID, @NombreRegion)

-----------------------------------------------------------
Alter procedure Eliminar_Region
@RegionID int
as
Declare @Usuario varchar(50)
set @Usuario = SUSER_SNAME()
Delete from Region where RegionID = @RegionID
-- Ejecutamos el mensaje 
Raiserror(50002, 1,1, @RegionID, @Usuario)

Execute Insertar_Region 5, 'Centro América'

Execute Eliminar_Region 5

Create login SistemaNorthwind
with password = 'sistemas2023'
go
sp_adduser SistemaNorthwind, SistemaNorthwind
go
Grant Execute on Insertar_Region to SistemaNorthwind

Grant Execute on Eliminar_Region to SistemaNorthwind

