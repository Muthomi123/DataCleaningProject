--Cleaning data in sql queries

SELECT *
FROM [dbo].[NashvilleHousing]

--STANDARDIZING DATE FORMAT.

		SELECT SaleDate,CONVERT(Date,SaleDate)
		FROM [dbo].[NashvilleHousing]

		Update NashvilleHousing
		SET SaleDate=CONVERT(Date,SaleDate)--This still brings the older saledate column.
	    
	--Alternative method
		ALTER TABLE NashvilleHousing
		ADD SaleDate2 Date; --Adds a new coln SaleDate2.

		Update NashvilleHousing
		SET SaleDate2=CONVERT(Date,SaleDate)--Updates converted saledate in the saledate2 coln.

		SELECT SaleDate2
		FROM [dbo].[NashvilleHousing]

	--Easier Method that updates the column and replaces the old data with the new data. 
		 ALTER TABLE NashvilleHousing
		 ALTER COLUMN SaleDate
		 DATE;
		 SELECT SaleDate
		FROM [dbo].[NashvilleHousing]

--HANDLING MISSING VALUES.
	--Populating property address data.
		--Displays all the data where Property address has no values. 
		Select *
		From [dbo].[NashvilleHousing]
		--Where PropertyAddress is null
		order by ParcelID


		--Joins the table Nashville Housing with itself on the basis of ParcelID is equal on both tables and UniqueID is not equal.
		--Displays ParcelID and PropertyAddress of the joined table with a new column of property address that doesnot have null values.
		Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
		From  [dbo].[NashvilleHousing] a
		JOIN [dbo].[NashvilleHousing] b
			on a.ParcelID = b.ParcelID
			AND a.[UniqueID ] <> b.[UniqueID ]
		Where a.PropertyAddress is null

		--Updates/Populates the original table with Property address data that doesnot contain NULL values.
		Update a
		SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
		From  [dbo].[NashvilleHousing] a
		JOIN [dbo].[NashvilleHousing] b
			on a.ParcelID = b.ParcelID
			AND a.[UniqueID ] <> b.[UniqueID ]
		Where a.PropertyAddress is null

--PARSING AND SPLITTING DATA.
	
	-- Breaking out Address into Individual Columns (Address, City, State)
		
		Select PropertyAddress
		From [dbo].[NashvilleHousing]
		--Where PropertyAddress is null
		--order by ParcelID
		--Splits The coln Property Address into two colns that is Address and City.
		SELECT
		SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
		, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as City
		From [dbo].[NashvilleHousing]

		--Adds a new column named Address on the Original table.
		ALTER TABLE NashvilleHousing
		Add Address Nvarchar(255);
		--Updates The extracted address data in the new address column.
		Update NashvilleHousing
		SET Address = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )

		--Adds a new column named City on the Original table.
		ALTER TABLE NashvilleHousing
		Add City Nvarchar(255);
		--Updates The extracted address data in the new city column.
		Update NashvilleHousing
		SET City = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))




		Select *
		From [dbo].[NashvilleHousing]




		

