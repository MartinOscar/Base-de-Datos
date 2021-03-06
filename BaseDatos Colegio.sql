USE [ASIR_OscarMartin]
GO
/****** Object:  Schema [Colegio]    Script Date: 15/06/2020 18:57:51 ******/
CREATE SCHEMA [Colegio]
GO
/****** Object:  Table [Colegio].[Alumnos]    Script Date: 15/06/2020 18:57:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Colegio].[Alumnos](
	[ID_Alumno] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](15) NULL,
	[Apellido] [varchar](30) NULL,
	[Edad] [int] NULL,
	[Direccion] [varchar](30) NULL,
	[Poblacion] [varchar](30) NULL,
	[CodigoPostal] [char](5) NULL,
	[ID_Colegio] [int] NOT NULL,
	[Telefono] [char](9) NULL,
	[FechaNacimiento] [date] NULL,
 CONSTRAINT [PK_Alumnos] PRIMARY KEY CLUSTERED 
(
	[ID_Alumno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Colegio].[Colegios]    Script Date: 15/06/2020 18:57:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Colegio].[Colegios](
	[ID_Colegio] [int] IDENTITY(1,1) NOT NULL,
	[NombreColegio] [varchar](30) NULL,
	[TipoColegio] [varchar](15) NULL,
	[Direccion] [varchar](30) NULL,
	[Telefono] [char](9) NULL,
 CONSTRAINT [PK_Colegios] PRIMARY KEY CLUSTERED 
(
	[ID_Colegio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [Colegio].[Alumnos] ON 

INSERT [Colegio].[Alumnos] ([ID_Alumno], [Nombre], [Apellido], [Edad], [Direccion], [Poblacion], [CodigoPostal], [ID_Colegio], [Telefono], [FechaNacimiento]) VALUES (1, N'Pepe', N'Gomez', 14, N'C/ Marcos 15, 3o', N'Donostia', N'20000', 1, N'654784125', NULL)
INSERT [Colegio].[Alumnos] ([ID_Alumno], [Nombre], [Apellido], [Edad], [Direccion], [Poblacion], [CodigoPostal], [ID_Colegio], [Telefono], [FechaNacimiento]) VALUES (2, N'Adrian', N'Perez', 18, N'C/Jimenez 50, 1a', N'Renteria', N'20100', 2, N'654147254', NULL)
INSERT [Colegio].[Alumnos] ([ID_Alumno], [Nombre], [Apellido], [Edad], [Direccion], [Poblacion], [CodigoPostal], [ID_Colegio], [Telefono], [FechaNacimiento]) VALUES (3, N'Marcos', N'Gonzalez', 16, N'C/Federico 23, 4o', N'Lasarte', N'25000', 1, N'654147147', NULL)
INSERT [Colegio].[Alumnos] ([ID_Alumno], [Nombre], [Apellido], [Edad], [Direccion], [Poblacion], [CodigoPostal], [ID_Colegio], [Telefono], [FechaNacimiento]) VALUES (7, N'Juan', N'Perez', 13, N'C/ maldonado 4, 6o', N'Pasaia', N'20150', 2, N'654598745', NULL)
INSERT [Colegio].[Alumnos] ([ID_Alumno], [Nombre], [Apellido], [Edad], [Direccion], [Poblacion], [CodigoPostal], [ID_Colegio], [Telefono], [FechaNacimiento]) VALUES (8, N'Paco', N'Gonzalez', 15, N'C/Maria 2, 5o', N'Lasarte', N'25000', 1, N'654147147', CAST(N'1996-02-26' AS Date))
SET IDENTITY_INSERT [Colegio].[Alumnos] OFF
SET IDENTITY_INSERT [Colegio].[Colegios] ON 

INSERT [Colegio].[Colegios] ([ID_Colegio], [NombreColegio], [TipoColegio], [Direccion], [Telefono]) VALUES (1, N'Cristobal', N'Secundaria', N'C/ Cristobal 12', N'943512478')
INSERT [Colegio].[Colegios] ([ID_Colegio], [NombreColegio], [TipoColegio], [Direccion], [Telefono]) VALUES (2, N'Seim', N'FP', N'C/ Miracruz', N'957482154')
SET IDENTITY_INSERT [Colegio].[Colegios] OFF
ALTER TABLE [Colegio].[Alumnos]  WITH CHECK ADD  CONSTRAINT [FK_Alumnos_Colegios] FOREIGN KEY([ID_Colegio])
REFERENCES [Colegio].[Colegios] ([ID_Colegio])
GO
ALTER TABLE [Colegio].[Alumnos] CHECK CONSTRAINT [FK_Alumnos_Colegios]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarAlumno]    Script Date: 15/06/2020 18:57:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Oscar
-- Create date: 15/06/2020
-- Description:	Insertar nuevo alumno que haya nacido más tarde de 31/1/2000  y viva en Donostia, Bilbao o Madrid
-- =============================================
CREATE PROCEDURE [dbo].[usp_InsertarAlumno] 
	-- Add the parameters for the stored procedure here
	@Nombre varchar(15),
	@Apellido varchar(30),
	@Edad int,
	@Direccion varchar(30),
	@Poblacion varchar(30),
	@CodigoPostal char(5),
	@ID_Colegio int,
	@Telefono char(9),
	@FechaNacimiento date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	IF @FechaNacimiento < '01/02/2000'
		BEGIN
			PRINT 'Error fecha de nacimiento';
			RETURN -1;
		END
	
	IF @Poblacion NOT IN ('Donostia', 'Bilbao', 'Madrid')

		BEGIN
				PRINT 'Ciudad Erronea';
				RETURN -2;
		END

	INSERT INTO Colegio.Alumnos (Nombre, Apellido, Edad, Direccion, Poblacion, CodigoPostal, ID_Colegio, Telefono, FechaNacimiento)
	VALUES (@Nombre, @Apellido, @Edad, @Direccion, @Poblacion, @CodigoPostal, @ID_Colegio, @Telefono, @FechaNacimiento)
END
GO
