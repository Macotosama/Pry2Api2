
--Procedimiento para el total facturado de el Las ventas de la labtop 
create proc pTotalesDeFacturas @IdCategoria int, @Fecha1 date, @fecha2 date, @SedeDeCompra varchar(3)
as
declare @NombreCategoria varchar(50)
set @NombreCategoria = (Select [BasePrimaria ].dbo.Categoria.nombreCategoria from [BasePrimaria ].dbo.Categoria where [BasePrimaria ].dbo.Categoria.idCategoria = @IdCategoria)

select BaseCorporativos.dbo.Factura.sedeDeCompra,[BasePrimaria ].dbo.Categoria.nombreCategoria, (sum([BasePrimaria ].dbo.Categoria.idCategoria)/[BasePrimaria ].dbo.Categoria.idCategoria)as TotalCategoria, sum([BasePrimaria ].dbo.Producto.precio)as precio from BaseCorporativos.dbo.Factura 
inner join BaseCorporativos.dbo.OrdenDeCompra on BaseCorporativos.dbo.OrdenDeCompra.IdOrdenDeCompra = BaseCorporativos.dbo.Factura.idOrdenDeCompra
inner join BaseCorporativos.dbo.CarritoCompras on BaseCorporativos.dbo.CarritoCompras.IdOrdenDeCompra = BaseCorporativos.dbo.OrdenDeCompra.IdOrdenDeCompra
inner join BaseCorporativos.dbo.Inventario on BaseCorporativos.dbo.Inventario.IdInventario = BaseCorporativos.dbo.CarritoCompras.idInventario
inner join [BasePrimaria ].dbo.Producto on [BasePrimaria ].dbo.Producto.IdProducto = BaseCorporativos.dbo.Inventario.idProducto
inner join [BasePrimaria ].dbo.Categoria on [BasePrimaria ].dbo.Categoria.idCategoria = [BasePrimaria ].dbo.Producto.idCategoria
where ([BasePrimaria ].dbo.Categoria.nombreCategoria like '%'+@NombreCategoria+'%')and(BaseCorporativos.dbo.OrdenDeCompra.fecha between @Fecha1 and @fecha2)and(BaseCorporativos.dbo.Factura.sedeDeCompra = @SedeDeCompra)
group by BaseCorporativos.dbo.Factura.sedeDeCompra, [BasePrimaria ].dbo.Categoria.nombreCategoria, [BasePrimaria ].dbo.Categoria.idCategoria, [BasePrimaria ].dbo.Producto.precio
go
------------

--Procedimiento para el total facturado de el Las ventas de la Desk 
create proc pTotalesDeFacturasCartago @IdCategoria int, @Fecha1 date, @fecha2 date, @SedeDeCompra varchar(3)
as
declare @NombreCategoria varchar(50)
set @NombreCategoria = (Select [BasePrimaria ].dbo.Categoria.nombreCategoria from [BasePrimaria ].dbo.Categoria where [BasePrimaria ].dbo.Categoria.idCategoria = @IdCategoria)
select [BasePrimaria ].dbo.Factura.sedeDeCompra,[BasePrimaria ].dbo.Categoria.nombreCategoria, (sum([BasePrimaria ].dbo.Categoria.idCategoria)/[BasePrimaria ].dbo.Categoria.idCategoria)as TotalCategoria, sum([BasePrimaria ].dbo.Producto.precio)as precio from [BasePrimaria ].dbo.Factura 
inner join [BasePrimaria ].dbo.OrdenDeCompra on [BasePrimaria ].dbo.OrdenDeCompra.IdOrdenDeCompra = [BasePrimaria ].dbo.Factura.idOrdenDeCompra
inner join [BasePrimaria ].dbo.CarritoCompras on [BasePrimaria ].dbo.CarritoCompras.IdOrdenDeCompra = [BasePrimaria ].dbo.OrdenDeCompra.IdOrdenDeCompra
inner join [BasePrimaria ].dbo.Inventario on [BasePrimaria ].dbo.Inventario.IdInventario = [BasePrimaria ].dbo.CarritoCompras.idInventario
inner join [BasePrimaria ].dbo.Producto on [BasePrimaria ].dbo.Producto.IdProducto = [BasePrimaria ].dbo.Inventario.idProducto
inner join [BasePrimaria ].dbo.Categoria on [BasePrimaria ].dbo.Categoria.idCategoria = [BasePrimaria ].dbo.Producto.idCategoria
where ([BasePrimaria ].dbo.Categoria.nombreCategoria like '%'+@NombreCategoria+'%')and([BasePrimaria ].dbo.OrdenDeCompra.fecha between @Fecha1 and @fecha2)and([BasePrimaria ].dbo.Factura.sedeDeCompra = @SedeDeCompra)
group by [BasePrimaria ].dbo.Factura.sedeDeCompra, [BasePrimaria ].dbo.Categoria.nombreCategoria, [BasePrimaria ].dbo.Categoria.idCategoria, [BasePrimaria ].dbo.Producto.precio
go

----

--Procedimeito para revisar el total consilidado
create proc pTotalConsolidado @Fecha1 date, @fecha2 date, @IdCategoria int
as

declare @NombreCategoria varchar(50)
set @NombreCategoria = (Select [BasePrimaria ].dbo.Categoria.nombreCategoria from [BasePrimaria ].dbo.Categoria where [BasePrimaria ].dbo.Categoria.idCategoria = @IdCategoria)
select BaseCorporativos.dbo.Factura.sedeDeCompra,[BasePrimaria ].dbo.Categoria.nombreCategoria, (sum([BasePrimaria ].dbo.Categoria.idCategoria)/[BasePrimaria ].dbo.Categoria.idCategoria)as TotalCategoria, sum([BasePrimaria ].dbo.Producto.precio)as precio from BaseCorporativos.dbo.Factura 
inner join BaseCorporativos.dbo.OrdenDeCompra on BaseCorporativos.dbo.OrdenDeCompra.IdOrdenDeCompra = BaseCorporativos.dbo.Factura.idOrdenDeCompra
inner join BaseCorporativos.dbo.CarritoCompras on BaseCorporativos.dbo.CarritoCompras.IdOrdenDeCompra = BaseCorporativos.dbo.OrdenDeCompra.IdOrdenDeCompra
inner join BaseCorporativos.dbo.Inventario on BaseCorporativos.dbo.Inventario.IdInventario = BaseCorporativos.dbo.CarritoCompras.idInventario
inner join [BasePrimaria ].dbo.Producto on [BasePrimaria ].dbo.Producto.IdProducto = BaseCorporativos.dbo.Inventario.idProducto
inner join [BasePrimaria ].dbo.Categoria on [BasePrimaria ].dbo.Categoria.idCategoria = [BasePrimaria ].dbo.Producto.idCategoria
where ([BasePrimaria ].dbo.Categoria.nombreCategoria like '%'+@NombreCategoria+'%')and(BaseCorporativos.dbo.OrdenDeCompra.fecha between @Fecha1 and @fecha2)
group by BaseCorporativos.dbo.Factura.sedeDeCompra, [BasePrimaria ].dbo.Categoria.nombreCategoria, [BasePrimaria ].dbo.Categoria.idCategoria, [BasePrimaria ].dbo.Producto.precio
union
select [BasePrimaria ].dbo.Factura.sedeDeCompra,[BasePrimaria ].dbo.Categoria.nombreCategoria, (sum([BasePrimaria ].dbo.Categoria.idCategoria)/[BasePrimaria ].dbo.Categoria.idCategoria)as TotalCategoria, sum([BasePrimaria ].dbo.Producto.precio) from [BasePrimaria ].dbo.Factura 
inner join [BasePrimaria ].dbo.OrdenDeCompra on [BasePrimaria ].dbo.OrdenDeCompra.IdOrdenDeCompra = [BasePrimaria ].dbo.Factura.idOrdenDeCompra
inner join [BasePrimaria ].dbo.CarritoCompras on [BasePrimaria ].dbo.CarritoCompras.IdOrdenDeCompra = [BasePrimaria ].dbo.OrdenDeCompra.IdOrdenDeCompra
inner join [BasePrimaria ].dbo.Inventario on [BasePrimaria ].dbo.Inventario.IdInventario = [BasePrimaria ].dbo.CarritoCompras.idInventario
inner join [BasePrimaria ].dbo.Producto on [BasePrimaria ].dbo.Producto.IdProducto = [BasePrimaria ].dbo.Inventario.idProducto
inner join [BasePrimaria ].dbo.Categoria on [BasePrimaria ].dbo.Categoria.idCategoria = [BasePrimaria ].dbo.Producto.idCategoria
where ([BasePrimaria ].dbo.Categoria.nombreCategoria like '%'+@NombreCategoria+'%')and([BasePrimaria ].dbo.OrdenDeCompra.fecha between @Fecha1 and @fecha2)
group by [BasePrimaria ].dbo.Factura.sedeDeCompra, [BasePrimaria ].dbo.Categoria.nombreCategoria, [BasePrimaria ].dbo.Categoria.idCategoria, [BasePrimaria ].dbo.Producto.precio
go




--Filtro para para producto y categoria que se encuentre en el inventario 
create  proc pBuscarProductoCategoriaEnInvenatrioCartago @Producto varchar(50), @Categoria int
as

select  [BasePrimaria ].dbo.Inventario.idProducto as IdInventario, [BasePrimaria ].dbo.Inventario.cantidad, [BasePrimaria ].dbo.Producto.nombreProducto, [BasePrimaria ].dbo.Producto.descripcion as Descripcion_Producto,[BasePrimaria ].dbo.Producto.imagen, [BasePrimaria ].dbo.Producto.precio, [BasePrimaria ].dbo.Categoria.idCategoria, [BasePrimaria ].dbo.Categoria.nombreCategoria, [BasePrimaria ].dbo.Categoria.descripcion as Descripcion_Categoria 
from [BasePrimaria ].dbo.Inventario inner join [BasePrimaria ].dbo.Producto on [BasePrimaria ].dbo.Producto.IdProducto = [BasePrimaria ].dbo.Inventario.idProducto inner join [BasePrimaria ].dbo.Categoria on [BasePrimaria ].dbo.Categoria.idCategoria = [BasePrimaria ].dbo.Producto.idCategoria

where ([BasePrimaria ].dbo.Producto.nombreProducto like '%'+@Producto+'%' or @Producto  = 'null')and([BasePrimaria ].dbo.Categoria.idCategoria = @Categoria or @Categoria = 0)
go


--Filtro para para producto y categoria que se encuentre en el inventario 
create  proc pBuscarProductoCategoriaEnInvenatrioLimon @Producto varchar(50), @Categoria int
as

select  BaseCorporativos.dbo.Inventario.idProducto as IdInventario, BaseCorporativos.dbo.Inventario.cantidad, [BasePrimaria ].dbo.Producto.nombreProducto, [BasePrimaria ].dbo.Producto.descripcion as Descripcion_Producto,[BasePrimaria ].dbo.Producto.imagen, [BasePrimaria ].dbo.Producto.precio, [BasePrimaria ].dbo.Categoria.idCategoria, [BasePrimaria ].dbo.Categoria.nombreCategoria, [BasePrimaria ].dbo.Categoria.descripcion as Descripcion_Categoria 
from BaseCorporativos.dbo.Inventario inner join [BasePrimaria ].dbo.Producto on [BasePrimaria ].dbo.Producto.IdProducto = BaseCorporativos.dbo.Inventario.idProducto inner join [BasePrimaria ].dbo.Categoria on [BasePrimaria ].dbo.Categoria.idCategoria = [BasePrimaria ].dbo.Producto.idCategoria

where ([BasePrimaria ].dbo.Producto.nombreProducto like '%'+@Producto+'%' or @Producto  = 'null')and([BasePrimaria ].dbo.Categoria.idCategoria = @Categoria or @Categoria = 0)
go


--Enviar todo el invantario Cartago 
create proc pRetornoInventariLimon
as
select BaseCorporativos.dbo. Inventario.IdInventario, BaseCorporativos.dbo.Inventario.cantidad, BaseCorporativos.dbo.Inventario.idProducto, [BasePrimaria ].dbo.Producto.nombreProducto, [BasePrimaria ].dbo.Producto.descripcion as Descripcion_Producto, [BasePrimaria ].dbo.Producto.idCategoria, [BasePrimaria ].dbo.Producto.precio, [BasePrimaria ].dbo.Producto.imagen, [BasePrimaria ].dbo.Categoria.nombreCategoria, [BasePrimaria ].dbo.Categoria.descripcion as Descripcion_Categoria
from BaseCorporativos.dbo.Inventario inner join [BasePrimaria ].dbo.Producto on [BasePrimaria ].dbo.Producto.IdProducto = BaseCorporativos.dbo.Inventario.idProducto inner join [BasePrimaria ].dbo.Categoria on [BasePrimaria ].dbo.Categoria.idCategoria = [BasePrimaria ].dbo.Producto.idCategoria
go


--Enviar todo el invantario 
create proc pRetornoInventarioCartago
as
select [BasePrimaria ].dbo.Inventario.IdInventario, Inventario.cantidad, [BasePrimaria ].dbo.Inventario.idProducto, [BasePrimaria ].dbo.Producto.nombreProducto, [BasePrimaria ].dbo.Producto.descripcion as Descripcion_Producto, [BasePrimaria ].dbo.Producto.idCategoria, [BasePrimaria ].dbo.Producto.precio, [BasePrimaria ].dbo.Producto.imagen, [BasePrimaria ].dbo.Categoria.nombreCategoria, [BasePrimaria ].dbo.Categoria.descripcion as Descripcion_Categoria
from [BasePrimaria ].dbo.Inventario inner join [BasePrimaria ].dbo.Producto on [BasePrimaria ].dbo.Producto.IdProducto = [BasePrimaria ].dbo.Inventario.idProducto inner join [BasePrimaria ].dbo.Categoria on [BasePrimaria ].dbo.Categoria.idCategoria = [BasePrimaria ].dbo.Producto.idCategoria
go



select GETDATE()
select * from Categoria
select * from Factura
select * from OrdenDeCompra
exec pTotalesDeFacturas 3, '2020-12-1', '2020-12-4', 'car'