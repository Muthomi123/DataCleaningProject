--Cleaning data in sql queries

SELECT *
FROM [dbo].[NashvilleHousing]

--Standardizing date format

SELECT SaleDate,CONVERT(Date,SaleDate)
FROM [dbo].[NashvilleHousing]

Update NashvilleHousing
SET SaleDate=CONVERT(Date,SaleDate)--This still brings the older saledate column.
--Alternative method
ALTER TABLE NashvilleHousing
ADD SaleDate2 Date;

Update NashvilleHousing
SET SaleDate2=CONVERT(Date,SaleDate)

SELECT SaleDate2
FROM [dbo].[NashvilleHousing]

