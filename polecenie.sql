	--	(1)
	--	utworzyæ bazê		z03zad
	--	utworzyæ schemat	[Sales]
	--	utworzyæ schemat	[Person]
	--	utworzyæ schemat	[Production]
	use z03zad
	go

	create schema Sales
	go
	
	create schema Person 
	go
	
	create schema Production 
	go 
	
	 
	
	--	(2)

	--	zgodnie ze specyfikacj¹ z pliku XLSX utworzyæ nastêpuj¹ce tabele:

		--	[Person].[Address]
		--	[Production].[Product]
		--	[Sales].[Customer]
		--	[Sales].[SalesPerson]
		--	[Sales].[SalesTerritory]	
		--	[Sales].[CurrencyRate]
		--	[Sales].[SalesOrderHeader]
		--	[Sales].[SalesOrderDetail]
		
		create table [Person].[Address]
			(
				[AddressID]						int primary key  not null, 
				[AddressLine1]					nvarchar(50) not null,
				[AddressLine2]					nvarchar(50),
				[City]							nvarchar (20) not null,
				[StateProvinceID]				int  not null , 
				[PostalCode]					nvarchar (100) 
			)
		create table [Production].[Product]
			(
				[ProductID]					int primary key not null,
				[Name]						nvarchar(50) unique not null,
				[ProductNumber]				nvarchar(50) unique not null,
				[Color]						nvarchar(15) null,
				[SafetyStockLevel]			smallint not null, 
				[ReorderPoint]				smallint not null, 
				[StandardCost]				money not null, 
				[ListPrice]					money not null, 
				[Size]						nvarchar(5) null,
				[SizeUnitMeasureCode]		nchar(3) null, 
				[WeightUnitMeasureCode]		nchar(4) null,
				[Weight]					decimal(8,2) null
			)
		create table [Sales].[Customer]
		(
			[CustomerID]						int primary key not null,
			[PersonID]							int  null, 
			[StoreID]							int  null,
			[TerritoryID]						int null,
			[AccountNumber]						varchar(15) not null
		)
		create table [Sales].[SalesPerson]
		(
			[BusinessEntityID]					int primary key not null,	
			[TerritoryID]						int null,
			[SalesQuota]						money null,
			[Bonus]								smallmoney not null,	
			[CommissionPct]						decimal not null
		)
		create table [Sales].[SalesTerritory]
		(
			[TerritoryID]						int primary key ,
			[Name]								nvarchar(40) not null,
			[CountryRegionCode]					nvarchar(5) not null,
			[Group]								nvarchar(15) not null
		)
	
		create table [Sales].[CurrencyRate]
		(
			[CurrencyRateID]					int primary key not null,
			[CurrencyRateDate]					datetime not null,
			[FromCurrencyCode]					nchar(5) not null,
			[ToCurrencyCode]					nchar(5) not null,
			[AverageRate]						money not null,
			[EndOfDayRate]						money not null
		)
		create table [Sales].[SalesOrderHeader]
		(
			[SalesOrderID]						int primary key not null,
			[SalesOrderNumber]					nvarchar(30) not null,
			[OrderDate]							date not null,
			[DueDate]							date not null,
			[ShipDate]							date not null,
			[CustomerID]						int not null,
			[SalesPersonID]						int null,
			[TerritoryID]						int not null,
			[BillToAddressID]					int not null,
			[ShipToAddressID]					int not null,	
			[CurrencyRateID]					int null,
			[SubTotal]							money not null,
			[TaxAmt]							money not null, 
			[Freight]							money not null,
			[TotalDue]							money not null
		)
		create table [Sales].[SalesOrderDetail]
		(	
			[SalesOrderDetailID]				int primary key not null, 
			[SalesOrderID]						int not null, 
			[OrderQty]							smallint not null, 
			[ProductID]							int not null, 
			[UnitPrice]							money not null, 
			[UnitPriceDiscount]					money not null
		)
		alter table Sales.SalesOrderHeader
		add constraint SalesOrderHarder_Detail
		foreign key (CurrencyRateID)
		references Sales.CurrencyRate(CurrencyRateID)

		alter table Sales.SalesOrderHeader
		add constraint Customer_SalesOrder
		foreign key (CustomerID)
		references Sales.Customer(CustomerID)

		alter table Sales.SalesOrderHeader
		add constraint BillToAddress
		foreign key (BillToAddressID)
		references [Person].[Address](AddressID)

		alter table Sales.SalesOrderHeader
		add constraint ShipToAddress
		foreign key (ShipToAddressID)
		references [Person].[Address](AddressID)

		alter table Sales.SalesOrderHeader
		add constraint Territory
		foreign key (TerritoryID)
		references Sales.SalesTerritory(TerritoryID)

		alter table Sales.SalesOrderHeader
		add constraint SalesPersonid
		foreign key (SalesPersonID)
		references Sales.SalesPerson(BusinessEntityID)

		alter table Sales.SalesOrderDetail
		add constraint SalesOrderID1
		foreign key (SalesOrderID)
		references Sales.SalesOrderHeader(SalesOrderID)

		
		alter table Sales.SalesOrderDetail
		add constraint ProductID
		foreign key (ProductID)
		references Production.Product(ProductID)
		

	--	(3)

	--	za³adowaæ dane do tabel z pliku XLSX, pamiêtaæ o kolejnoœci ³adowania wymuszonej przez utworzone FK

	--	opcja1: przy u¿yciu EDIT TOP 200
	--	opcja2:	przy u¿yciu BULK INSERT - proszê ka¿dy arkusz z danymi zapisaæ jako osobny plik CSV

	