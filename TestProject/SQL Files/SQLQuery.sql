/****** Object:  Table [dbo].[Product]    Script Date: 11/17/2020 9:36:29 PM ******/
CREATE TABLE [dbo].[Product](
	[Id] [int] NOT NULL,
	[Site] [nvarchar](50) NULL,
	[Urun] [nvarchar](50) NULL,
	[Fiyat] [money] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


-- Minimum fiyat Hesaplama
WITH minimum AS
(
select Urun, Site as 'Site', Fiyat as 'Fiyat' from [Ramazan].[dbo].Product
where Fiyat IN (select Min(Fiyat) as 'Min' from [Ramazan].[dbo].Product group by Urun)
)
select * FROM minimum


-- Maximum Fiyat Hesaplama
WITH maximum AS
(
	SELECT Urun, Site, Fiyat OVER (PARTITION BY Urun ORDER BY Fiyat DESC) AS rn
   FROM  [Ramazan].[dbo].Product
)
SELECT *
FROM maximum WHERE rn = 1;


-- Averaj Fiyat Hesaplama
select Avg(Fiyat) as Fiyat, Urun from [Ramazan].[dbo].Product group by Urun







