

-- ==================================================
-- KUMULATIVNA SKRIPTA ZA SVE PROCEDURE I FUNKCIJE
-- ==================================================
/*
=============================================
KREIRANJE INDEXE
=============================================
*/
IF NOT EXISTS (SELECT 1 FROM stage.sys.indexes WHERE object_id = OBJECT_ID('stage.zoroh.elog_dokarhiva') AND name = 'IDX_elog_dokarhiva1')
BEGIN
	CREATE NONCLUSTERED INDEX [IDX_elog_dokarhiva1]
		ON stage.[zoroh].[elog_dokarhiva] (zdrdje_id_stari_o, zdrdje_id_novi_o, datodj_o)
END
 
IF NOT EXISTS (SELECT 1 FROM stage.sys.indexes WHERE object_id = OBJECT_ID('stage.zoroh.elog_dokarhiva') AND name = 'IDX_elog_dokarhiva2')
BEGIN
	CREATE NONCLUSTERED INDEX [IDX_elog_dokarhiva2]
		ON stage.[zoroh].[elog_dokarhiva] (zdrdje_id_stari_n, zdrdje_id_novi_n, datodj_n)
END
go
/*
=============================================
ERROR TABLICE ZA SYNC
=============================================
*/


IF OBJECT_ID('errorTbls.MedicalWorkers_error_sync', 'U') IS NULL
	create table errorTbls.MedicalWorkers_error_sync (
		errorID INT PRIMARY KEY IDENTITY(1,1),
		PersonID INT,
		MedicalWorkerTypeID INT,
		MedicalWorkerZorohID INT,
		zorohIdenosJmbg NVARCHAR(MAX),
		errorMessage NVARCHAR(MAX)
	);
GO

IF OBJECT_ID('errorTbls.HealthcareInstitutions_error_sync', 'U') IS NULL
	create table errorTbls.HealthcareInstitutions_error_sync(
		errorID INT PRIMARY KEY IDENTITY(1,1),
		HealthcareInstitutionID INT,
		HealthcareInstitutionTypeID INT,
		HealthcareInstitutionCategoryID INT,
		HealthcareInstitutionCode NVARCHAR(MAX),
		SortOrder INT,
		StartActivityDate DATE,
		EndActivityDate DATE,
		ErrorMessage NVARCHAR(MAX)
	);

GO

IF OBJECT_ID('errorTbls.HealthcareInstitutionUnits_error_sync', 'U') IS NULL
	create table [errorTbls].[HealthcareInstitutionUnits_error_sync](
		[ErrorID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[CompanyID] [int] NULL,
		[CompanyStatusID] [int] NULL,
		[CompanyActivityID] [int] NULL,
		[HealthcareInstitutionTypeID] [int] NULL,
		[AddressPlaceID] [int] NULL,
		[AddressPostalCodeID] [int] NULL,
		[AddressQuarterID] [int] NULL,
		[CountryID] [int] NULL,
		[HealthcareInstitutionUnitName] [nvarchar](250) NULL,
		[HealthcareInstitutionUnitLongName] [nvarchar](1000) NULL,
		[AddressStreetName] [nvarchar](250) NULL,
		[AddressStreetCode] [nvarchar](20) NULL,
		[AddressStreetNumber] [int] NULL,
		[AddressStreetNumberCode] [nvarchar](20) NULL,
		[AddressComplements] [nvarchar](20) NULL,
		[ForeignPlace] [nvarchar](250) NULL,
		[ForeignAddress] [nvarchar](250) NULL,
		[UnitCode] [nvarchar](50) NULL,
		[ActivityCode] [nvarchar](50) NULL,
		[FoundedOn] [date] NULL,
		[TerminatedOn] [date] NULL,
		[HealthCareInstitutionLocationID] [int] NULL,
		[StartActivityDate] [date] NULL,
		[EndActivityDate] [date] NULL,
		[TaxNumber] [varchar](13) NULL,
		[Email] [varchar](50) NULL,
		[HealthcareInstitutionUnitTypeID] [tinyint] NULL,
		[PhoneNumber] [nvarchar](25) NULL,
		[VirtualUnitCode] [nvarchar](50) NULL,
		[CreatedOn] [datetime] NOT NULL,
		[CreatedBy] [nvarchar](50) NOT NULL,
		[ModifiedOn] [datetime] NOT NULL,
		[ModifiedBy] [nvarchar](50) NOT NULL,
		[ErrorMessage] [nvarchar](max) NULL,
	);

GO

IF OBJECT_ID('errorTbls.Persons_error_sync','U') IS NULL
	create table [errorTbls].[Persons_error_sync](
		[ErrorID] [int] IDENTITY(1,1) NOT NULL,
		[RegionalUnitID] [int] NULL,
		[BirthCountryID] [int] NULL,
		[GenderID] [int] NULL,
		[HomeAddressPlaceID] [int] NULL,
		[HomeAddressPostalCodeID] [int] NULL,
		[HomeAddressQuarterID] [int] NULL,
		[CurrentAddressPlaceID] [int] NULL,
		[CurrentAddressPostalCodeID] [int] NULL,
		[CurrentAddressQuarterID] [int] NULL,
		[UniqueHealthInsuranceNumber] [varchar](9) NULL,
		[UniqueIdentificationNumber] [varchar](13) NULL,
		[PersonalIdentificationNumber] [varchar](11) NULL,
		[FirstName] [nvarchar](50) NULL,
		[ParentName] [nvarchar](50) NULL,
		[LastName] [nvarchar](50) NULL,
		[HomeAddressStreetName] [nvarchar](200) NULL,
		[HomeAddressStreetCode] [nvarchar](20) NULL,
		[HomeAddressStreetNumber] [int] NULL,
		[HomeAddressStreetNumberCode] [nvarchar](20) NULL,
		[HomeAddressComplements] [nvarchar](20) NULL,
		[CurrentAddressStreetName] [nvarchar](200) NULL,
		[CurrentAddressStreetCode] [nvarchar](20) NULL,
		[CurrentAddressStreetNumber] [int] NULL,
		[CurrentAddressStreetNumberCode] [nvarchar](20) NULL,
		[CurrentAddressComplements] [nvarchar](20) NULL,
		[CitizenshipCountryID] [int] NULL,
		[BirthPlaceName] [nvarchar](200) NULL,
		[BirthDate] [date] NOT NULL,
		[DeathDate] [date] NULL,
		[Note] [nvarchar](max) NULL,
		[CreatedOn] [datetime] NOT NULL,
		[CreatedBy] [nvarchar](50) NOT NULL,
		[ModifiedOn] [datetime] NOT NULL,
		[ModifiedBy] [nvarchar](50) NOT NULL,
		[Email] [nvarchar](50) NULL,
		[MigrationID] [bigint] NULL,
		[ValidUntil] [datetime] NULL,
		[ErrorMessage] [nvarchar](max) NULL,
	 CONSTRAINT [PK_Error] PRIMARY KEY CLUSTERED 
	(
		[ErrorID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


IF OBJECT_ID('errorTbls.TaxPayers_error_sync','U') IS NULL
	create table errorTbls.TaxPayers_error_sync(
		[ErrorID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
		[ContributionPayerTypeID] [int]  NULL,
		[LinkID] [int]  NULL,
		[CompanyID] [int] NULL,
		[TaxPayerType] [bit]  NULL,
		[CreatedIn] [int] NULL,
		[CreatedOn] [datetime] NOT NULL,
		[CreatedBy] [nvarchar](50) NOT NULL,
		[ModifiedOn] [datetime] NOT NULL,
		[ModifiedBy] [nvarchar](50) NOT NULL,
		[RegionalUnitID] [int] NULL,
		[MigrationID] [int] NULL,
		[MigrationFlid] [int] NULL,
		[ValidUntil] [datetime] NULL,
		[MigrationID2] [varchar](50) NULL,
		ErrorMessage NVARCHAR(MAX)
		)

GO

IF OBJECT_ID('errorTbls.Locations_error_sync','U') IS NULL
	create table errorTbls.Locations_error_sync (
		ErrorID int identity(1,1) primary key,
		HealthcareInstitutionID INT,
		Name NVARCHAR(MAX),
		AddressPlaceID INT ,
		AddressPostalCodeID INT,
		AddressStreetName NVARCHAR(MAX),
		AddressStreetNumber NVARCHAR(MAX),
		AddressComplements NVARCHAR(MAX),
		Code NVARCHAR(MAX),
		CreatedOn DATETIME,
		CreatedBy NVARCHAR(MAX),
		ModifiedOn DATETIME,
		ModifiedBy NVARCHAR(MAX),
		ErrorMessage NVARCHAR(MAX)
	  )

IF OBJECT_ID('errorTbls.SyncErrors','U') IS NULL
	create table errorTbls.SyncErrors(
		ErrorSyncID INT IDENTITY(1,1) PRIMARY KEY,
		ErrorMessage NVARCHAR(MAX),
		ErrorTimestamp DATETIME DEFAULT GETDATE()
	)
GO

IF OBJECT_ID('errorTbls.Contracts_error_sync','U') IS NULL
	CREATE TABLE [errorTbls].[Contracts_error_sync](
	[ErrorID] [int] NOT NULL IDENTITY(1, 1),
	[ProposalID] [bigint] NULL,
	[ContractTypeID] [int] NULL,
	[HealthcareInstitutionID] [int] NULL,
	[ContractStatusID] [tinyint] NULL,
	[DocumentCreatorUserID] [int] NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[LastSignedOn] [datetime] NULL,
	[ArchiveNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ArchiveClassNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BankAccount] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ValidationNote] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ValidationDate] [datetime] NULL,
	[DateArchived] [datetime] NULL,
	[DocumentIdentifier] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DocumentGenerateTime] [datetime] NULL,
	[OriginalEndDate] [date] NULL,
	[RejectionArchiveNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RejectionClassNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TerminationNote] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TerminationDate] [datetime] NULL,
	[ValidUntil] [datetime] NULL,
	[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__Contracts__Creat__476AD776] DEFAULT (getdate()),
	[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Contracts__Creat__485EFBAF] DEFAULT (suser_sname()),
	[ModifiedOn] [datetime] NOT NULL CONSTRAINT [DF__Contracts__Modif__49531FE8] DEFAULT (getdate()),
	[ModifiedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Contracts__Modif__4A474421] DEFAULT (suser_sname()),
	[brdod] [int] NULL,
	[broj] [int] NULL,
	[flid] [int] NULL,
	[parentContractId] [int] NULL,
	[ContractModelTypeID] [int] NULL,
	[ReferentUserID] [int] NULL,
	[RegionalUnitID] [int] NULL,
	[ErrorMessage] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL)
GO

IF OBJECT_ID('errorTbls.Insurances_error_sync','U') IS NULL
	CREATE TABLE [errorTbls].[Insurances_error_sync](
		[ErrorID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
		[InsuranceTypeID] [int] NULL,
		[InsuranceCategoryID] [int] NULL,
		[TaxPayerID] [int] NULL,
		[PersonID] [int] NULL,
		[InsuranceRelationID] [int] NULL,
		[EducationLevelID] [int] NULL,
		[SubmissionDate] [date] NULL,
		[ContributionStartDate] [date] NULL,
		[StartDate] [date] NULL,
		[EndDate] [date] NULL,
		[WorkingHours] [decimal](15, 2) NULL,
		[StartNote] [nvarchar](max) NULL,
		[EndNote] [nvarchar](max) NULL,
		[CheckedOutOn] [datetime] NULL,
		[CreatedIn] [int] NULL,
		[CreatedOn] [datetime] NULL DEFAULT GETDATE(),
		[CreatedBy] [nvarchar](max) NULL DEFAULT SYSTEM_USER,
		[ModifiedOn] [datetime] NULL DEFAULT GETDATE(),
		[ModifiedBy] [nvarchar](max) NULL DEFAULT SYSTEM_USER,
		[MigrationID] [int] NULL,
		[MigrationFlid] [int] NULL,
		[errorDescription] [nvarchar](max) NULL,
	)
GO


/*
=====================================
FUNKCIJA dbo.IntervalDate
=====================================
*/

create or alter function dbo.IntervalDate (
    @dateFrom_I1 date,
    @dateTo_I1 date,
    @dateFrom_I2 date,
    @dateTo_I2 date
)
returns @Interval table (
    DatumVaziOd date,
    DatumVaziDo date
)
as
begin
    declare @dateFrom date, @dateTo date
	set @dateTo_I2 = isnull(@dateTo_I2, '2079-01-01')
    if @dateFrom_I1 > @dateTo_I2 or @dateFrom_I2 > @dateTo_I1
    begin
        insert into @Interval select null, null
   end
   else
    begin 
        set @dateFrom = case when @dateFrom_I1 > @dateFrom_I2 then @dateFrom_I1 else @dateFrom_I2 end
        set @dateTo = case when @dateTo_I1 < @dateTo_I2 then @dateTo_I1 else @dateTo_I2 end
		insert into @Interval select @dateFrom, @dateTo
   end

    return
end
go


/*
=====================================
FUNKCIJA dbo.GetMedicalWorkerTypeID
=====================================
*/

CREATE OR ALTER FUNCTION dbo.GetMedicalWorkerTypeID (@tipzdje NVARCHAR(MAX), @strspr_id INT)
RETURNS INT
AS
BEGIN
    DECLARE @MedicalWorkerTypeID INT;
	
    SELECT TOP 1 @MedicalWorkerTypeID = ISNULL(ParentMedicalWorkerTypeID, MedicalWorkerTypeID)
    FROM MedicalWorker.MedicalWorkerTypes
    WHERE 
        CASE 
            WHEN SUBSTRING(Name, 1, CHARINDEX(' (', Name)) <> N'' 
            THEN TRIM(SUBSTRING(Name, 1, CHARINDEX(' (', Name)))
            ELSE Name 
        END = @tipzdje;

    IF @MedicalWorkerTypeID IS NOT NULL
        RETURN @MedicalWorkerTypeID;

    SELECT TOP 1 @MedicalWorkerTypeID =
        CASE
            WHEN @tipzdje LIKE N'%STOMA%' THEN (SELECT ISNULL(ParentMedicalWorkerTypeID, MedicalWorkerTypeID) FROM MedicalWorker.MedicalWorkerTypes WHERE name = N'DOKTOR DENTALNE MEDICINE')
			WHEN @tipzdje LIKE N'%SPEC%' AND @tipzdje LIKE N'%DENT%' THEN (SELECT ISNULL(ParentMedicalWorkerTypeID, MedicalWorkerTypeID) FROM MedicalWorker.MedicalWorkerTypes WHERE name = N'DOKTOR DENTALNE MEDICINE')
            WHEN @tipzdje LIKE N'%LIJEČNIK%' THEN (SELECT ISNULL(ParentMedicalWorkerTypeID, MedicalWorkerTypeID) FROM MedicalWorker.MedicalWorkerTypes WHERE name = N'DOKTOR MEDICINE') 
            WHEN @tipzdje LIKE N'%SPEC%' THEN (SELECT ISNULL(ParentMedicalWorkerTypeID, MedicalWorkerTypeID) FROM MedicalWorker.MedicalWorkerTypes WHERE name = N'DOKTOR MEDICINE')
            WHEN @tipzdje LIKE N'%FARMA%' AND @strspr_id = 7 THEN (SELECT ISNULL(ParentMedicalWorkerTypeID, MedicalWorkerTypeID) FROM MedicalWorker.MedicalWorkerTypes WHERE name = N'MAGISTAR FARMACIJE STAŽIST (VISOKA)')
            WHEN (@tipzdje LIKE N'%DENTALNI TEH%' OR  @tipzdje LIKE N'%ZUBNI TEH%') AND @strspr_id = 6 THEN (SELECT ISNULL(ParentMedicalWorkerTypeID, MedicalWorkerTypeID) from MedicalWorker.MedicalWorkerTypes where name = N'DENTALNI TEHNIČAR (VIŠA)')
			WHEN (@tipzdje LIKE N'%DENTALNI TEH%' OR  @tipzdje LIKE N'%ZUBNI TEH%')  AND @strspr_id = 4 THEN (SELECT ISNULL(ParentMedicalWorkerTypeID, MedicalWorkerTypeID) from MedicalWorker.MedicalWorkerTypes where name = N'DENTALNI TEHNIČAR (SREDNJA)')
			WHEN @tipzdje LIKE N'%LOGOPED%' AND @strspr_id = 7 THEN (SELECT ISNULL(ParentMedicalWorkerTypeID, MedicalWorkerTypeID) from MedicalWorker.MedicalWorkerTypes where name = N'MAG. LOGOPED')
			WHEN @tipzdje LIKE N'%BOLNIČAR%' THEN (SELECT ISNULL(ParentMedicalWorkerTypeID, MedicalWorkerTypeID) from MedicalWorker.MedicalWorkerTypes where name = N'BOLNIČAR (NIŽA)')
			WHEN @tipzdje LIKE N'%NJEGOVATE%' THEN (SELECT ISNULL(ParentMedicalWorkerTypeID, MedicalWorkerTypeID) from MedicalWorker.MedicalWorkerTypes where name = N'NJEGOVATELJICA (TEČAJ) (NIŽA)')
			WHEN @tipzdje LIKE N'%BABICA%' THEN (SELECT ISNULL(ParentMedicalWorkerTypeID, MedicalWorkerTypeID) from MedicalWorker.MedicalWorkerTypes where name = N'BABICA (NIŽA)')
			WHEN @tipzdje LIKE N'%RADIOLO%' and @strspr_id = 6 THEN (SELECT ISNULL(ParentMedicalWorkerTypeID, MedicalWorkerTypeID) from MedicalWorker.MedicalWorkerTypes where name = N'RADIOLOŠKI INŽENJER (VIŠA)')
			WHEN @tipzdje LIKE N'%SANITAR%' and @strspr_id = 4 THEN (SELECT ISNULL(ParentMedicalWorkerTypeID, MedicalWorkerTypeID) from MedicalWorker.MedicalWorkerTypes where name = N'SANITARNI TEHNIČAR (SREDNJA)')
			WHEN @tipzdje LIKE N'%SANITAR%' and @strspr_id = 7 THEN (SELECT ISNULL(ParentMedicalWorkerTypeID, MedicalWorkerTypeID) from MedicalWorker.MedicalWorkerTypes where name = N'DIPL. SANITARNI INŽENJER')
			WHEN @tipzdje LIKE N'%DIJETETI%' and @strspr_id = 7 THEN (SELECT ISNULL(ParentMedicalWorkerTypeID, MedicalWorkerTypeID) from MedicalWorker.MedicalWorkerTypes where name = N'DIJETETIČAR (P.A.) (VIŠA)')
			WHEN @tipzdje LIKE N'%MAGISTAR FIZIOTERAPIJE%' and @strspr_id = 7 THEN (SELECT ISNULL(ParentMedicalWorkerTypeID, MedicalWorkerTypeID) from MedicalWorker.MedicalWorkerTypes where name = N'MAG. FIZIOTERAPIJE (VISOKA)')
			WHEN @tipzdje LIKE N'%BACC PRIMALJSTVA%' THEN (SELECT ISNULL(ParentMedicalWorkerTypeID, MedicalWorkerTypeID) from MedicalWorker.MedicalWorkerTypes where name = N'BACC. PRIMALJSTVA (VIŠA)')
			WHEN @tipzdje LIKE N'%MAG.MOLEKULARNE BIOLOGIJE%' THEN (SELECT ISNULL(ParentMedicalWorkerTypeID, MedicalWorkerTypeID) from MedicalWorker.MedicalWorkerTypes where name = N'MAG. MOLEKULARNE BIOLOGIJE')
			WHEN @tipzdje LIKE N'%DIJETETIČAR (P.A.)%' THEN (SELECT ISNULL(ParentMedicalWorkerTypeID, MedicalWorkerTypeID) from MedicalWorker.MedicalWorkerTypes where name = N'DIJETETIČAR (P.A.) (VIŠA)')
			WHEN @tipzdje LIKE N'%MAG.RADIOL%' AND @strspr_id = 7 THEN (SELECT ISNULL(ParentMedicalWorkerTypeID, MedicalWorkerTypeID) from MedicalWorker.MedicalWorkerTypes where name = N'RADIOLOŠKI INŽENJER (VIŠA)')
			WHEN @tipzdje LIKE N'%DIPL.ING.KEMIJSKE TEHNOLOGIJE%' AND @strspr_id = 7 THEN (SELECT ISNULL(ParentMedicalWorkerTypeID, MedicalWorkerTypeID) from MedicalWorker.MedicalWorkerTypes where name = N'DIPL.ING. KEMIJSKE TEHNOLOGIJE')
            
			ELSE (SELECT ISNULL(ParentMedicalWorkerTypeID, MedicalWorkerTypeID) FROM MedicalWorker.MedicalWorkerTypes WHERE name = N'NEPOZNATO')
        END;

    RETURN @MedicalWorkerTypeID;
END;

GO

/*
============================================
PROCEDURA [dbo].[CompaniesSync]
============================================
*/

CREATE OR ALTER  PROCEDURE [dbo].[CompaniesSync]	
AS
	BEGIN /* Region Insert */

		-- kreiram temp tabelu gde ce biti samo 'sif' iz tabele elog_pospar koje treba da se insertuju (al_a = 'I')
		IF object_id('companies_insert','U') IS NOT NULL
			DROP TABLE companies_insert;

		SELECT 
			DISTINCT(sif) AS pospar_sif
		INTO companies_insert
		FROM stage.zoroh.elog_pospar
		WHERE al_a = 'I' AND sif IS NOT NULL
			AND sif NOT IN (SELECT Code FROM dbo.Companies)


--=====================================
-- INSERT novih redova u dbo.Companies
--=====================================
		;WITH country AS (
			SELECT 
				IsoCode3,
				MAX(CountryID) AS CountryID
			FROM dbo.Countries
			GROUP BY IsoCode3
		)
		INSERT INTO dbo.Companies (
			[CompanyStatusID],  
			[CompanyActivityID], 
			[AddressPlaceID], 
			[AddressPostalCodeID], 
		--	[AddressQuarterID], 
			[CountryID], 
			[Code], 
			[PersonalIdentificationNumber], 
			[UniqueIdentificationNumber], 
			[ExternalRegistryNumber],
			[ExternalRegistryTypeID], 
			[Name],
			[LongName], 
			[AddressStreetName],
		--	[AddressStreetCode], 
			[AddressStreetNumber], 
		--	[AddressStreetNumberCode], 
			[AddressComplements], 
			[ForeignAddress], 
			[ForeignPlace], 
			[FoundedOn], 
			[TerminatedOn], 
			[CompanyTypeID], 
			[CreatedOn], 
			[CreatedBy], 
			[ModifiedOn], 
			[ModifiedBy],
			[ValidUntil]
		)
		SELECT 
			CASE 
				WHEN (ISNULL(pospar.dkrajp, '') = '') THEN 1  
				ELSE 2
			END							AS [CompanyStatusID], 
			ca.CompanyActivityID		AS [CompanyActivityID], 
			adresa.MunicipalityPlaceID	AS [AddressPlaceID], 
			adresa.PostalCodeID			AS [AddressPostalCodeID], 
		--	AS [AddressQuarterID], 
			country.CountryID			AS [CountryID], 
			pospar.sif					AS [Code], 
			COALESCE (a.oib, b.oib)		AS [PersonalIdentificationNumber], 
			CASE 
				WHEN pospar.matbr = '0' THEN NULL
				ELSE pospar.matbr
			END							AS [UniqueIdentificationNumber],
			CASE 
				WHEN (SUBSTRING(matbr,1,1) = '9') THEN pospar.matbr
				WHEN (SUBSTRING(matbr, 1,1) = '0') THEN pospar.matbr
				ELSE NULL
			END							AS [ExternalRegistryNumber],  
			CASE WHEN SUBSTRING(matbr,1,1) = '9' 
					then 1
				when SUBSTRING(matbr, 1,1) = '0' and a.oib is not null 
					then 2 
				else null 
			end							AS [ExternalRegistryTypeID],
			pospar.tvrtka				AS [Name], 
			pospar.naziv				AS [LongName], 
			pospar.ulica_naziv			AS [AddressStreetName], 
		--	[AddressStreetCode], 
			case when PATINDEX('%[^0-9]%', pospar.kucbr) > 0 and PATINDEX('%[0-9]%', left(pospar.kucbr, PATINDEX('%[^0-9]%', pospar.kucbr) -1) ) > 0  
					then left(pospar.kucbr, PATINDEX('%[^0-9]%', pospar.kucbr) -1) 
				when PATINDEX('%[^0-9]%', pospar.kucbr) > 0 and PATINDEX('%[0-9]%', left(pospar.kucbr, PATINDEX('%[^0-9]%', pospar.kucbr) -1) ) = 0  
					then null
				when pospar.kucbr = '' 
					then null
				else pospar.kucbr 
			end							AS [AddressStreetNumber], 
		--	[AddressStreetNumberCode], 
			case when PATINDEX('%[^0-9]%', trim(pospar.kucbr)) > 0 and PATINDEX('[^A-Za-z0-9, ]%', substring(pospar.kucbr, PATINDEX('%[^0-9]%', pospar.kucbr),len (pospar.kucbr) - PATINDEX('%[^0-9]%', pospar.kucbr)+1 )) =1
					then trim(substring(pospar.kucbr, PATINDEX('%[^0-9]%', pospar.kucbr)+1,len (pospar.kucbr) - PATINDEX('%[^0-9]%', pospar.kucbr) +1))
				when PATINDEX('%[^0-9]%', trim(pospar.kucbr)) > 0 
					then trim(substring(pospar.kucbr, PATINDEX('%[^0-9]%', pospar.kucbr),len (pospar.kucbr) - PATINDEX('%[^0-9]%', pospar.kucbr)+1 ))	
				when pospar.kucbr = ''
					then null
				else null 
			end							AS [AddressComplements], 
			pospar.inost				AS [ForeignAddress], 
			pospar.inonas				AS [ForeignPlace], 
			pospar.dpocp				AS [FoundedOn], 
			pospar.dkrajp				AS [TerminatedOn], 
			case when pospar.matbr is not null then 
					(select CompanyTypeID from dbo.CompanyTypes where UINStartsWith = SUBSTRING(pospar.matbr,1,1))
				when pospar.matbr IS null and pospar.idenos_jmbg IS Not null then 5
				else 6 
			end							AS [CompanyTypeID], 
			GETDATE()					AS [CreatedOn], 
			'MIGRACIJA'					AS [CreatedBy], 
			GETDATE()					AS [ModifiedOn], 
			'MIGRACIJA'					AS [ModifiedBy],
			NULL						AS [ValidUntil]
		FROM stage.zoroh.pospar pospar
			INNER JOIN companies_insert ci ON pospar.sif = ci.pospar_sif
			LEFT JOIN 
				(select pospar_sif, 
						oib, 
						datod, 
						datdo,
						rank() over (partition by pospar_sif order by isnull(datdo, getdate()) desc) as rnk 
				from stage.zoroh.oibreg
				where oibreg.pospar_sif is not null) a on a.pospar_sif = pospar.sif and a.rnk = 1	
			LEFT JOIN 
				(select idenos_jmbg, 
						oib, 
						rank() over (partition by idenos_jmbg order by isnull(datdo, getdate()) desc) as rnk 
				from stage.zoroh.oibreg
				where oibreg.idenos_jmbg is not null) b on b.idenos_jmbg = pospar.idenos_jmbg  and b.rnk = 1		
			LEFT JOIN (
				select MunicipalityPlaceID, 
						PostalCodeID, 
						Migrationid 
				from dbo.MunicipalityPlacePostalCodes) adresa on pospar.naselje_id = adresa.Migrationid
			LEFT JOIN country on pospar.drzava_ik3= country.IsoCode3	
			LEFT JOIN stage.zoroh.oibpra on a.oib = oibpra.oib 
			LEFT JOIN stage.zoroh.djelnkd on oibpra.nkdsif = djelnkd.sifra and djelnkd.datdo is null
			LEFT JOIN dbo.CompanyActivities ca on djelnkd.id = ca.MigrationID
--		WHERE pospar.sif NOT IN (SELECT Code FROM dbo.Companies)

		-- update za ExternalRegistryNumber i ExternalRegistryTypeID
		;with cte as (
			select 
				mbdzzs, 
				oib, 
				mb, 
				naztvr
			from stage.zoroh.oibpra
			)
		UPDATE dbo.Companies 
		SET ExternalRegistryNumber = cte.mbdzzs,
			ExternalRegistryTypeID = 1
		FROM dbo.Companies d
			INNER JOIN companies_insert ci on d.Code = ci.pospar_sif
			JOIN cte ON d.PersonalIdentificationNumber = cte.oib

		;with cte as (
			select 
				mbdzzs, 
				oib, 
				mb, 
				naztvr 
			from stage.zoroh.oibpra
				)	
		UPDATE dbo.Companies 
		SET ExternalRegistryTypeID = 2
		FROM dbo.Companies d
			INNER JOIN companies_insert ci on d.Code = ci.pospar_sif
			LEFT JOIN cte ON d.PersonalIdentificationNumber = cte.oib
		where (cte.oib is null or cte.mbdzzs is null) and d.ExternalRegistryNumber is not null



--==================================================================
-- nove redove upisujemo i u stage tabelu - stage.stg.stg_Companies
--==================================================================
		;WITH country AS (
			SELECT 
				IsoCode3,
				MAX(CountryID) AS CountryID
			FROM dbo.Countries
			GROUP BY IsoCode3
		)
		INSERT INTO stage.stg.stg_Companies 
		SELECT  
			cast(pospar.sif as varchar(20)) as pospar_sif, -- Code
			pospar.tvrtka as pospar_kratki_naziv, -- Name
			pospar.naziv as pospar_dugi_naziv, -- LongName
			pospar.dpocp as pospar_dat_poc, -- FoundedOn
			pospar.dkrajp as pospar_dat_kraj, -- TerminatedOn
			pospar.ulica_naziv as pospar_ulica, -- AddressStreetName
			pospar.kucbr as pospar_kucBr, 
			case when PATINDEX('%[^0-9]%', pospar.kucbr) > 0 and PATINDEX('%[0-9]%', left(pospar.kucbr, PATINDEX('%[^0-9]%', pospar.kucbr) -1) ) > 0  
					then left(pospar.kucbr, PATINDEX('%[^0-9]%', pospar.kucbr) -1) 
				when PATINDEX('%[^0-9]%', pospar.kucbr) > 0 and PATINDEX('%[0-9]%', left(pospar.kucbr, PATINDEX('%[^0-9]%', pospar.kucbr) -1) ) = 0  
					then null
				when pospar.kucbr = '' 
					then null
				else pospar.kucbr 
			end as pospar_kucbr_num, 
			case when PATINDEX('%[^0-9]%', trim(pospar.kucbr)) > 0 and PATINDEX('[^A-Za-z0-9, ]%', substring(pospar.kucbr, PATINDEX('%[^0-9]%', pospar.kucbr),len (pospar.kucbr) - PATINDEX('%[^0-9]%', pospar.kucbr)+1 )) =1
					then trim(substring(pospar.kucbr, PATINDEX('%[^0-9]%', pospar.kucbr)+1,len (pospar.kucbr) - PATINDEX('%[^0-9]%', pospar.kucbr) +1))
				when PATINDEX('%[^0-9]%', trim(pospar.kucbr)) > 0 
					then trim(substring(pospar.kucbr, PATINDEX('%[^0-9]%', pospar.kucbr),len (pospar.kucbr) - PATINDEX('%[^0-9]%', pospar.kucbr)+1 ))	
				when pospar.kucbr = ''
					then null
				else null 
			end as pospar_kucbr_com, 
			pospar.naselje_id as pospar_naselje_id, 
			pospar.drzava_ik3 as pospar_drzava, -- 
			pospar.inonas as pospar_ino_naselje, -- ForeignPlace
			pospar.inost as pospar_ino_ulica, -- ForeignAddress
			cast(pospar.matbr as varchar(4000)) as pospar_matbr, -- UniqueIdentificationNumber
			case when SUBSTRING(matbr,1,1) = '9' -- obrt, zanat
					then 1
				when SUBSTRING(matbr, 1,1) = '0' and a.oib is not null -- doo
					then 2 
				else null 
			end as pospar_obrt, 
			coalesce (cast(a.oib as char(11)), cast(b.oib as char(11)))  as pospar_oib, -- PersonalIdentificationNumber 
			coalesce(a.rnk, 1) as OIBrank, 
			a.datod as oibDatOd, 
			a.datdo as oibDatDo,
			oibpra.nkdsif, -- šifra delatnosti
			djelnkd.id as nkdid, -- isto delatnosti
			null as pospar_tel,
			null as pospar_email,
			adresa.MunicipalityPlaceID, -- AddressPlaceID
			adresa.PostalCodeID, -- AddressPostalCodeID
			country.CountryID, -- CountryID
			CompanyActivities.CompanyActivityID,
			rank() over (partition by pospar.matbr order by ISNULL(dkrajp,'2099-01-01') desc , sif desc) as matbrRank,
			rank() over (partition by pospar.matbr order by pospar.dkrajp desc ) as rnkTEST,
			dense_rank() over (order by pospar.matbr ) as drnk,
			case when pospar.matbr is not null then 
					(select CompanyTypeId from dbo.CompanyTypes where UINStartsWIth = SUBSTRING(matbr,1,1))
				when pospar.matbr IS null and pospar.idenos_jmbg IS Not null then 5
				else 6 
			end as CompanyTypeId, -- CompanyTipeID
			null as sif_sljednik,
			pospar.idenos_jmbg as idenos_jmbg

		FROM stage.zoroh.pospar pospar
			INNER JOIN companies_insert ci ON pospar.sif = ci.pospar_sif
			left join 
				(select pospar_sif, 
						oib, 
						datod, 
						datdo,
						rank() over (partition by pospar_sif order by isnull(datdo, getdate()) desc) as rnk 
				from stage.zoroh.oibreg
				where oibreg.pospar_sif is not null) a  on a.pospar_sif = pospar.sif and a.rnk = 1

			LEFT join 
				(select idenos_jmbg, 
						oib, 
						rank() over (partition by idenos_jmbg order by isnull(datdo, getdate()) desc) as rnk 
				from stage.zoroh.oibreg
				where oibreg.idenos_jmbg is not null) b  on b.idenos_jmbg = pospar.idenos_jmbg  and b.rnk = 1

			left join stage.zoroh.oibpra on a.oib = oibpra.oib 
			left join stage.zoroh.djelnkd on oibpra.nkdsif = djelnkd.sifra and djelnkd.datdo is null
			left join (
				select MunicipalityPlaceID, 
						PostalCodeID, 
						Migrationid 
				from dbo.MunicipalityPlacePostalCodes) adresa on pospar.naselje_id = adresa.Migrationid
			LEFT JOIN country on pospar.drzava_ik3= country.IsoCode3	
			left join dbo.CompanyActivities on djelnkd.id = CompanyActivities.MigrationID
--		WHERE pospar.sif NOT IN (SELECT pospar_sif FROM stage.stg.stg_Companies)


		-- dodaj sljednika za zapise koji su povijesni radi visetrukog upisa matbr
		update c1
		set sif_sljednik = c2.pospar_sif
		from stage.stg.stg_Companies c1
			join stage.stg.stg_Companies c2 on c1.drnk = c2.drnk 
		where (c1.matbrRank > 1 and  c1.pospar_matbr is not null and c1.pospar_matbr<> '') and c2.matbrRank = 1

		update c1
		set sif_sljednik = c1.pospar_sif
		from stage.stg.stg_Companies c1
		where c1.sif_sljednik is null

		-- drop temp tabele
		DROP TABLE companies_insert;

	END -- kraj dela za insert


	BEGIN /* Region Update */

		-- kreiram temp tabelu gde ce biti samo 'sif' iz tabele elog_pospar koje treba da se upadateuju (al_a = 'U')
		IF object_id('companies_update','U') IS NOT NULL
			DROP TABLE companies_update;

		SELECT 
			DISTINCT(sif) AS pospar_sif
		INTO companies_update
		FROM stage.zoroh.elog_pospar
		WHERE al_a = 'U' AND sif IS NOT NULL
			AND sif IN (SELECT Code FROM dbo.Companies)


		-- napuniti temp tabelu podacima koji treba da se updateuju samo za sifre iz sif_update tabele
		DROP TABLE IF EXISTS temp_companies;

		WITH country AS (
			SELECT 
				IsoCode3,
				MAX(CountryID) AS CountryID
			FROM dbo.Countries
			GROUP BY IsoCode3
		)
		SELECT
			CASE 
				WHEN (ISNULL(pospar.dkrajp, '') = '') THEN 1  
				ELSE 2
			END							AS [CompanyStatusID], 
			ca.CompanyActivityID		AS [CompanyActivityID], 
			adresa.MunicipalityPlaceID	AS [AddressPlaceID], 
			adresa.PostalCodeID			AS [AddressPostalCodeID], 
			country.CountryID			AS [CountryID], 
			pospar.sif					AS [Code], 
			COALESCE (a.oib, b.oib)		AS [PersonalIdentificationNumber], 
			CASE 
				WHEN pospar.matbr = '0' THEN NULL
				ELSE pospar.matbr
			END							AS [UniqueIdentificationNumber],
			CASE 
				WHEN (SUBSTRING(matbr,1,1) = '9') THEN pospar.matbr
				WHEN (SUBSTRING(matbr, 1,1) = '0') THEN pospar.matbr
				ELSE NULL
			END							AS [ExternalRegistryNumber],  
			CASE WHEN SUBSTRING(matbr,1,1) = '9' 
					then 1
				when SUBSTRING(matbr, 1,1) = '0' and a.oib is not null 
					then 2 
				else null 
			end							AS [ExternalRegistryTypeID],
			pospar.tvrtka				AS [Name], 
			pospar.naziv				AS [LongName], 
			pospar.ulica_naziv			AS [AddressStreetName], 
			case when PATINDEX('%[^0-9]%', pospar.kucbr) > 0 and PATINDEX('%[0-9]%', left(pospar.kucbr, PATINDEX('%[^0-9]%', pospar.kucbr) -1) ) > 0  
					then left(pospar.kucbr, PATINDEX('%[^0-9]%', pospar.kucbr) -1) 
				when PATINDEX('%[^0-9]%', pospar.kucbr) > 0 and PATINDEX('%[0-9]%', left(pospar.kucbr, PATINDEX('%[^0-9]%', pospar.kucbr) -1) ) = 0  
					then null
				when pospar.kucbr = '' 
					then null
				else pospar.kucbr 
			end							AS [AddressStreetNumber], -- NULL,
			case when PATINDEX('%[^0-9]%', trim(pospar.kucbr)) > 0 and PATINDEX('[^A-Za-z0-9, ]%', substring(pospar.kucbr, PATINDEX('%[^0-9]%', pospar.kucbr),len (pospar.kucbr) - PATINDEX('%[^0-9]%', pospar.kucbr)+1 )) =1
					then trim(substring(pospar.kucbr, PATINDEX('%[^0-9]%', pospar.kucbr)+1,len (pospar.kucbr) - PATINDEX('%[^0-9]%', pospar.kucbr) +1))
				when PATINDEX('%[^0-9]%', trim(pospar.kucbr)) > 0 
					then trim(substring(pospar.kucbr, PATINDEX('%[^0-9]%', pospar.kucbr),len (pospar.kucbr) - PATINDEX('%[^0-9]%', pospar.kucbr)+1 ))	
				when pospar.kucbr = ''
					then null
				else null 
			end							AS [AddressComplements], 
			pospar.inost				AS [ForeignAddress], 
			pospar.inonas				AS [ForeignPlace], 
			pospar.dpocp				AS [FoundedOn], 
			pospar.dkrajp				AS [TerminatedOn], 
			case when pospar.matbr is not null then 
					(select CompanyTypeID from dbo.CompanyTypes where UINStartsWith = SUBSTRING(pospar.matbr,1,1))
				when pospar.matbr IS null and pospar.idenos_jmbg IS Not null then 5
				else 6 
			end							AS [CompanyTypeID], 
			GETDATE()					AS [CreatedOn], 
			'MIGRACIJA'					AS [CreatedBy], 
			GETDATE()					AS [ModifiedOn], 
			'MIGRACIJA'					AS [ModifiedBy] 
		INTO temp_companies
		FROM stage.zoroh.pospar pospar
			INNER JOIN companies_update cu ON pospar.sif = cu.pospar_sif
			LEFT JOIN 
				(select pospar_sif, 
						oib, 
						datod, 
						datdo,
						rank() over (partition by pospar_sif order by isnull(datdo, getdate()) desc) as rnk 
				from stage.zoroh.oibreg
				where oibreg.pospar_sif is not null) a on a.pospar_sif = pospar.sif and a.rnk = 1	
			LEFT JOIN 
				(select idenos_jmbg, 
						oib, 
						rank() over (partition by idenos_jmbg order by isnull(datdo, getdate()) desc) as rnk 
				from stage.zoroh.oibreg
				where oibreg.idenos_jmbg is not null) b on b.idenos_jmbg = pospar.idenos_jmbg  and b.rnk = 1		
			LEFT JOIN (
				select MunicipalityPlaceID, 
						PostalCodeID, 
						Migrationid 
				from dbo.MunicipalityPlacePostalCodes) adresa on pospar.naselje_id = adresa.Migrationid
			LEFT JOIN country on pospar.drzava_ik3= country.IsoCode3	
			left join stage.zoroh.oibpra on a.oib = oibpra.oib 
			left join stage.zoroh.djelnkd on oibpra.nkdsif = djelnkd.sifra and djelnkd.datdo is null
			left join dbo.CompanyActivities ca on djelnkd.id = ca.MigrationID
		WHERE pospar.sif IS NOT NULL


--======================
-- UPDATE dbo.Companies
--======================
		UPDATE dbo.Companies
		SET 
			CompanyStatusID = tc.CompanyStatusID, 
			CompanyActivityID = tc.CompanyActivityID,
			AddressPlaceID = tc.AddressPlaceID,
			AddressPostalCodeID = tc.AddressPostalCodeID,
			CountryID = tc.CountryID,
			Code = tc.Code,
			PersonalIdentificationNumber = tc.PersonalIdentificationNumber,
			UniqueIdentificationNumber = tc.UniqueIdentificationNumber,
			ExternalRegistryNumber = tc.ExternalRegistryNumber,
			ExternalRegistryTypeID = tc.ExternalRegistryTypeID,
			Name = tc.Name,
			LongName = tc.LongName,
			AddressStreetName = tc.AddressStreetName,
			AddressStreetNumber = tc.AddressStreetNumber,
			AddressComplements = tc.AddressComplements,
			ForeignAddress = tc.ForeignAddress,
			ForeignPlace = tc.ForeignPlace,
			FoundedOn = tc.FoundedOn,
			TerminatedOn = tc.TerminatedOn,
			CompanyTypeID = tc.CompanyTypeID,
			CreatedOn = tc.CreatedOn,
			CreatedBy = tc.CreatedBy,
			ModifiedOn = tc.ModifiedOn,
			ModifiedBy = tc.ModifiedBy
		FROM dbo.Companies comp
			INNER JOIN temp_companies tc ON tc.Code = comp.Code


		-- update za ExternalRegistryNumber i ExternalRegistryTypeID
		;with cte as (
			select 
				mbdzzs, 
				oib, 
				mb, 
				naztvr
			from stage.zoroh.oibpra
			)
		UPDATE dbo.Companies 
		SET ExternalRegistryNumber = cte.mbdzzs,
			ExternalRegistryTypeID = 1
		FROM dbo.Companies d
			inner join companies_update ci on d.Code = ci.pospar_sif
			JOIN cte ON d.PersonalIdentificationNumber = cte.oib

		;with cte as (
			select 
				mbdzzs, 
				oib, 
				mb, 
				naztvr 
			from stage.zoroh.oibpra
				)	
		UPDATE dbo.Companies 
		SET ExternalRegistryTypeID = 2
		FROM dbo.Companies d
			inner join companies_update ci on d.Code = ci.pospar_sif
			left JOIN cte ON d.PersonalIdentificationNumber = cte.oib
		WHERE (cte.oib is null or cte.mbdzzs is null) and d.ExternalRegistryNumber is not null



--==================================================================
-- update stage tabele - stage.stg.stg_Companies
--==================================================================

-- napuniti temp tabelu podacima koji treba da se updateuju u stage tabeli
		DROP TABLE IF EXISTS temp_companies_stage;

		WITH country AS (
			SELECT 
				IsoCode3,
				MAX(CountryID) AS CountryID
			FROM dbo.Countries
			GROUP BY IsoCode3
		)
		SELECT 
			cast(pospar.sif as varchar(20)) as pospar_sif, -- Code
			pospar.tvrtka as pospar_kratki_naziv, -- Name
			pospar.naziv as pospar_dugi_naziv, -- LongName
			pospar.dpocp as pospar_dat_poc, -- FoundedOn
			pospar.dkrajp as pospar_dat_kraj, -- TerminatedOn
			pospar.ulica_naziv as pospar_ulica, -- AddressStreetName
			pospar.kucbr as pospar_kucBr, 
			case when PATINDEX('%[^0-9]%', pospar.kucbr) > 0 and PATINDEX('%[0-9]%', left(pospar.kucbr, PATINDEX('%[^0-9]%', pospar.kucbr) -1) ) > 0  
					then left(pospar.kucbr, PATINDEX('%[^0-9]%', pospar.kucbr) -1) 
				when PATINDEX('%[^0-9]%', pospar.kucbr) > 0 and PATINDEX('%[0-9]%', left(pospar.kucbr, PATINDEX('%[^0-9]%', pospar.kucbr) -1) ) = 0  
					then null
				when pospar.kucbr = '' 
					then null
				else pospar.kucbr 
			end as pospar_kucbr_num, -- AddressStreetNumber
			case when PATINDEX('%[^0-9]%', trim(pospar.kucbr)) > 0 and PATINDEX('[^A-Za-z0-9, ]%', substring(pospar.kucbr, PATINDEX('%[^0-9]%', pospar.kucbr),len (pospar.kucbr) - PATINDEX('%[^0-9]%', pospar.kucbr)+1 )) =1
					then trim(substring(pospar.kucbr, PATINDEX('%[^0-9]%', pospar.kucbr)+1,len (pospar.kucbr) - PATINDEX('%[^0-9]%', pospar.kucbr) +1))
				when PATINDEX('%[^0-9]%', trim(pospar.kucbr)) > 0 
					then trim(substring(pospar.kucbr, PATINDEX('%[^0-9]%', pospar.kucbr),len (pospar.kucbr) - PATINDEX('%[^0-9]%', pospar.kucbr)+1 ))	
				when pospar.kucbr = ''
					then null
				else null 
			end as pospar_kucbr_com, -- AddressComplements
			pospar.naselje_id as pospar_naselje_id, 
			pospar.drzava_ik3 as pospar_drzava, -- 
			pospar.inonas as pospar_ino_naselje, -- ForeignPlace
			pospar.inost as pospar_ino_ulica, -- ForeignAddress
			cast(pospar.matbr as varchar(4000)) as pospar_matbr, -- UniqueIdentificationNumber
			case when SUBSTRING(matbr,1,1) = '9' -- obrt, zanat
					then 1
				when SUBSTRING(matbr, 1,1) = '0' and a.oib is not null -- doo
					then 2 
				else null 
			end as pospar_obrt, 
			coalesce (cast(a.oib as char(11)), cast(b.oib as char(11)))  as pospar_oib, -- PersonalIdentificationNumber 
			coalesce(a.rnk, 1) as OIBrank, 
			a.datod as oibDatOd, 
			a.datdo as oibDatDo,
			oibpra.nkdsif, -- šifra delatnosti
			djelnkd.id as nkdid, -- isto delatnosti
			null as pospar_tel,
			null as pospar_email,
			adresa.MunicipalityPlaceID, -- AddressPlaceID
			adresa.PostalCodeID, -- AddressPostalCodeID
			country.CountryID, -- CountryID
			ca.CompanyActivityID AS CompanyActivityID,
			rank() over (partition by pospar.matbr order by ISNULL(dkrajp,'2099-01-01') desc , sif desc) as matbrRank,
			rank() over (partition by pospar.matbr order by pospar.dkrajp desc ) as rnkTEST,
			dense_rank() over (order by pospar.matbr ) as drnk,
			case when pospar.matbr is not null then 
					(select CompanyTypeId from dbo.CompanyTypes where UINStartsWIth = SUBSTRING(matbr,1,1))
				when pospar.matbr IS null and pospar.idenos_jmbg IS Not null then 5
				else 6 
			end as CompanyTypesId, -- CompanyTipeID
			null as sif_sljednik,
			pospar.idenos_jmbg as idenos_jmbg

		INTO temp_companies_stage

		FROM stage.zoroh.pospar pospar
			INNER JOIN companies_update cu ON pospar.sif = cu.pospar_sif
			LEFT JOIN 
				(select pospar_sif, 
						oib, 
						datod, 
						datdo,
						rank() over (partition by pospar_sif order by isnull(datdo, getdate()) desc) as rnk 
				from stage.zoroh.oibreg
				where oibreg.pospar_sif is not null) a on a.pospar_sif = pospar.sif and a.rnk = 1	
			LEFT JOIN 
				(select idenos_jmbg, 
						oib, 
						rank() over (partition by idenos_jmbg order by isnull(datdo, getdate()) desc) as rnk 
				from stage.zoroh.oibreg
				where oibreg.idenos_jmbg is not null) b on b.idenos_jmbg = pospar.idenos_jmbg  and b.rnk = 1		
			LEFT JOIN (
				select MunicipalityPlaceID, 
						PostalCodeID, 
						Migrationid 
				from dbo.MunicipalityPlacePostalCodes) adresa on pospar.naselje_id = adresa.Migrationid
			LEFT JOIN country on pospar.drzava_ik3= country.IsoCode3	
			left join stage.zoroh.oibpra on a.oib = oibpra.oib 
			left join stage.zoroh.djelnkd on oibpra.nkdsif = djelnkd.sifra and djelnkd.datdo is null
			left join dbo.CompanyActivities ca on djelnkd.id = ca.MigrationID
		WHERE pospar.sif IS NOT NULL


-- update stage tabele iz temp_companies_stage tabele
		UPDATE stage.stg.stg_Companies
		SET 
			pospar_sif = tcs.pospar_sif,
			pospar_kratki_naziv = tcs.pospar_kratki_naziv, 
			pospar_dugi_naziv = tcs.pospar_dugi_naziv, 
			pospar_dat_poc = tcs.pospar_dat_poc, 
			pospar_dat_kraj = tcs.pospar_dat_kraj,
			pospar_ulica = tcs.pospar_ulica, 
			pospar_kucBr = tcs.pospar_kucBr, 
			pospar_kucbr_num = tcs.pospar_kucbr_num,
			pospar_kucbr_com = tcs.pospar_kucbr_com, 
			pospar_naselje_id = tcs.pospar_naselje_id, 
			pospar_drzava = tcs.pospar_drzava,
			pospar_ino_naselje = tcs.pospar_ino_naselje,
			pospar_ino_ulica = tcs.pospar_ino_ulica, 
			pospar_matbr = tcs.pospar_matbr,
			pospar_obrt = tcs.pospar_obrt, 
			pospar_oib = tcs.pospar_oib,
			OIBrank = tcs.OIBrank, 
			oibDatOd = tcs.oibDatOd, 
			oibDatDo = tcs.oibDatDo,
			nkdsif = tcs.nkdsif, 
			nkdid = tcs.nkdid, 
			pospar_tel = tcs.pospar_tel,
			pospar_email = tcs.pospar_email,
			MunicipalityPlaceID = tcs.MunicipalityPlaceID,
			PostalCodeID = tcs.PostalCodeID,
			CountryID = tcs.CountryID,
			CompanyActivityID = tcs.CompanyActivityID,
			matbrRank = tcs.matbrRank,
			rnkTEST = tcs.rnkTEST,
			drnk = tcs.drnk,
			CompanyTypesId = tcs.CompanyTypesId, 
			sif_sljednik = tcs.sif_sljednik,
			idenos_jmbg = tcs.idenos_jmbg
		FROM stage.stg.stg_Companies compt
			INNER JOIN temp_companies_stage tcs ON tcs.pospar_sif = compt.pospar_sif


		-- dodaj sljednika za zapise koji su povijesni radi visetrukog upisa matbr
		update c1
		set sif_sljednik = c2.pospar_sif
		from stage.stg.stg_Companies c1
			join stage.stg.stg_Companies c2 on c1.drnk = c2.drnk 
		where (c1.matbrRank > 1 and  c1.pospar_matbr is not null and c1.pospar_matbr<> '') and c2.matbrRank = 1

		update c1
		set sif_sljednik = c1.pospar_sif
		from stage.stg.stg_Companies c1
		where c1.sif_sljednik is null

		-- drop pomocnih tabela
		DROP TABLE companies_update;
		DROP TABLE temp_companies;
		DROP TABLE temp_companies_stage;


	END -- kraj dela za update


	BEGIN /* Region Delete */

--=========================
-- DELETE za dbo.Companies 
--=========================

		-- kreiram temp tabelu gde ce biti samo 'sif' iz tabele elog_pospar koje treba da se obrisu (al_a = 'D')
		IF object_id('companies_delete','U') IS NOT NULL
			DROP TABLE companies_delete;

		SELECT 
			DISTINCT(sif) AS pospar_sif,
			[vrijeme_ehzzo] AS valid_until
		INTO companies_delete
		FROM stage.zoroh.elog_pospar
		WHERE al_a = 'D' AND sif is not null


		-- ne radimo delete vec radimo update polja ValidUntil
		UPDATE dbo.Companies 
		SET ValidUntil = cd.valid_until
		FROM dbo.Companies d
			INNER JOIN companies_delete cd ON d.Code = cd.pospar_sif

		-- drop pomocne tabele
		DROP TABLE companies_delete;

	END -- kraj dela za delete

GO


/*
============================================
PROCEDURA [dbo].[PersonsSync]
============================================
*/

CREATE OR ALTER PROCEDURE [dbo].[PersonsSync]
AS
	/* *************** 1. KREIRAJ TEMPICU ZA INSERT NOVI ZAPISA U PERSONS IZ IDENOSA KOJI VEĆ NISU U PERSONS ****************** */

	IF OBJECT_ID('tempdb..#insert_persons') IS NOT NULL
		DROP TABLE #insert_persons

	;with preb_bor as (
		SELECT
		  MunicipalityPlacePostalCodeID,
		  MunicipalityPlaces.MunicipalityPlaceID,
		  PostalCodeID,
		  MunicipalityPlacePostalCodes.migrationId,
		  MunicipalityPlaces.RegionalUnitID
		FROM dbo.MunicipalityPlacePostalCodes
		JOIN dbo.MunicipalityPlaces ON MunicipalityPlacePostalCodes.MunicipalityPlaceID = MunicipalityPlaces.MunicipalityPlaceID
		)
		SELECT distinct 
			idenos.jmbg as UniqueIdentificationNumber, 
			idenos.zdrmb as UniqueHealthInsuranceNumber, 
			gen.GenderID AS GenderID,
			TRIM(idenos.ime) as FirstName, 
			TRIM(idenos.prezime) as LastName, 
			idenos.datrod as BirthDate, 
			idenos.imerod as ParentName, 
			idenos.datsmrt as DeathDate, 

			COALESCE(preb.RegionalUnitID, bor.RegionalUnitID) AS RegionalUnitID,

			preb.MunicipalityPlaceID as HomeAddressPlaceID,
			preb.PostalCodeID as HomeAddressPlacePostalCodeID,

			bor.MunicipalityPlaceID as CurrentAddressPlaceID, 
			bor.PostalCodeID as CurrentAddressPlacePostalCodeID,

			TRIM(adresaP.ulica_naziv) as HomeAddressStreetName, 

			case when PATINDEX('%[^0-9]%', adresaP.kucbr) > 0 and PATINDEX('%[0-9]%', left(adresaP.kucbr, PATINDEX('%[^0-9]%', adresaP.kucbr) -1) ) > 0  
					then left(adresaP.kucbr, PATINDEX('%[^0-9]%', adresaP.kucbr) -1) 
				when PATINDEX('%[^0-9]%', adresaP.kucbr) > 0 and PATINDEX('%[0-9]%', left(adresaP.kucbr, PATINDEX('%[^0-9]%', adresaP.kucbr) -1) ) = 0
					then null
				when adresaP.kucbr = ''
					then null
				else adresaP.kucbr end as HomeAddressStreetNumber,

			case when PATINDEX('%[^0-9]%', trim(adresaP.kucbr)) > 0 and PATINDEX('[^A-Za-z0-9, ]%', substring(adresaP.kucbr, PATINDEX('%[^0-9]%', adresaP.kucbr),len (adresaP.kucbr) - PATINDEX('%[^0-9]%', adresaP.kucbr)+1 )) =1
					then trim(substring(adresaP.kucbr, PATINDEX('%[^0-9]%', adresaP.kucbr)+1,len (adresaP.kucbr) - PATINDEX('%[^0-9]%', adresaP.kucbr) +1))
				when PATINDEX('%[^0-9]%', trim(adresaP.kucbr)) > 0 
					then trim(substring(adresaP.kucbr, PATINDEX('%[^0-9]%', adresaP.kucbr),len (adresaP.kucbr) - PATINDEX('%[^0-9]%', adresaP.kucbr)+1 ))	
				when adresaP.kucbr = ''
					then null
				else null end as HomeAddressComplements,

			TRIM(adresaB.ulica_naziv) as CurrentAddressStreetName, 

			case when PATINDEX('%[^0-9]%', adresaB.kucbr) > 0 and PATINDEX('%[0-9]%', left(adresaB.kucbr, PATINDEX('%[^0-9]%', adresaB.kucbr) -1)) > 0 
					then left(adresaB.kucbr, PATINDEX('%[^0-9]%', adresaB.kucbr) -1) 
				when PATINDEX('%[^0-9]%', adresaB.kucbr) > 0 and PATINDEX('%[0-9]%', left(adresaB.kucbr, PATINDEX('%[^0-9]%', adresaB.kucbr) -1)) = 0
					then null
				when adresaB.kucbr = ''
					then null
				else adresaB.kucbr end as CurrentAddressStreetNumber,

			case when PATINDEX('%[^0-9]%', trim(adresaB.kucbr)) > 0 and PATINDEX('[^A-Za-z0-9, ]%', substring(adresaB.kucbr, PATINDEX('%[^0-9]%', adresaB.kucbr),len (adresaB.kucbr) - PATINDEX('%[^0-9]%', adresaB.kucbr)+1 )) =1
					then trim(substring(adresaB.kucbr, PATINDEX('%[^0-9]%', adresaB.kucbr)+1,len (adresaB.kucbr) - PATINDEX('%[^0-9]%', adresaB.kucbr) +1))
				when PATINDEX('%[^0-9]%', trim(adresaB.kucbr)) > 0 
					then trim(substring(adresaB.kucbr, PATINDEX('%[^0-9]%', adresaB.kucbr),len (adresaB.kucbr) - PATINDEX('%[^0-9]%', adresaB.kucbr)+1 ))	
				when adresaB.kucbr = ''
					then null
				else null end as CurrentAddressComplements,

			a.oib as PersonalIdentificationNumber,

			(select top 1 mjrod from stage.zoroh.oibfiz oibfiz where oibfiz.oib = a.oib) as BirthPlaceName,

			(select top 1 Countries.CountryID from dbo.Countries 
				join stage.zoroh.oibfiz oibfiz on Countries.code = sifdrzrod
				where oibfiz.jmbg = idenos.jmbg
				order by CountryID desc) as BirthCountryID,

			case when (select distinct top 1 drzavljan_id from stage.zoroh.oibfiz oibfiz where oibfiz.oib = a.oib )= 1 then (select CountryId from dbo.Countries where Code= '191') end as CitizenshipCountryID

			,GETDATE() AS CreatedOn
			,'MIGRACIJA' AS CreatedBy
			,GETDATE() AS ModifiedOn
			,'MIGRACIJA' AS ModifiedBy

			,idenos.jmbg as MigrationID
		INTO #insert_persons
		FROM stage.zoroh.idenos idenos
		JOIN stage.zoroh.elog_idenos ei ON idenos.jmbg = ei.jmbg_n AND ei.al_a = 'I'
		LEFT JOIN dbo.Persons P ON idenos.jmbg = P.UniqueIdentificationNumber
		left join stage.zoroh.adresa adresaP on idenos.jmbg = adresaP.idenos_jmbg and adresaP.vrsta = 'P'
		left join stage.zoroh.adresa adresaB on idenos.jmbg = adresaB.idenos_jmbg and adresaB.vrsta = 'B'	
		left join
		(select idenos_jmbg, oib, datod, datdo, rank() over (partition by idenos_jmbg order by isnull(datdo, '2200-01-01') desc) as rnk from stage.zoroh.oibreg
		where oibreg.idenos_jmbg is not null) a 
			on idenos.jmbg = a.idenos_jmbg
		left join preb_bor preb on adresaP.naselje_id = preb.MigrationId
		left join preb_bor bor on adresaB.naselje_id = bor.MigrationId
		left join dbo.Genders gen on gen.Code = (CASE WHEN idenos.spol IN ('M') THEN 'M' WHEN idenos.spol IN ('Z','Ž','F') THEN 'F' ELSE 'N' END)
		WHERE P.UniqueIdentificationNumber IS NULL AND ei.al_a = 'I'


		/* *************** 2. UBACI NOVE ZAPISE U PERSONS ****************** */

		DECLARE 
			@UniqueIdentificationNumber NVARCHAR(MAX),
			@UniqueHealthInsuranceNumber NVARCHAR(MAX),
			@GenderID INT,
			@FirstName NVARCHAR(MAX),
			@LastName NVARCHAR(MAX),
			@BirthDate DATE,
			@ParentName NVARCHAR(MAX),
			@DeathDate DATE,
			@RegionalUnitID INT,
			@HomeAddressPlaceID INT,
			@HomeAddressPostalCodeID INT,
			@CurrentAddressPlaceID INT,
			@CurrentAddressPostalCodeID INT,
			@HomeAddressStreetName NVARCHAR(MAX),
			@HomeAddressStreetNumber NVARCHAR(MAX),
			@HomeAddressComplements NVARCHAR(MAX),
			@CurrentAddressStreetName NVARCHAR(MAX),
			@CurrentAddressStreetNumber NVARCHAR(MAX),
			@CurrentAddressComplements NVARCHAR(MAX),
			@PersonalIdentificationNumber NVARCHAR(MAX),
			@BirthPlaceName NVARCHAR(MAX),
			@BirthCountryID INT,
			@CitizenshipCountryID INT,
			@MigrationID NVARCHAR(MAX)

		DECLARE ErrorLogCursor CURSOR FAST_FORWARD 
		FOR 
		SELECT
				UniqueIdentificationNumber,
				UniqueHealthInsuranceNumber,
				GenderID,
				FirstName,
				LastName,
				BirthDate,
				ParentName,
				DeathDate,
				RegionalUnitID,
				HomeAddressPlaceID,
				HomeAddressPlacePostalCodeID,
				CurrentAddressPlaceID,
				CurrentAddressPlacePostalCodeID,
				HomeAddressStreetName,
				HomeAddressStreetNumber,
				HomeAddressComplements,
				CurrentAddressStreetName,
				CurrentAddressStreetNumber,
				CurrentAddressComplements,
				CASE 
					WHEN PersonalIdentificationNumber IN (SELECT PersonalIdentificationNumber FROM dbo.Persons) THEN NULL
					ELSE PersonalIdentificationNumber
				END AS PersonalIdentificationNumber,
				BirthPlaceName,
				BirthCountryID,
				CitizenshipCountryID,
				MigrationID
			FROM #insert_persons;

		OPEN ErrorLogCursor;
		FETCH NEXT FROM ErrorLogCursor INTO 
			@UniqueIdentificationNumber,
			@UniqueHealthInsuranceNumber,
			@GenderID,
			@FirstName,
			@LastName,
			@BirthDate,
			@ParentName,
			@DeathDate,
			@RegionalUnitID,
			@HomeAddressPlaceID,
			@HomeAddressPostalCodeID,
			@CurrentAddressPlaceID,
			@CurrentAddressPostalCodeID,
			@HomeAddressStreetName,
			@HomeAddressStreetNumber,
			@HomeAddressComplements,
			@CurrentAddressStreetName,
			@CurrentAddressStreetNumber,
			@CurrentAddressComplements,
			@PersonalIdentificationNumber,
			@BirthPlaceName,
			@BirthCountryID,
			@CitizenshipCountryID,
			@MigrationID


	WHILE @@FETCH_STATUS = 0
		BEGIN
			BEGIN TRY
			INSERT INTO dbo.Persons(
				UniqueIdentificationNumber,
				UniqueHealthInsuranceNumber,
				GenderID,
				FirstName,
				LastName,
				BirthDate,
				ParentName,
				DeathDate,
				RegionalUnitID,
				HomeAddressPlaceID,
				HomeAddressPostalCodeID,
				CurrentAddressPlaceID,
				CurrentAddressPostalCodeID,
				HomeAddressStreetName,
				HomeAddressStreetNumber,
				HomeAddressComplements,
				CurrentAddressStreetName,
				CurrentAddressStreetNumber,
				CurrentAddressComplements,
				PersonalIdentificationNumber,
				BirthPlaceName,
				BirthCountryID,
				CitizenshipCountryID,
				CreatedOn,
				CreatedBy,
				ModifiedOn,
				ModifiedBy,
				MigrationID
			)
			VALUES(
				@UniqueIdentificationNumber, @UniqueHealthInsuranceNumber, 	@GenderID, @FirstName, @LastName, @BirthDate, @ParentName, @DeathDate, @RegionalUnitID, @HomeAddressPlaceID,
				@HomeAddressPostalCodeID, @CurrentAddressPlaceID, @CurrentAddressPostalCodeID, @HomeAddressStreetName, @HomeAddressStreetNumber, @HomeAddressComplements,
				@CurrentAddressStreetName, @CurrentAddressStreetNumber, @CurrentAddressComplements, @PersonalIdentificationNumber, 	@BirthPlaceName, @BirthCountryID,
				@CitizenshipCountryID, 	GETDATE(), 	'MIGRACIJA', GETDATE(),	'MIGRACIJA', @MigrationID
			)
			FETCH NEXT FROM ErrorLogCursor INTO @UniqueIdentificationNumber, @UniqueHealthInsuranceNumber, 	@GenderID, @FirstName, @LastName, @BirthDate, @ParentName, @DeathDate, @RegionalUnitID, @HomeAddressPlaceID,
				@HomeAddressPostalCodeID, @CurrentAddressPlaceID, @CurrentAddressPostalCodeID, @HomeAddressStreetName, @HomeAddressStreetNumber, @HomeAddressComplements,
				@CurrentAddressStreetName, @CurrentAddressStreetNumber, @CurrentAddressComplements, @PersonalIdentificationNumber, 	@BirthPlaceName, @BirthCountryID,
				@CitizenshipCountryID, @MigrationID
			END TRY
			BEGIN CATCH
			-- Insert the row with error into the error_log table
				INSERT INTO errorTbls.Persons_error_sync
				(
					UniqueIdentificationNumber,
					UniqueHealthInsuranceNumber,
					GenderID,
					FirstName,
					LastName,
					BirthDate,
					ParentName,
					DeathDate,
					RegionalUnitID,
					HomeAddressPlaceID,
					HomeAddressPostalCodeID,
					CurrentAddressPlaceID,
					CurrentAddressPostalCodeID,
					HomeAddressStreetName,
					HomeAddressStreetNumber,
					HomeAddressComplements,
					CurrentAddressStreetName,
					CurrentAddressStreetNumber,
					CurrentAddressComplements,
					PersonalIdentificationNumber,
					BirthPlaceName,
					BirthCountryID,
					CitizenshipCountryID,
					CreatedOn,
					CreatedBy,
					ModifiedOn,
					ModifiedBy,
					MigrationID,
					ErrorMessage
				)
				VALUES
				(
				@UniqueIdentificationNumber, @UniqueHealthInsuranceNumber, 	@GenderID, @FirstName, @LastName, @BirthDate, @ParentName, @DeathDate, @RegionalUnitID, @HomeAddressPlaceID,
				@HomeAddressPostalCodeID, @CurrentAddressPlaceID, @CurrentAddressPostalCodeID, @HomeAddressStreetName, @HomeAddressStreetNumber, @HomeAddressComplements,
				@CurrentAddressStreetName, @CurrentAddressStreetNumber, @CurrentAddressComplements, @PersonalIdentificationNumber, 	@BirthPlaceName, @BirthCountryID,
				@CitizenshipCountryID, 	GETDATE(), 	'MIGRACIJA', GETDATE(),	'MIGRACIJA', @MigrationID, 	ERROR_MESSAGE() 
				)


				FETCH NEXT FROM ErrorLogCursor INTO @UniqueIdentificationNumber, @UniqueHealthInsuranceNumber, 	@GenderID, @FirstName, @LastName, @BirthDate, @ParentName, @DeathDate, @RegionalUnitID, @HomeAddressPlaceID,
				@HomeAddressPostalCodeID, @CurrentAddressPlaceID, @CurrentAddressPostalCodeID, @HomeAddressStreetName, @HomeAddressStreetNumber, @HomeAddressComplements,
				@CurrentAddressStreetName, @CurrentAddressStreetNumber, @CurrentAddressComplements, @PersonalIdentificationNumber, 	@BirthPlaceName, @BirthCountryID,
				@CitizenshipCountryID, @MigrationID;

			END CATCH
		END;

		CLOSE ErrorLogCursor;
		DEALLOCATE ErrorLogCursor;

		DROP TABLE #insert_persons
		PRINT N'New Persons Inserted'


		/* ********** UPDATE IZ IDENOSA ********* */

;with zadnja_radnja as ( --- pokupi mi zadnji update za osobu 
			select jmbg_o, jmbg_n, max(vrijeme_ehzzo) as max_vrijeme
			from stage.zoroh.elog_idenos
			where  al_a = 'U'
			group by jmbg_o, jmbg_n
		),
		update_cte as (
			select distinct
			i.*, 
			ei.jmbg_n,
			ei.jmbg_o,
			ei.al_a, 
			ei.vrijeme_ehzzo
			from stage.zoroh.elog_idenos ei
			join zadnja_radnja tr on ei.jmbg_o = tr.jmbg_o and ei.vrijeme_ehzzo = tr.max_vrijeme
			join stage.zoroh.idenos i on i.jmbg = ei.jmbg_n or i.jmbg = ei.jmbg_o
		)
		UPDATE tp 
		SET 
			tp.UniqueIdentificationNumber= cte.jmbg_n,
			tp.UniqueHealthInsuranceNumber = cte.zdrmb,
			tp.GenderID = gen.GenderID,
			tp.BirthDate = cte.datrod,
			tp.ParentName = cte.imerod,
			tp.DeathDate = cte.datsmrt,
			tp.ModifiedOn = GETDATE()
		FROM dbo.Persons tp
		JOIN update_cte cte ON cte.jmbg = tp.UniqueIdentificationNumber
		LEFT JOIN dbo.Genders gen on gen.Code = (CASE WHEN cte.spol IN ('M') THEN 'M' WHEN cte.spol IN ('Z','Ž','F') THEN 'F' ELSE 'N' END)

		PRINT N'Idenos Part Updated'


		/* ********** UPDATE IZ PREBIVALIŠTA IZ ADRESA ********* */
		;with preb_bor as (
			select MunicipalityPlacePostalCodeID,MunicipalityPlaces.MunicipalityPlaceID,
			PostalCodeID, MunicipalityPlacePostalCodes.migrationId ,MunicipalityPlaces.RegionalUnitID
			from dbo.MunicipalityPlacePostalCodes
			join dbo.MunicipalityPlaces 
			on MunicipalityPlacePostalCodes.MunicipalityPlaceID = MunicipalityPlaces.MunicipalityPlaceID
		),
		updejt as (
		---PREBIVALIŠTE
		SELECT DISTINCT
		 idenos.jmbg,

		 preb.MunicipalityPlaceID as HomeAddressPlaceID,
		 preb.PostalCodeID as HomeAddressPlacePostalCodeID,

		 adresaP.ulica_naziv as HomeAddressStreetName, 

		 case when PATINDEX('%[^0-9]%', adresaP.kucbr) > 0 and PATINDEX('%[0-9]%', left(adresaP.kucbr, PATINDEX('%[^0-9]%', adresaP.kucbr) -1) ) > 0  
		   then left(adresaP.kucbr, PATINDEX('%[^0-9]%', adresaP.kucbr) -1) 
		  when PATINDEX('%[^0-9]%', adresaP.kucbr) > 0 and PATINDEX('%[0-9]%', left(adresaP.kucbr, PATINDEX('%[^0-9]%', adresaP.kucbr) -1) ) = 0
		   then null
		  when adresaP.kucbr = ''
		   then null
		  else adresaP.kucbr end as HomeAddressStreetNumber,

		 case when PATINDEX('%[^0-9]%', trim(adresaP.kucbr)) > 0 and PATINDEX('[^A-Za-z0-9, ]%', substring(adresaP.kucbr, PATINDEX('%[^0-9]%', adresaP.kucbr),len (adresaP.kucbr) - PATINDEX('%[^0-9]%', adresaP.kucbr)+1 )) =1
		   then trim(substring(adresaP.kucbr, PATINDEX('%[^0-9]%', adresaP.kucbr)+1,len (adresaP.kucbr) - PATINDEX('%[^0-9]%', adresaP.kucbr) +1))
		  when PATINDEX('%[^0-9]%', trim(adresaP.kucbr)) > 0 
		   then trim(substring(adresaP.kucbr, PATINDEX('%[^0-9]%', adresaP.kucbr),len (adresaP.kucbr) - PATINDEX('%[^0-9]%', adresaP.kucbr)+1 )) 
		  when adresaP.kucbr = ''
		   then null
		  else null end as HomeAddressComplements

		FROM stage.zoroh.idenos
		JOIN stage.zoroh.adresa adresaP ON adresaP.idenos_jmbg = idenos.jmbg and adresaP.vrsta = 'P'
		JOIN stage.zoroh.elog_adresa ea ON ea.id_n = adresaP.id
		LEFT JOIN preb_bor preb on adresaP.naselje_id = preb.MigrationId
		)
		UPDATE t
		SET 
		 t.HomeAddressPlaceID = u.HomeAddressPlaceID,
		 t.HomeAddressPostalCodeID = u.HomeAddressPlacePostalCodeID,
		 t.HomeAddressStreetName = u.HomeAddressStreetName,
		 t.HomeAddressStreetNumber = u.HomeAddressStreetNumber,
		 t.HomeAddressComplements = u.HomeAddressComplements,
		t.ModifiedOn = GETDATE()
		FROM dbo.Persons t
		JOIN updejt u ON t.UniqueIdentificationNumber = u.jmbg

		PRINT N'Update Prebivališta'

		/* ********** UPDATE IZ BORAVIŠTA IZ ADRESA ********* */


		;with preb_bor as (
			select MunicipalityPlacePostalCodeID,MunicipalityPlaces.MunicipalityPlaceID,
			PostalCodeID, MunicipalityPlacePostalCodes.migrationId ,MunicipalityPlaces.RegionalUnitID
			from dbo.MunicipalityPlacePostalCodes
			join dbo.MunicipalityPlaces 
			on MunicipalityPlacePostalCodes.MunicipalityPlaceID = MunicipalityPlaces.MunicipalityPlaceID
		),
		updejt as (
		--- BORAVIŠE
		SELECT DISTINCT
		 idenos.jmbg,

		 bor.MunicipalityPlaceID as CurrentAddressPlaceID, 
		 bor.PostalCodeID as CurrentAddressPlacePostalCodeID,

		 adresaB.ulica_naziv as CurrentAddressStreetName, 

		 case when PATINDEX('%[^0-9]%', adresaB.kucbr) > 0 and PATINDEX('%[0-9]%', left(adresaB.kucbr, PATINDEX('%[^0-9]%', adresaB.kucbr) -1)) > 0 
		   then left(adresaB.kucbr, PATINDEX('%[^0-9]%', adresaB.kucbr) -1) 
		  when PATINDEX('%[^0-9]%', adresaB.kucbr) > 0 and PATINDEX('%[0-9]%', left(adresaB.kucbr, PATINDEX('%[^0-9]%', adresaB.kucbr) -1)) = 0
		   then null
		  when adresaB.kucbr = ''
		   then null
		  else adresaB.kucbr end as CurrentAddressStreetNumber,

		 case when PATINDEX('%[^0-9]%', trim(adresaB.kucbr)) > 0 and PATINDEX('[^A-Za-z0-9, ]%', substring(adresaB.kucbr, PATINDEX('%[^0-9]%', adresaB.kucbr),len (adresaB.kucbr) - PATINDEX('%[^0-9]%', adresaB.kucbr)+1 )) =1
		   then trim(substring(adresaB.kucbr, PATINDEX('%[^0-9]%', adresaB.kucbr)+1,len (adresaB.kucbr) - PATINDEX('%[^0-9]%', adresaB.kucbr) +1))
		  when PATINDEX('%[^0-9]%', trim(adresaB.kucbr)) > 0 
		   then trim(substring(adresaB.kucbr, PATINDEX('%[^0-9]%', adresaB.kucbr),len (adresaB.kucbr) - PATINDEX('%[^0-9]%', adresaB.kucbr)+1 )) 
		  when adresaB.kucbr = ''
		   then null
		  else null end as CurrentAddressComplements

		FROM stage.zoroh.idenos
		JOIN stage.zoroh.adresa adresaB ON adresaB.idenos_jmbg = idenos.jmbg and adresaB.vrsta = 'B'
		JOIN stage.zoroh.elog_adresa ea ON ea.id_n = adresaB.id
		LEFT JOIN preb_bor bor on adresaB.naselje_id = bor.MigrationId
		)
		UPDATE t
		SET 
		 t.CurrentAddressPlaceID = u.CurrentAddressPlaceID,
		 t.CurrentAddressPostalCodeID = u.CurrentAddressPlacePostalCodeID,
		 t.CurrentAddressStreetName = u.CurrentAddressStreetName,
		 t.CurrentAddressStreetNumber = u.CurrentAddressStreetNumber,
		 t.CurrentAddressComplements = u.CurrentAddressComplements,
		 t.ModifiedOn = GETDATE()
		FROM dbo.Persons t
		JOIN updejt u ON t.UniqueIdentificationNumber = u.jmbg

		PRINT N'Update Boravišta'

		/* ********** UPDATE IZ OIB IZ OIBREG ********* */


		update dbo.Persons -- SLUČAJ KADA SE NAPUNI ISTA OSOBA KOJA SE U IDUĆEM KORAKU ZATVARA
			SET PersonalIdentificationNumber = NULL
			FROM dbo.Persons 
			WHERE UniqueHealthInsuranceNumber IN (
				select 
				UniqueHealthInsuranceNumber
				from dbo.Persons
				group by UniqueHealthInsuranceNumber
				having count(1) > 1
		)

		;with cte_oib_U as 
		(
			select distinct
			idenos_jmbg, o.oib, eoi.oib_n, datod, datdo, rank() over (partition by idenos_jmbg order by isnull(datdo, '2200-01-01') desc) as rnk 
			from stage.zoroh.oibreg o
			join stage.zoroh.elog_oibreg eoi on o.oib = eoi.oib_o OR o.oib = eoi.oib_n
			where o.idenos_jmbg is not null 
		)
		UPDATE t
		SET
		 t.PersonalIdentificationNumber = cte.oib_n,
		 t.ModifiedOn = GETDATE()
		FROM dbo.Persons t 
		JOIN cte_oib_U cte on t.UniqueIdentificationNumber = cte.idenos_jmbg

		PRINT N'Update OIB'

		/* ********** DELETE ********* */

		UPDATE P
		SET P.ValidUntil = ei.vrijeme_ehzzo
		FROM dbo.Persons P
		JOIN stage.zoroh.elog_idenos ei ON ei.jmbg_o = P.UniqueIdentificationNumber
		WHERE ei.al_a = 'D'

		PRINT N'Update ValidUntil nevazecih osoba'


		/*  ***** KOJI DEGENERICI NISU NIGDJE? ***** */

		INSERT INTO errorTbls.Persons_error_sync
				(
					UniqueIdentificationNumber,
					UniqueHealthInsuranceNumber,
					GenderID,
					FirstName,
					LastName,
					BirthDate,
					ParentName,
					DeathDate,
					CreatedOn,
					CreatedBy,
					ModifiedOn,
					ModifiedBy,
					ErrorMessage
				)
		SELECT
			i.jmbg as UniqueIdentificationNumber, 
			i.zdrmb as UniqueHealthInsuranceNumber, 
			gen.GenderID AS GenderID,
			TRIM(i.ime) as FirstName, 
			TRIM(i.prezime) as LastName, 
			i.datrod as BirthDate, 
			i.imerod as ParentName, 
			i.datsmrt as DeathDate,
			GETDATE(), 	
			'MIGRACIJA', 
			GETDATE(),	
			'MIGRACIJA',
			'Ne nalaze se u eHZZO sustavu'
		FROM stage.zoroh.idenos i
		JOIN stage.zoroh.elog_idenos ei ON i.jmbg = ei.jmbg_o OR i.jmbg = ei.jmbg_n 
		LEFT JOIN dbo.Persons P ON P.UniqueHealthInsuranceNumber = i.zdrmb
		left join dbo.Genders gen on gen.Code = (CASE WHEN i.spol IN ('M') THEN 'M' WHEN i.spol IN ('Z','Ž','F') THEN 'F' ELSE 'N' END)
		WHERE P.PersonID IS NULL


GO



/*
===================================================
PROCEDURA [dbo].[HealtcareInstitutionSync]
===================================================
*/

CREATE OR ALTER PROCEDURE [dbo].[HealtcareInstitutionSync]
AS
	
	/* ******* 1. KREIRAJ POMOĆNU TABLICU KAO ZA COMPANIES ALI SAMO ZA POSPAR_SIF IZ DAVZU  ******* */
	IF OBJECT_ID('dbo.pom_companies_M', N'U') IS NOT NULL
		DROP TABLE dbo.pom_companies_M
	

	SELECT  * 
	INTO dbo.pom_companies_M
	FROM (
		SELECT DISTINCT
		  cast(pospar.sif as varchar(20)) AS pospar_sif,
		  cast(pospar.matbr as varchar(4000)) AS pospar_matbr,
		  NULL AS sif_sljednik,
		  pospar.idenos_jmbg AS idenos_jmbg,
		  CompanyActivities.CompanyActivityID,
		  djelnkd.id AS nkdid,
		  RANK() OVER (PARTITION BY pospar.matbr ORDER BY ISNULL(dkrajp, '2099-01-01') DESC,
					   sif DESC) AS matbrRank,
		  RANK() OVER (PARTITION BY pospar.matbr ORDER BY pospar.dkrajp DESC) AS rnkTEST,
		  DENSE_RANK() OVER (ORDER BY pospar.matbr) AS drnk
		FROM
		  stage.zoroh.pospar
		LEFT JOIN
		  (SELECT
			pospar_sif,
			oib,
			DATOD,
			datdo,
			RANK() OVER (PARTITION BY pospar_sif ORDER BY ISNULL(datdo, GETDATE()) DESC) AS rnk
		  FROM stage.zoroh.oibreg
		  WHERE oibreg.pospar_sif IS NOT NULL) a ON a.pospar_sif = pospar.sif
		  AND a.rnk = 1
		LEFT JOIN
		  (SELECT
			idenos_jmbg,
			oib,
			RANK() OVER (PARTITION BY idenos_jmbg ORDER BY ISNULL(datdo, GETDATE()) DESC) AS rnk
		  FROM stage.zoroh.oibreg
		  WHERE oibreg.idenos_jmbg IS NOT NULL) b ON b.idenos_jmbg = pospar.idenos_jmbg
		  AND b.rnk = 1
		LEFT JOIN stage.zoroh.oibpra ON a.oib = oibpra.oib
		LEFT JOIN stage.zoroh.djelnkd ON oibpra.nkdsif = djelnkd.sifra AND djelnkd.datdo IS NULL
		LEFT JOIN (
		  SELECT
			MunicipalityPlaceID,
			PostalCodeID,
			Migrationid
		  FROM dbo.MunicipalityPlacePostalCodes
		) adresa ON pospar.naselje_id = adresa.Migrationid
		LEFT JOIN dbo.Countries ON pospar.drzava_ik3 = countries.IsoCode3
		LEFT JOIN dbo.CompanyActivities ON djelnkd.id = CompanyActivities.MigrationID
		WHERE pospar.sif IN (SELECT pospar_sif FROM stage.zoroh.davzu)
	) ttt

	PRINT 'dbo.pom_companies_M created';

	

	alter table dbo.pom_companies_M
	alter column sif_sljednik NVARCHAR(MAX)
	


	update c1
	set sif_sljednik = c2.pospar_sif
	from
	dbo.pom_companies_M c1
	join dbo.pom_companies_M c2 on 
	c1.drnk = c2.drnk 
	where 
	(c1.matbrRank >1 and  c1.pospar_matbr is not null and c1.pospar_matbr<> '') and c2.matbrRank = 1
	

	update c1
	set 
	sif_sljednik = c1.pospar_sif
	from
	dbo.pom_companies_M c1
	where c1.sif_sljednik is null
	

	/* ******* 2. KREIRAJ SYNC TABLICU STRUKTURE KAO ZA MIGRACIJU  ******* */

	IF OBJECT_ID('dbo.Healthcare_sync', N'U') IS NOT  NULL
		DROP TABLE dbo.Healthcare_sync
	

	select * , RANK() over (partition by CompanyMigrationId order by  ISNULL(EndActivityDate,'2099-01-01') desc, ISNULL(StartActivityDate,'2099-01-01') desc, ISNULL(vezaDatumDo,'2099-01-01') desc) as rnk
	into dbo.Healthcare_sync
	from (
	select distinct
	dz.pospar_sif as CompanySifOrig,
	c.sif_sljednik as CompanyMigrationId,
	comp.CompanyID,
	comp.CompanyStatusID,
	comp.CompanyActivityID,
	comp.AddressPlaceID,
	comp.AddressPostalCodeID,
	comp.AddressQuarterID,
	comp.CountryID,
	dz.tvrtka as Name,
	dz.naziv as LongName,
	dz.ulica_naziv as AddressStreetName,---comp.AddressStreetName,
	null as AddressStreetCode,--comp.AddressStreetCode,
	case when PATINDEX('%[^0-9]%', dz.kucbr) > 0 and PATINDEX('%[0-9]%', left(dz.kucbr, PATINDEX('%[^0-9]%', dz.kucbr) -1) ) > 0  
		then left(dz.kucbr, PATINDEX('%[^0-9]%', dz.kucbr) -1) 
		when PATINDEX('%[^0-9]%', dz.kucbr) > 0 and PATINDEX('%[0-9]%', left(dz.kucbr, PATINDEX('%[^0-9]%', dz.kucbr) -1) ) = 0  
		then null
		when dz.kucbr = '' then null
		else dz.kucbr end as AddressStreetNumber,
	null as AddressStreetNumberCode,
	case when PATINDEX('%[^0-9]%', dz.kucbr) > 0 
		then substring(dz.kucbr, PATINDEX('%[^0-9]%', dz.kucbr),len (dz.kucbr) - PATINDEX('%[^0-9]%', dz.kucbr)+1 ) 
		else null end as AddressComplements,
	comp.ForeignPlace,
	comp.ForeignAddress,
	comp.FoundedOn,
	comp.TerminatedOn,
	dz.tipdzu_id as HicTypeMigrationId,
	hit.HealthcareInstitutionTypeID,
	dz.katust_id as HicCategoryMigrationId,
	hic.HealthcareInstitutionCategoryID,
	dz.sif as HealthcareInstitutionCode,
	dz.tredbr as SortOrder,
	dz.dpocr as StartActivityDate,
	dz.dprer as EndActivityDate,
	dz1.sif AS parentHealthcareInstitutionCode,
	dz1.pospar_sif as parentCompanySifOrig,
	c1.sif_sljednik as parentCompanyMigrationId,
	dav.datOd as vezaDatumOd,
	dav.datDo as vezaDatumDo,
	Comp.PersonalIdentificationNumber as OIB--,

	from stage.dbo.tip_dzu_Mapping mp
	join stage.zoroh.davzu dz on mp.zoroh_tip_dzu_id = dz.tipdzu_id
	left join stage.zoroh.davzak dav on dz.sif = dav.davzu_sif and dav.vrodzu_id =2
	left join stage.zoroh.davzu dz1 on dav.davzu_sif_zak = dz1.sif
	left join dbo.pom_companies_M c on dz.pospar_sif = c.pospar_sif
	left join dbo.pom_companies_M c1 on dz1.pospar_sif = c1.pospar_sif
	left join MedicalWorker.HealthcareInstitutionTypes hit on  dz.tipdzu_id = hit.MigrationID
	left join MedicalWorker.HealthcareInstitutionCategories hic on dz.katust_id = hic.MigrationID
	left join dbo.Companies comp on c.sif_sljednik = comp.Code
	where mp.nadtip_dzu_id  = 1 

	union

	select distinct-- *
	davzu.pospar_sif as CompanySifOrig,
	davzu.pospar_sif  as CompanyMigrationId,
	comp.CompanyID,
	comp.CompanyStatusID,
	comp.CompanyActivityID,
	comp.AddressPlaceID,
	comp.AddressPostalCodeID,
	comp.AddressQuarterID,
	comp.CountryID,
	davzu.tvrtka as Name,
	davzu.naziv as LongName,
	davzu.ulica_naziv as AddressStreetName,---comp.AddressStreetName,
	null as AddressStreetCode,--comp.AddressStreetCode,
	case when PATINDEX('%[^0-9]%', davzu.kucbr) > 0 and PATINDEX('%[0-9]%', left(davzu.kucbr, PATINDEX('%[^0-9]%', davzu.kucbr) -1) ) > 0  
		then left(davzu.kucbr, PATINDEX('%[^0-9]%', davzu.kucbr) -1) 
		when PATINDEX('%[^0-9]%', davzu.kucbr) > 0 and PATINDEX('%[0-9]%', left(davzu.kucbr, PATINDEX('%[^0-9]%', davzu.kucbr) -1) ) = 0  
		then null
		when davzu.kucbr = '' then null
		else davzu.kucbr end as AddressStreetNumber,
	null as AddressStreetNumberCode,
	case when PATINDEX('%[^0-9]%', davzu.kucbr) > 0 
		then substring(davzu.kucbr, PATINDEX('%[^0-9]%', davzu.kucbr),len (davzu.kucbr) - PATINDEX('%[^0-9]%', davzu.kucbr)+1 ) 
		else null end as AddressComplements,
	comp.ForeignPlace,
	comp.ForeignAddress,
	comp.FoundedOn,
	comp.TerminatedOn,
	davzu.tipdzu_id as HicTypeMigrationId,
	hit.HealthcareInstitutionTypeID,
	davzu.katust_id as HicCategoryMigrationId,
	hic.HealthcareInstitutionCategoryID,
	davzu.sif as HealthcareInstitutionCode,
	davzu.tredbr as SortOrder,
	davzu.dpocr as StartActivityDate,
	davzu.dprer as EndActivityDate,
	null AS parentHealthcareInstitutionCode,
	null as parentCompanySifOrig,
	null as parentCompanyMigrationId,
	null as vezaDatumOd,
	null as vezaDatumDo,
	Comp.PersonalIdentificationNumber as OIB--,
	 from stage.zoroh.davzu davzu	
	left join stage.dbo.tip_dzu_Mapping mp on davzu.tipdzu_id = mp.zoroh_tip_dzu_id
	left join dbo.pom_companies_M c on davzu.pospar_sif = c.pospar_sif
	left join MedicalWorker.HealthcareInstitutionTypes hit on  davzu.tipdzu_id = hit.MigrationID
	left join MedicalWorker.HealthcareInstitutionCategories hic on davzu.katust_id = hic.MigrationID
	join dbo.Companies comp on c.sif_sljednik  = comp.Code
	where
	Not exists 
	(select * from stage.zoroh.davzak dzpom 
	join stage.zoroh.davzu dpom on dzpom.davzu_sif_zak= dpom.sif
	join stage.dbo.tip_dzu_mapping mppom on dpom.tipdzu_id = mppom.zoroh_tip_dzu_id
	where dzpom.davzu_sif = davzu.sif and (mppom.nadtip_dzu_id =1 or mppom.zoroh_tip_dzu_id = 29))
	/*and 
	not exists (select * from stage.zoroh.davzu davzu1	
	left join stage.dbo.tip_dzu_Mapping mp1 on davzu1.tipdzu_id = mp1.zoroh_tip_dzu_id 
	left join stage.zoroh.davzak dz on davzu1.sif = dz.davzu_sif
	where 
		davzu.sif <> davzu1.sif 
		and davzu.pospar_sif = davzu1.pospar_sif 
		and (mp1.nadtip_dzu_id =1 or mp1.zoroh_tip_dzu_id in (29))
		)*/
	 and
	 mp.nadtip_dzu_id in (2,3) --and mp.zoroh_tip_dzu_id = 4
	 ) a

	 /* ******* 3. UPIŠI NOVI ZAPIS U HEALTCAREINSTITUTIONS  ******* */

	 DECLARE @CompanyID INT, @HealthcareInstitutionTypeID INT, 
			@HealthcareInstitutionCategoryID INT, 
			@HealthcareInstitutionCode NVARCHAR(MAX), @SortOrder INT, @StartActivityDate DATETIME, @EndActivityDate DATETIME;


	DECLARE ErrorLogCursor CURSOR FAST_FORWARD
	FOR
		select distinct
		hs.CompanyID,
		hs.HealthcareInstitutionTypeID,
		hs.HealthcareInstitutionCategoryID,
		hs.HealthcareInstitutionCode,
		hs.SortOrder,
		hs.StartActivityDate,
		hs.EndActivityDate
		from dbo.Healthcare_sync hs
		join stage.zoroh.elog_davzu ed on ed.sif = hs.HealthcareInstitutionCode
		left join MedicalWorker.HealthcareInstitutionUnits hu on hu.UnitCode = hs.HealthcareInstitutionCode
		left join MedicalWorker.HealthcareInstitutions h on h.HealthcareInstitutionCode = hs.HealthcareInstitutionCode
		where /*ed.al_a = 'I' and*/ rnk = 1
			and hu.HealthcareInstitutionUnitID IS NULL
			AND h.HealthcareInstitutionID IS NULL;
		
	OPEN ErrorLogCursor;
	FETCH NEXT FROM ErrorLogCursor INTO @CompanyID, @HealthcareInstitutionTypeID, @HealthcareInstitutionCategoryID, @HealthcareInstitutionCode, @SortOrder, @StartActivityDate, @EndActivityDate;
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		BEGIN TRY
			insert into MedicalWorker.HealthcareInstitutions (
			HealthcareInstitutionID,
			HealthcareInstitutionTypeID,
			HealthcareInstitutionCategoryID,
			HealthcareInstitutionCode,
			SortOrder,
			StartActivityDate,
			EndActivityDate,
			CreatedOn,
			CreatedBy,
			ModifiedOn,
			ModifiedBy
			)
			VALUES (
			@CompanyID, @HealthcareInstitutionTypeID, @HealthcareInstitutionCategoryID, @HealthcareInstitutionCode, @SortOrder, @StartActivityDate, @EndActivityDate, GETDATE(),
			'MIGRACIJA',
			GETDATE(),
			'MIGRACIJA'
			)

			FETCH NEXT FROM ErrorLogCursor INTO @CompanyID, @HealthcareInstitutionTypeID, @HealthcareInstitutionCategoryID, @HealthcareInstitutionCode, @SortOrder, @StartActivityDate, @EndActivityDate;

		END TRY
	    BEGIN CATCH
        -- Insert the row with error into the error_log table
			INSERT INTO errorTbls.HealthcareInstitutions_error_sync
			(
				HealthcareInstitutionID,
				HealthcareInstitutionTypeID,
				HealthcareInstitutionCategoryID,
				HealthcareInstitutionCode,
				SortOrder,
				StartActivityDate,
				EndActivityDate,
				ErrorMessage
			)
			VALUES
			(
				@CompanyID, 
				@HealthcareInstitutionTypeID,
				@HealthcareInstitutionCategoryID, 
				@HealthcareInstitutionCode, 
				@SortOrder, 
				@StartActivityDate, 
				@EndActivityDate,
				ERROR_MESSAGE() 
			)

			PRINT ERROR_MESSAGE();

			FETCH NEXT FROM ErrorLogCursor INTO @CompanyID, @HealthcareInstitutionTypeID, @HealthcareInstitutionCategoryID, @HealthcareInstitutionCode, @SortOrder, @StartActivityDate, @EndActivityDate;
		END CATCH
	END;

	CLOSE ErrorLogCursor;
	DEALLOCATE ErrorLogCursor;

	/* ******* 4. UPDATE HEALTCAREINSTITUTIONS  ******* */

	UPDATE  hi
	SET 
		hi.HealthcareInstitutionTypeID = hit.HealthcareInstitutionTypeID,
		hi.HealthcareInstitutionCategoryID = hic.HealthcareInstitutionCategoryID,
		hi.SortOrder = d.tredbr,
		hi.StartActivityDate = d.dprer,
		hi.EndActivityDate = d.dprer, 
		hi.ModifiedBy = GETDATE() 
	FROM MedicalWorker.HealthcareInstitutions hi
	JOIN stage.zoroh.elog_davzu ed ON ed.sif = hi.HealthcareInstitutionCode
	JOIN stage.zoroh.davzu d ON d.sif = ed.sif 
	LEFT JOIN MedicalWorker.HealthcareInstitutionTypes hit ON d.tipdzu_id = hit.MigrationID
	LEFT JOIN MedicalWorker.HealthcareInstitutionCategories hic ON d.katust_id = hic.MigrationID
	WHERE ed.al_a = 'U'

	/* ****************************************************************************************************************** */
	/* ******* 5.1. INSERT HEALTCAREINSTITUTIONUNITS  ******* */
	BEGIN
		DECLARE 
		@CompanyID_HU int, @CompanyStatusID int, @CompanyActivityID int,  @HealthcareInstitutionTypeID_HU int,
		@AddressPlaceID int, @AddressPostalCodeID int, @AddressQuarterID int, @CountryID int, @HealthcareInstitutionUnitName nvarchar(max),
		@HealthcareInstitutionUnitLongName nvarchar(max), @AddressStreetName nvarchar(max), @AddressStreetCode nvarchar(max), @AddressComplements nvarchar(max),
		@ForeignPlace nvarchar(max), @ForeignAddress nvarchar(max), @UnitCode nvarchar(max), @StartActivityDate_HU date,
		@EndActivityDate_HU date, @HealthcareInstitutionUnitTypeID int;


		DECLARE ErrorLogCursor CURSOR FAST_FORWARD 
		FOR 
				select distinct
					stg.CompanyID,
					stg.CompanyStatusID,
					stg.CompanyActivityID,
					stg.HealthcareInstitutionTypeID,
					stg.AddressPlaceID,
					stg.AddressPostalCodeID,
					stg.AddressQuarterID,
					stg.CountryID,
					stg.Name,
					stg.LongName,
					stg.AddressStreetName,
					stg.AddressStreetCode,
					stg.AddressComplements,
					stg.ForeignPlace,
					stg.ForeignAddress,
					stg.HealthcareInstitutionCode,
					stg.StartActivityDate,
					stg.EndActivityDate,
					1 as HealthcareInstitutionUnitTypeID
				from dbo.Healthcare_sync stg
				join stage.zoroh.elog_davzu ed on stg.HealthcareInstitutionCode = ed.sif --and ed.al_a = 'I'
				left join MedicalWorker.HealthcareInstitutionUnits hiut on hiut.CompanyID = stg.CompanyID AND hiut.UnitCode = stg.HealthcareInstitutionCode
				where rnk = 1 and hiut.CompanyID IS NULL
				and stg.CompanyID not in (
					select pom.CompanyID
					from dbo.Healthcare_sync pom where rnk = 1 and companyId is Not null
					group by pom.CompanyID
					having COUNT(*)> 1
				)
				and hiut.HealthcareInstitutionUnitID is null
		
			OPEN ErrorLogCursor;
			FETCH NEXT FROM ErrorLogCursor INTO 
				@CompanyID_HU, @CompanyStatusID, @CompanyActivityID, @HealthcareInstitutionTypeID_HU, @AddressPlaceID, @AddressPostalCodeID, @AddressQuarterID,
				@CountryID, @HealthcareInstitutionUnitName, @HealthcareInstitutionUnitLongName, @AddressStreetName, @AddressStreetCode, @AddressComplements,
				@ForeignPlace, @ForeignAddress, @UnitCode, @StartActivityDate_HU, @EndActivityDate_HU, @HealthcareInstitutionUnitTypeID

			WHILE @@FETCH_STATUS = 0
				BEGIN
					BEGIN TRY
					insert into MedicalWorker.HealthcareInstitutionUnits(
						CompanyID,
						CompanyStatusID,
						CompanyActivityID,
						HealthcareInstitutionTypeID,
						AddressPlaceID,
						AddressPostalCodeID,
						AddressQuarterID,
						CountryID,
						HealthcareInstitutionUnitName,
						HealthcareInstitutionUnitLongName,
						AddressStreetName,
						AddressStreetCode,
						AddressComplements,
						ForeignPlace,
						ForeignAddress,
						UnitCode,
						StartActivityDate,
						EndActivityDate,
						HealthcareInstitutionUnitTypeID,
						CreatedOn,
						CreatedBy,
						ModifiedOn,
						ModifiedBy
					)
					VALUES(
						@CompanyID_HU, @CompanyStatusID, @CompanyActivityID, @HealthcareInstitutionTypeID_HU, @AddressPlaceID, @AddressPostalCodeID, @AddressQuarterID,
						@CountryID, @HealthcareInstitutionUnitName, @HealthcareInstitutionUnitLongName, @AddressStreetName, @AddressStreetCode, @AddressComplements,
						@ForeignPlace, @ForeignAddress, @UnitCode, @StartActivityDate_HU, @EndActivityDate_HU, @HealthcareInstitutionUnitTypeID, GETDATE(), 'MIGRACIJA', GETDATE(),	'MIGRACIJA' )
		
					FETCH NEXT FROM ErrorLogCursor INTO 
					@CompanyID_HU, @CompanyStatusID, @CompanyActivityID, @HealthcareInstitutionTypeID_HU, @AddressPlaceID, @AddressPostalCodeID, @AddressQuarterID,
					@CountryID, @HealthcareInstitutionUnitName, @HealthcareInstitutionUnitLongName, @AddressStreetName, @AddressStreetCode, @AddressComplements,
					@ForeignPlace, @ForeignAddress, @UnitCode, @StartActivityDate_HU, @EndActivityDate_HU, @HealthcareInstitutionUnitTypeID
					END TRY

					BEGIN CATCH
					-- Insert the row with error into the error_log table
						INSERT INTO errorTbls.HealthcareInstitutionUnits_error_sync
						(
							CompanyID,
							CompanyStatusID,
							CompanyActivityID,
							HealthcareInstitutionTypeID,
							AddressPlaceID,
							AddressPostalCodeID,
							AddressQuarterID,
							CountryID,
							HealthcareInstitutionUnitName,
							HealthcareInstitutionUnitLongName,
							AddressStreetName,
							AddressStreetCode,
							AddressComplements,
							ForeignPlace,
							ForeignAddress,
							UnitCode,
							StartActivityDate,
							EndActivityDate,
							HealthcareInstitutionUnitTypeID,
							CreatedOn,
							CreatedBy,
							ModifiedOn,
							ModifiedBy,
							ErrorMessage
						)
						VALUES
						(
						@CompanyID_HU, @CompanyStatusID, @CompanyActivityID, @HealthcareInstitutionTypeID_HU, @AddressPlaceID, @AddressPostalCodeID, @AddressQuarterID,
						@CountryID, @HealthcareInstitutionUnitName, @HealthcareInstitutionUnitLongName, @AddressStreetName, @AddressStreetCode, @AddressComplements,
						@ForeignPlace, @ForeignAddress, @UnitCode, @StartActivityDate_HU, @EndActivityDate_HU, @HealthcareInstitutionUnitTypeID, 	GETDATE(), 	'MIGRACIJA', GETDATE(),	'MIGRACIJA' ,ERROR_MESSAGE() 
						)


						FETCH NEXT FROM ErrorLogCursor INTO 
						@CompanyID_HU, @CompanyStatusID, @CompanyActivityID, @HealthcareInstitutionTypeID_HU, @AddressPlaceID, @AddressPostalCodeID, @AddressQuarterID,
						@CountryID, @HealthcareInstitutionUnitName, @HealthcareInstitutionUnitLongName, @AddressStreetName, @AddressStreetCode, @AddressComplements,
						@ForeignPlace, @ForeignAddress, @UnitCode, @StartActivityDate_HU, @EndActivityDate_HU, @HealthcareInstitutionUnitTypeID
			
					END CATCH
				END;

				CLOSE ErrorLogCursor;
				DEALLOCATE ErrorLogCursor;
	END

	/* ****************************************************************************************************************** */
	/* ******* 5.2 UPIŠI NOVI ZAPIS U HEALTCAREINSTITUTIONS  ******* */

	select 
	distinct
	CompanyID,
	CompanyStatusID,
	CompanyActivityID,
	HealthcareInstitutionTypeID,
	AddressPlaceId,
	AddressPostalCodeId,
	AddressQuarterId,
	CountryId,
	HealthcareInstitutionUnitName,
	HealthcareInstitutionUnitLongName,
	AddressStreetName,
	addressStreetCode,
	addressStreetNumber,
	AddressStreetNumberCode,
	AddressComplements,
	ForeignPlace,
	ForeignAddress,
	UnitCode,
	ActivityCode,
	FoundedOn,
	TerminatedOn,
	HealthcareInstitutionLocationId,
	StartActivityDate,
	EndActivityDate,
	TaxNumber,
	Email,
	HealthcareInstitutionUnitTypeId,
	PhoneNUmber, 
	VirtualUnitCode,
	CreatedOn,
	CreatedBy,
	ModifiedOn,
	ModifiedBy
	into #temp
	from 
	(select
	*,
	rank() over (PARTITION by b.UnitCode order by isnull(b.datdo,'2099-01-01') desc, isnull(b.EndActivityDate,'2099-01-01') desc, isnull(oib,'0000000') desc ) as rnk
	from 
	(
	select distinct
	hu.CompanyID as CompanyID,
	hu.CompanyStatusID as CompanyStatusID,
	hu.CompanyActivityID as CompanyActivityID,
	ht.HealthcareInstitutionTypeID,
	mppc.MunicipalityPlaceID as AddressPlaceId,
	mppc.PostalCodeID as AddressPostalCodeId,
	null as AddressQuarterId,
	hu.CountryID as CountryId,
	COALESCE (a.tvrtka, substring(A.naziv,0,250)) as HealthcareInstitutionUnitName,
	a.naziv as HealthcareInstitutionUnitLongName,
	a.ulica_naziv as AddressStreetName,
	a.ulicadgu_id as addressStreetCode,
	case when PATINDEX('%[^0-9]%', a.kucbr) > 0 and PATINDEX('%[0-9]%', left(a.kucbr, PATINDEX('%[^0-9]%', a.kucbr) -1) ) > 0  
		then left(a.kucbr, PATINDEX('%[^0-9]%', a.kucbr) -1) 
		when PATINDEX('%[^0-9]%', a.kucbr) > 0 and PATINDEX('%[0-9]%', left(a.kucbr, PATINDEX('%[^0-9]%', a.kucbr) -1) ) = 0  
		then null
		when a.kucbr = '' then null
		else a.kucbr end as addressStreetNumber,
	null as AddressStreetNumberCode,
	case when PATINDEX('%[^0-9]%', a.kucbr) > 0 
		then substring(a.kucbr, PATINDEX('%[^0-9]%', a.kucbr),len (a.kucbr) - PATINDEX('%[^0-9]%', a.kucbr)+1 ) 
		else null end as AddressComplements,
	null as ForeignPlace,
	null as ForeignAddress,
	a.sif as UnitCode,
	null as ActivityCode,
	a.datpoc as FoundedOn,
	a.datkr as TerminatedOn,
	null as HealthcareInstitutionLocationId,
	a.dpocr as StartActivityDate,
	a.dprer as EndActivityDate,
	null as TaxNumber,
	null as Email,
	2 as HealthcareInstitutionUnitTypeId,
	null as PhoneNUmber, 
	null as VirtualUnitCode,
	getdate() as CreatedOn,
	N'MIGRACIJA' as CreatedBy,
	getdate() as ModifiedOn,
	N'MIGRACIJA' as ModifiedBy--,
	,a.datod, a.datdo, stgH.oib
	from (
	select distinct dz.*,
	dz1.sif as parentsif, 
	dz1.pospar_sif as parentPospar_sif,

	dav1.*
	from stage.dbo.tip_dzu_Mapping mp
	join stage.zoroh.davzu dz on mp.zoroh_tip_dzu_id = dz.tipdzu_id
	join stage.zoroh.davzak dav1 on dz.sif = dav1.davzu_sif and dav1.vrodzu_id in (2,3) --and dav1.datdo is null -- dijete
	join stage.zoroh.davzu dz1 on dav1.davzu_sif_zak = dz1.sif
	join stage.dbo.tip_dzu_mapping mp1 on dz1.tipdzu_id = mp1.zoroh_tip_dzu_id and  (mp1.nadtip_dzu_id = 1 or mp1.zoroh_tip_dzu_id = 29)
	where mp.nadtip_dzu_id  = 3 
	and dav1.davzu_sif is not null
	and mp1.nadtip_dzu_id is not null

	  ) a
	left join dbo.Healthcare_sync stgH on a.parentPospar_sif = stgH.CompanySifOrig
	left join MedicalWorker.HealthcareInstitutions hi on stgH.CompanyID = hi.HealthcareInstitutionID --and hi.EndActivityDate is null
	left join MedicalWorker.HealthcareInstitutionUnits hu on stgH.CompanyID = hu.CompanyID-- and hu.TerminatedOn is null
	left join MedicalWorker.HealthcareInstitutionTypes ht on a.tipdzu_id = ht.MigrationID
	left join dbo.MunicipalityPlacePostalCodes mppc on a.naselje_id = mppc.MigrationID 
	where
	hu.CompanyID is not null
	and (stgH.rnk =1 or stgH.rnk is null) 


	union

	select distinct 
	l.HealthcareInstitutionID as CompanyID,
	c.CompanyStatusID  as CompanyStatusID,
	c.CompanyActivityID  as CompanyActivityID,
	ht.HealthcareInstitutionTypeID,
	mppc.MunicipalityPlaceID as AddressPlaceId,
	mppc.PostalCodeID as AddressPostalCodeId,
	null as AddressQuarterId,
	c.countryId as CountryId,
	a.tvrtka as HealthcareInstitutionUnitName,
	a.naziv as HealthcareInstitutionUnitLongName,
	a.ulica_naziv as AddressStreetName,
	a.ulicadgu_id as addressStreetCode,
	case when PATINDEX('%[^0-9]%', a.kucbr) > 0 and PATINDEX('%[0-9]%', left(a.kucbr, PATINDEX('%[^0-9]%', a.kucbr) -1) ) > 0  
		then left(a.kucbr, PATINDEX('%[^0-9]%', a.kucbr) -1) 
		when PATINDEX('%[^0-9]%', a.kucbr) > 0 and PATINDEX('%[0-9]%', left(a.kucbr, PATINDEX('%[^0-9]%', a.kucbr) -1) ) = 0  
		then null
		when a.kucbr = '' then null
		else a.kucbr end as addressStreetNumber,
	null as AddressStreetNumberCode,
	case when PATINDEX('%[^0-9]%', a.kucbr) > 0 
		then substring(a.kucbr, PATINDEX('%[^0-9]%', a.kucbr),len (a.kucbr) - PATINDEX('%[^0-9]%', a.kucbr)+1 ) 
		else null end as AddressComplements,
	null as ForeignPlace,
	null as ForeignAddress,
	a.sif as UnitCode,
	null as ActivityCode,
	a.datpoc as FoundedOn,
	a.datkr as TerminatedOn,
	l.LocationID as HealthcareInstitutionLocationId,
	a.dpocr as StartActivityDate,
	a.dprer as EndActivityDate,
	null as TaxNumber,
	null as Email,
	2 as HealthcareInstitutionUnitTypeId,
	null as PhoneNUmber, 
	null as VirtualUnitCode,
	getdate() as CreatedOn,
	N'MIGRACIJA' as CreatedBy,
	getdate() as ModifiedOn,
	N'MIGRACIJA' as ModifiedBy--,
	,a.datod, a.datdo, stgH.oib
	from (
	select distinct dz.*,
	dz1.sif as parentsif, 
	dz1.pospar_sif as parentPospar_sif,

	dav1.*
	from stage.dbo.tip_dzu_Mapping mp
	join stage.zoroh.davzu dz on mp.zoroh_tip_dzu_id = dz.tipdzu_id
	join stage.zoroh.davzak dav1 on dz.sif = dav1.davzu_sif and dav1.vrodzu_id in (2,3) --and dav1.datdo is null -- dijete
	join stage.zoroh.davzu dz1 on dav1.davzu_sif_zak = dz1.sif
	join stage.dbo.tip_dzu_mapping mp1 on dz1.tipdzu_id = mp1.zoroh_tip_dzu_id and mp1.nadtip_dzu_id =2
	where mp.nadtip_dzu_id  = 3 
	and Not exists (select * from stage.zoroh.davzak dav2  
	left join stage.zoroh.davzu dz2 on dav2.davzu_sif_zak = dz2.sif
	left join stage.dbo.tip_dzu_mapping mp2 on dz2.tipdzu_id = mp2.zoroh_tip_dzu_id where
	dz.sif= dav2.davzu_sif and dav2.vrodzu_id in (2,3)  and mp2.nadtip_dzu_id = 1)
	  ) a
	left join dbo.Healthcare_sync stgH on a.parentPospar_sif = stgH.CompanySifOrig
	left join MedicalWorker.HealthcareInstitutionTypes ht on a.tipdzu_id = ht.MigrationID
	left join dbo.MunicipalityPlacePostalCodes mppc on a.naselje_id = mppc.MigrationID 
	left join MedicalWorker.Locations l on a.parentsif = l.Code
	left join dbo.Companies c on l.HealthcareInstitutionID = c.CompanyID
	where
	 l.HealthcareInstitutionID is not null
	and (stgH.rnk =1 or stgH.rnk is null) 
	) b )c
	where c.rnk =1


	INSERT INTO MedicalWorker.HealthcareInstitutionUnits(
		CompanyID,
		CompanyStatusID,
		CompanyActivityID,
		HealthcareInstitutionTypeID,
		AddressPlaceId,
		AddressPostalCodeId,
		AddressQuarterId,
		CountryId,
		HealthcareInstitutionUnitName,
		HealthcareInstitutionUnitLongName,
		AddressStreetName,
		addressStreetCode,
		addressStreetNumber,
		AddressStreetNumberCode,
		AddressComplements,
		ForeignPlace,
		ForeignAddress,
		UnitCode,
		ActivityCode,
		FoundedOn,
		TerminatedOn,
		HealthcareInstitutionLocationId,
		StartActivityDate,
		EndActivityDate,
		TaxNumber,
		Email,
		HealthcareInstitutionUnitTypeId,
		PhoneNUmber, 
		VirtualUnitCode,
		CreatedOn,
		CreatedBy,
		ModifiedOn,
		ModifiedBy
	)
	SELECT DISTINCT
		t.CompanyID,
		t.CompanyStatusID,
		t.CompanyActivityID,
		t.HealthcareInstitutionTypeID,
		t.AddressPlaceId,
		t.AddressPostalCodeId,
		t.AddressQuarterId,
		t.CountryId,
		t.HealthcareInstitutionUnitName,
		t.HealthcareInstitutionUnitLongName,
		t.AddressStreetName,
		t.addressStreetCode,
		t.addressStreetNumber,
		t.AddressStreetNumberCode,
		t.AddressComplements,
		t.ForeignPlace,
		t.ForeignAddress,
		t.UnitCode,
		t.ActivityCode,
		t.FoundedOn,
		t.TerminatedOn,
		t.HealthcareInstitutionLocationId,
		t.StartActivityDate,
		t.EndActivityDate,
		t.TaxNumber,
		t.Email,
		t.HealthcareInstitutionUnitTypeId,
		t.PhoneNUmber, 
		t.VirtualUnitCode,
		t.CreatedOn,
		t.CreatedBy,
		t.ModifiedOn,
		t.ModifiedBy
	from #temp t
	join stage.zoroh.elog_davzu ed on ed.sif = t.UnitCode
	left join MedicalWorker.HealthcareInstitutionUnits hiu on t.UnitCode = hiu.UnitCode
	where hiu.HealthcareInstitutionUnitID IS NULL


	/* ******* 6. UPDATE HEALTCAREINSTITUTIONUNITS  ******* */
	UPDATE hiut
	SET 
		CompanyID = stg.CompanyID,
		CompanyStatusID = stg.CompanyStatusID,
		CompanyActivityID = stg.CompanyActivityID,
		HealthcareInstitutionTypeID = stg.HealthcareInstitutionTypeID,
		AddressPlaceID = stg.AddressPlaceID,
		AddressPostalCodeID = stg.AddressPostalCodeID,
		AddressQuarterID = stg.AddressQuarterID,
		CountryID = stg.CountryID,
		HealthcareInstitutionUnitName = stg.Name,
		HealthcareInstitutionUnitLongName = stg.LongName,
		AddressStreetName = stg.AddressStreetName,
		AddressStreetCode = stg.AddressStreetCode,
		AddressStreetNumber = stg.AddressStreetNumber,
		AddressStreetNumberCode = stg.AddressStreetNumberCode,
		AddressComplements = stg.AddressComplements,
		ForeignPlace = stg.ForeignPlace,
		ForeignAddress = stg.ForeignAddress,
		UnitCode = stg.HealthcareInstitutionCode,
		FoundedOn = stg.FoundedOn,
		TerminatedOn = stg.TerminatedOn,
		StartActivityDate = stg.StartActivityDate,
		EndActivityDate = stg.EndActivityDate,
		ModifiedOn = GETDATE()
	FROM MedicalWorker.HealthcareInstitutionUnits hiut
	JOIN stage.zoroh.elog_davzu ed on hiut.UnitCode = ed.sif
	JOIN dbo.Healthcare_sync stg ON hiut.CompanyID = stg.CompanyID AND hiut.UnitCode = stg.HealthcareInstitutionCode
	WHERE ed.al_a = 'U'


	/* **** 7. UBACI U HISTORY **** */

	;with cte_insert as (
		select distinct
		 un.HealthcareInstitutionUnitID As HealthcareInstitutionUnitID,
		 stg.HealthcareInstitutionTypeID,
		 stg.AddressPlaceID,
		 stg.AddressPostalCodeID,
		 stg.AddressQuarterID,
		 stg.Name as HealthcareInstitutionUnitName,
		 stg.LongName as HealthcareInstitutionUnitLongName,
		 stg.AddressStreetName,
		 stg.AddressStreetCode,
		 stg.AddressStreetNumber,
		 stg.AddressStreetNumberCode,
		 stg.AddressComplements,
		 stg.HealthcareInstitutionCode as UnitCode,
		 stg.FoundedOn,
		 stg.TerminatedOn,
		 stg.StartActivityDate,
		 stg.EndActivityDate,
		 GETDATE() as CreatedOn,
		 'MIGRACIJA' as CreatedBy,
		 GETDATE() as ModifiedOn,
		'MIGRACIJA' as ModifiedBy
		 from dbo.Healthcare_sync stg
		 join MedicalWorker.HealthcareInstitutionUnits un on stg.CompanyID = un.CompanyID
		 where rnk > 1 
		 and stg.CompanyID not in (
			select pom.CompanyID
			from dbo.Healthcare_sync pom 
			where rnk =1 and companyId is Not null
			group by pom.CompanyID
			having COUNT(*)> 1
		)
		and stg.companyID is not null
	)
	insert into MedicalWorker.HealthcareInstitutionUnitsHistory(
	  [HealthcareInstitutionUnitID]
      ,[HealthcareInstitutionTypeID]
      ,[AddressPlaceID]
      ,[AddressPostalCodeID]
      ,[AddressQuarterID]
      ,[HealthcareInstitutionUnitName]
      ,[HealthcareInstitutionUnitLongName]
      ,[AddressStreetName]
      ,[AddressStreetCode]
      ,[AddressStreetNumber]
      ,[AddressStreetNumberCode]
      ,[AddressComplements]
      ,[UnitCode]
      ,[FoundedOn]
      ,[TerminatedOn]
      ,[StartActivityDate]
      ,[EndActivityDate]
      ,[CreatedOn]
      ,[CreatedBy]
      ,[ModifiedOn]
      ,[ModifiedBy]
	)
	SELECT DISTINCT
	   c.[HealthcareInstitutionUnitID]
      ,c.[HealthcareInstitutionTypeID]
      ,c.[AddressPlaceID]
      ,c.[AddressPostalCodeID]
      ,c.[AddressQuarterID]
      ,c.[HealthcareInstitutionUnitName]
      ,c.[HealthcareInstitutionUnitLongName]
      ,c.[AddressStreetName]
      ,c.[AddressStreetCode]
      ,c.[AddressStreetNumber]
      ,c.[AddressStreetNumberCode]
      ,c.[AddressComplements]
      ,c.[UnitCode]
      ,c.[FoundedOn]
      ,c.[TerminatedOn]
      ,c.[StartActivityDate]
      ,c.[EndActivityDate]
      ,c.[CreatedOn]
      ,c.[CreatedBy]
      ,c.[ModifiedOn]
      ,c.[ModifiedBy]
	FROM cte_insert c
	JOIN stage.zoroh.elog_davzu ed on c.UnitCode = ed.sif
	LEFT JOIN MedicalWorker.HealthcareInstitutionUnitsHistory huh on huh.UnitCode = c.UnitCode
	WHERE huh.HealthcareInstitutionUnitHistoryID IS NULL

	--------------------------

	select distinct
		un.HealthcareInstitutionUnitID,
		 hu.CompanyID as CompanyID,
		hu.CompanyStatusID as CompanyStatusID,
		hu.CompanyActivityID as CompanyActivityID,
		ht.HealthcareInstitutionTypeID,
		mppc.MunicipalityPlaceID as AddressPlaceId,
		mppc.PostalCodeID as AddressPostalCodeId,
		null as AddressQuarterId,
		hu.CountryID as CountryId,
		a.tvrtka as HealthcareInstitutionUnitName,
		a.naziv as HealthcareInstitutionUnitLongName,
		a.ulica_naziv as AddressStreetName,
		a.ulicadgu_id as addressStreetCode,
		case when PATINDEX('%[^0-9]%', a.kucbr) > 0 and PATINDEX('%[0-9]%', left(a.kucbr, PATINDEX('%[^0-9]%', a.kucbr) -1) ) > 0  
			then left(a.kucbr, PATINDEX('%[^0-9]%', a.kucbr) -1) 
			when PATINDEX('%[^0-9]%', a.kucbr) > 0 and PATINDEX('%[0-9]%', left(a.kucbr, PATINDEX('%[^0-9]%', a.kucbr) -1) ) = 0  
			then null
			when a.kucbr = '' then null
			else a.kucbr end as addressStreetNumber,
		null as AddressStreetNumberCode,
		case when PATINDEX('%[^0-9]%', a.kucbr) > 0 
			then substring(a.kucbr, PATINDEX('%[^0-9]%', a.kucbr),len (a.kucbr) - PATINDEX('%[^0-9]%', a.kucbr)+1 ) 
			else null end as AddressComplements,
		null as ForeignPlace,
		null as ForeignAddress,
		a.sif as UnitCode,
		null as ActivityCode,
		a.datpoc as FoundedOn,
		a.datkr as TerminatedOn,
		null as HealthcareInstitutionLocationId,
		a.dpocr as StartActivityDate,
		a.dprer as EndActivityDate,
		null as TaxNumber,
		null as Email,
		2 as HealthcareInstitutionUnitTypeId,
		null as PhoneNUmber, 
		null as VirtualUnitCode,
		getdate() as CreatedOn,
		N'MIGRACIJA' as CreatedBy,
		getdate() as ModifiedOn,
		N'MIGRACIJA' as ModifiedBy--,
		--RANK() over (partition by  hu.CompanyID order by l.LocationID desc) as rnkLoc
	into #huh_tempica
	from (
		select distinct dz.*,
		dz1.sif as parentsif, 
		dz1.pospar_sif as parentPospar_sif,
		--coalesce(dz1.sif, dz2.sif) as parentsif, 
		--coalesce(dz1.pospar_sif, dz2.pospar_sif) as parentPospar_sif,
		dav1.*,
		rank() over (PARTITION by dz.sif order by isnull(dav1.datdo,'2099-01-01') desc, isnull(dz1.dprer,'2099-01-01') desc) as rnk
		from stage.dbo.tip_dzu_Mapping mp
		join stage.zoroh.davzu dz on mp.zoroh_tip_dzu_id = dz.tipdzu_id
		join stage.zoroh.davzak dav1 on dz.sif = dav1.davzu_sif and dav1.vrodzu_id in (2,3) --and dav1.datdo is null -- dijete
		join stage.zoroh.davzu dz1 on dav1.davzu_sif_zak = dz1.sif
		join stage.dbo.tip_dzu_mapping mp1 on dz1.tipdzu_id = mp1.zoroh_tip_dzu_id and mp1.nadtip_dzu_id in (1)
		where mp.nadtip_dzu_id  = 3 
		and dav1.davzu_sif is not null--  and dav1.datdo is  null
		and mp1.nadtip_dzu_id is not null
		--and dz.sif = '081002530'
	) a
	left join dbo.Healthcare_sync stgH on a.parentPospar_sif = stgH.CompanySifOrig
	left join MedicalWorker.HealthcareInstitutions hi on stgH.CompanyID = hi.HealthcareInstitutionID --and hi.EndActivityDate is null
	left join MedicalWorker.HealthcareInstitutionUnits hu on stgH.CompanyID = hu.CompanyID and hu.HealthcareInstitutionUnitTypeID =1-- and hu.TerminatedOn is null
	left join MedicalWorker.HealthcareInstitutionTypes ht on a.tipdzu_id = ht.MigrationID
	left join dbo.MunicipalityPlacePostalCodes mppc on a.naselje_id = mppc.MigrationID 
	join MedicalWorker.HealthcareInstitutionUnits un on hu.CompanyID = un.CompanyID and un.UnitCode = hu.UnitCode
	where
		a.rnk = 1 and
		hu.CompanyID is not null 
		and (stgH.rnk > 1 or hi.EndActivityDate is not null or  hu.TerminatedOn is not null)



	INSERT INTO MedicalWorker.HealthcareInstitutionUnitsHistory(
		HealthcareInstitutionUnitID,
		HealthcareInstitutionTypeID,
		AddressPlaceID,
		AddressPostalCodeID,
		AddressQuarterID,
		HealthcareInstitutionUnitName,
		HealthcareInstitutionUnitLongName,
		AddressStreetName,
		AddressStreetCode,
		AddressStreetNumber,
		AddressStreetNumberCode,
		AddressComplements,
		UnitCode,
		FoundedOn,
		TerminatedOn,
		StartActivityDate,
		EndActivityDate,
		CreatedOn,
		CreatedBy,
		ModifiedOn,
		ModifiedBy
	)
	select DISTINCT
		t.HealthcareInstitutionUnitID,
		t.HealthcareInstitutionTypeID,
		t.AddressPlaceID,
		t.AddressPostalCodeID,
		t.AddressQuarterID,
		t.HealthcareInstitutionUnitName,
		t.HealthcareInstitutionUnitLongName,
		t.AddressStreetName,
		t.AddressStreetCode,
		t.AddressStreetNumber,
		t.AddressStreetNumberCode,
		t.AddressComplements,
		t.UnitCode,
		t.FoundedOn,
		t.TerminatedOn,
		t.StartActivityDate,
		t.EndActivityDate,
		t.CreatedOn,
		t.CreatedBy,
		t.ModifiedOn,
		t.ModifiedBy
	from #huh_tempica t 
	join stage.zoroh.elog_davzu on t.UnitCode = sif
	left join MedicalWorker.HealthcareInstitutionUnitsHistory huh on t.UnitCode = huh.UnitCode
	where huh.HealthcareInstitutionUnitHistoryID is null

	UPDATE huh 
	SET
		huh.HealthcareInstitutionUnitID = t.HealthcareInstitutionUnitID,
		huh.HealthcareInstitutionTypeID = t.HealthcareInstitutionTypeID,
		huh.AddressPlaceID = t.AddressPlaceID,
		huh.AddressPostalCodeID = t.AddressPostalCodeID,
		huh.AddressQuarterID = t.AddressQuarterID,
		huh.HealthcareInstitutionUnitName = t.HealthcareInstitutionUnitName,
		huh.HealthcareInstitutionUnitLongName = t.HealthcareInstitutionUnitLongName,
		huh.AddressStreetName = t.AddressStreetName,
		huh.AddressStreetCode = t.AddressStreetCode,
		huh.AddressStreetNumber = t.AddressStreetNumber,
		huh.AddressStreetNumberCode = t.AddressStreetNumberCode,
		huh.AddressComplements = t.AddressComplements,
		huh.UnitCode = t.UnitCode,
		huh.FoundedOn = t.FoundedOn,
		huh.TerminatedOn = t.TerminatedOn,
		huh.StartActivityDate = t.StartActivityDate,
		huh.EndActivityDate = t.EndActivityDate,
		huh.ModifiedOn = GETDATE()
	FROM MedicalWorker.HealthcareInstitutionUnitsHistory huh
	JOIN #huh_tempica t on huh.UnitCode = t.UnitCode
	join stage.zoroh.elog_davzu on t.UnitCode = sif
	WHERE al_a = 'U'

	drop table #huh_tempica;


	/* *** 8. UBACI U LOKACIJE *** */
	

	DECLARE
		@HealthcareInstitutionID_loc INT,
		@Name NVARCHAR(MAX),
		@AddressPlaceID_loc INT,
		@AddressPostalCodeID_loc INT,
		@AddressStreetName_loc NVARCHAR(MAX),
		@AddressStreetNumber_loc NVARCHAR(MAX),
		@AddressComplements_loc NVARCHAR(MAX),
		@Code NVARCHAR(MAX)

	DECLARE ErrorLogCursor CURSOR FAST_FORWARD 
	FOR
		SELECT DISTINCT
			hi.HealthcareInstitutionID,
			dz.naziv as Name,
			mppc.MunicipalityPlaceID as AddressPlaceId,
			mppc.PostalCodeID as AddressPostalCodeId,
			dz.ulica_naziv as AddressStreetName,
			case when PATINDEX('%[^0-9]%', dz.kucbr) > 0 and PATINDEX('%[0-9]%', left(dz.kucbr, PATINDEX('%[^0-9]%', dz.kucbr) -1) ) > 0  
				then left(dz.kucbr, PATINDEX('%[^0-9]%', dz.kucbr) -1) 
				when PATINDEX('%[^0-9]%', dz.kucbr) > 0 and PATINDEX('%[0-9]%', left(dz.kucbr, PATINDEX('%[^0-9]%', dz.kucbr) -1) ) = 0  
				then null
				when dz.kucbr = '' then null
				else dz.kucbr end as AddressStreetNumber,
			case when PATINDEX('%[^0-9]%', dz.kucbr) > 0 
				then substring(dz.kucbr, PATINDEX('%[^0-9]%', dz.kucbr),len (dz.kucbr) - PATINDEX('%[^0-9]%', dz.kucbr)+1 ) 
				else null end as AddressComplements,
			dz.sif as Code
			from stage.dbo.tip_dzu_Mapping mp
			join stage.zoroh.davzu dz on mp.zoroh_tip_dzu_id = dz.tipdzu_id
			join stage.zoroh.elog_davzu ed on dz.sif = ed.sif
			left join stage.zoroh.davzak dav on dz.sif = dav.davzu_sif and dav.vrodzu_id in (2,3) -- lokacija
			left join stage.zoroh.davzu dz1 on dav.davzu_sif_zak = dz1.sif
			left join stage.dbo.tip_dzu_mapping mp1 on dz1.tipdzu_id = mp1.zoroh_tip_dzu_id and mp1.nadtip_dzu_id =1
			join dbo.Healthcare_sync stg on dz1.sif = stg.HealthcareInstitutionCode
			join dbo.Healthcare_sync stg1 on stg.CompanyID = stg1.CompanyID and stg1.rnk =1
			join MedicalWorker.HealthcareInstitutions hi on stg1.HealthcareInstitutionCode = hi.HealthcareInstitutionCode
			join dbo.MunicipalityPlacePostalCodes mppc on dz.naselje_id = mppc.MigrationId
			left join MedicalWorker.Locations loc on loc.Code = ed.sif
			where 
				(mp.nadtip_dzu_id  = 2 or (mp.nadtip_dzu_id  = 1 and dz.pospar_sif is null)) and dav.davzu_sif is not null and mp1.nadtip_dzu_id is not null 
				and dz.sif not like N'999%'
				and loc.LocationID IS NULL
			
			
	OPEN ErrorLogCursor;
	FETCH NEXT FROM ErrorLogCursor INTO @HealthcareInstitutionID_loc, @Name, @AddressPlaceID_loc, @AddressPostalCodeId_loc, @AddressStreetName_loc, @AddressStreetNumber_loc, @AddressComplements_loc, @Code


	WHILE @@FETCH_STATUS = 0
		BEGIN
			BEGIN TRY
				INSERT INTO MedicalWorker.Locations (
					HealthcareInstitutionID,
					Name,
					AddressPlaceID,
					AddressPostalCodeID,
					AddressStreetName,
					AddressStreetNumber,
					AddressComplements,
					Code,
					CreatedOn,
					CreatedBy,
					ModifiedOn,
					ModifiedBy
				)
				VALUES(@HealthcareInstitutionID_loc, @Name, @AddressPlaceID_loc, @AddressPostalCodeId_loc, @AddressStreetName_loc, @AddressStreetNumber_loc, @AddressComplements_loc, @Code, GETDATE(), 'MIGRACIJA', GETDATE(), 'MIGRACIJA')
				FETCH NEXT FROM ErrorLogCursor INTO @HealthcareInstitutionID_loc, @Name, @AddressPlaceID_loc, @AddressPostalCodeId_loc, @AddressStreetName_loc, @AddressStreetNumber_loc, @AddressComplements_loc, @Code
			END TRY
			BEGIN CATCH
				INSERT INTO errorTbls.Locations_error_sync (
					HealthcareInstitutionID,
					Name,
					AddressPlaceID,
					AddressPostalCodeID,
					AddressStreetName,
					AddressStreetNumber,
					AddressComplements,
					Code,
					CreatedOn,
					CreatedBy,
					ModifiedOn,
					ModifiedBy,
					ErrorMessage
				)
				VALUES(@HealthcareInstitutionID_loc, @Name, @AddressPlaceID_loc, @AddressPostalCodeId_loc, @AddressStreetName_loc, @AddressStreetNumber_loc, @AddressComplements_loc, @Code, GETDATE(), 'MIGRACIJA', GETDATE(), 'MIGRACIJA', ERROR_MESSAGE())
			
				FETCH NEXT FROM ErrorLogCursor INTO @HealthcareInstitutionID_loc, @Name, @AddressPlaceID_loc, @AddressPostalCodeId_loc, @AddressStreetName_loc, @AddressStreetNumber_loc, @AddressComplements_loc, @Code
			END CATCH
		END;

	CLOSE ErrorLogCursor;
	DEALLOCATE ErrorLogCursor;	


	/* *** PRIPREG GENERALNI UPDATE **** */

	update hu
		set AddressQuarterID = m.MunicipalityID
	from stage.zoroh.pripreg p
	join stage.zoroh.davzu d on p.davzu_sif = d.sif
	join MedicalWorker.healthcareINstitutionUnits hu on d.sif = hu.UnitCode
	join stage.zoroh.regija r on p.regija_id = r.id
	join dbo.Municipalities m on r.id = m.MigrationID and m.MunicipalityTypeID = 3


	/* ******* TKO NIJE DOHVAĆEN?  ******* */

	INSERT INTO errorTbls.HealthcareInstitutions_error_sync
			(
				HealthcareInstitutionCode,
				ErrorMessage
			)
	SELECT DISTINCT
	d.sif, 
	'Ne nalazi se u eHZZO MedicalWorker Schemi' AS ErrorMessage
	FROM stage.zoroh.davzu d
	JOIN stage.zoroh.elog_davzu ed ON d.sif = ed.sif
	LEFT JOIN MedicalWorker.HealthcareInstitutionUnits hiut ON hiut.UnitCode = d.sif
	LEFT JOIN MedicalWorker.HealthcareInstitutions hi ON hi.HealthcareInstitutionCode = d.sif
	LEFT JOIN MedicalWorker.HealthcareInstitutionUnitsHistory hiuh ON hiuh.UnitCode = d.sif
	LEFT JOIN MedicalWorker.Locations l ON l.Code = d.sif
	WHERE hiut.HealthcareInstitutionUnitID IS NULL
		AND hi.HealthcareInstitutionID IS NULL
		AND hiuh.HealthcareInstitutionUnitHistoryID IS NULL
		AND l.LocationID IS NULL
		
GO


/*
==================================================
PROCEDURA [dbo].[TaxPayersSync]
==================================================
*/

CREATE OR ALTER PROCEDURE [dbo].[TaxPayersSync]
AS
	BEGIN /* Region Insert */

		-- 1. kreiram temp tabelu gde ce biti samo 'id' i 'flid' iz tabele elog_obvupl koje treba da se insertuju (al_a = 'I')
		IF object_id('obvupl_insert','U') IS NOT NULL
			DROP TABLE obvupl_insert;

		SELECT   [id] AS obvupl_id, 
				 [flid] AS obvupl_flid 
		INTO obvupl_insert
		FROM stage.zoroh.elog_obvupl
		WHERE al_a = 'I' AND id IS NOT NULL
		GROUP BY [id], [flid]

		-- kreiram indexe
		IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name='IDX_obvupl_insert_obvupl_id' AND object_id = OBJECT_ID('obvupl_insert')) 
			create index IDX_obvupl_insert_obvupl_id on obvupl_insert (obvupl_id);
		IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name='IDX_obvupl_insert_obvupl_flid' AND object_id = OBJECT_ID('obvupl_insert')) 
			create index IDX_obvupl_insert_obvupl_flid on obvupl_insert (obvupl_flid);
		IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name='IDX_Companies_Code' AND object_id = OBJECT_ID('dbo.Companies')) 
			create index IDX_Companies_Code on dbo.Companies (Code);
		IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name like N'%stg_Companies_pospar_sif%' AND object_id = OBJECT_ID('stage.stg.stg_Companies'))
			---drop index IDX_stg_Companies_pospar_sif on stage.stg.stg_Companies;
			BEGIN TRY
				create index IDX_stg_Companies_pospar_sif on stage.stg.stg_Companies (pospar_sif);
			END TRY
			BEGIN CATCH
				PRINT ERROR_MESSAGE()
			END CATCH

		-- 2. Insert u temp tabelu novih redova koji imaju 'id' i 'flid' iz obvupl_insert tabele
		DROP TABLE IF EXISTS temp_taxpayers;

		;WITH cpt AS (
			SELECT 
				MigrationID,
				MAX(ContributionPayerTypeID) AS ContributionPayerTypeID
			FROM TaxPayer.ContributionPayerTypes
			GROUP BY MigrationID
		)
		SELECT DISTINCT
			[ContributionPayerTypeID], 
			[LinkID], 
			[CompanyID], 
			[TaxPayerType], 
			[CreatedIn], 
			[CreatedOn], 
			[CreatedBy], 
			[ModifiedOn], 
			[ModifiedBy], 
			[RegionalUnitID], 
			[MigrationID], 
			[id], 
			[flid], 
			[rnk], 
			[obv_jmbg], 
			[obv_pospar_tvrt], 
			[obv_pospar_obrt], 
			[vrobv_id], 
			[vrobv_sifra], 
			[drnk], 
			[id_sljednik], 
			[flid_sljednik], 
			[migrationFlid], 
			[dssobv], 
			[dpsobv] 
		INTO temp_taxpayers
		FROM (
			SELECT DISTINCT
				c.ContributionPayerTypeID	AS [ContributionPayerTypeID], 
				CASE 
					WHEN obvupl.idenos_jmbg_ide IS NOT NULL THEN pers.PersonID
					ELSE comp.CompanyID
				END							AS [LinkID], 
				CASE
					WHEN obvupl.pospar_sif_v IS NOT NULL THEN comp_o.CompanyID
					WHEN obvupl.pospar_sif IS NOT NULL THEN comp.CompanyID
					ELSE NULL
				END							AS [CompanyID], 																
				CASE 
					WHEN obvupl.idenos_jmbg_ide IS NOT NULL THEN 0 
					ELSE 1 
				END							AS [TaxPayerType], 
				ru.RegionalUnitID			AS [CreatedIn], 
				CASE 
					WHEN obvupl.devpri < '1900-02-22' OR obvupl.devpri IS NULL THEN '1900-01-01' 
					ELSE obvupl.devpri 
				END							AS [CreatedOn], 
				'MIGRACIJA'					AS [CreatedBy], 
				GETDATE()					AS [ModifiedOn], 
				'MIGRACIJA'					AS [ModifiedBy], 
				ru.RegionalUnitID			AS [RegionalUnitID], 
				obvupl.id					AS [MigrationID], 
				obvupl.id					AS [id], 
				obvupl.flid					AS [flid], 
				rank() over (partition by obvupl.vrobup_id, obvupl.idenos_jmbg_ide, companies1.sif_sljednik,companies2.sif_sljednik order by obvupl.devpri desc, obvupl.id desc ) 
											AS [rnk], 
				trim(obvupl.idenos_jmbg_ide) AS [obv_jmbg], 
				companies1.sif_sljednik		AS [obv_pospar_tvrt], 
				companies2.sif_sljednik		AS [obv_pospar_obrt], 
				vrobup.id					AS [vrobv_id], 
				trim(vrobup.sifra)			AS [vrobv_sifra], 
				dense_rank() over (order by obvupl.vrobup_id, obvupl.idenos_jmbg_ide, companies1.sif_sljednik,companies2.sif_sljednik ) AS [drnk], 
				null						AS [id_sljednik], 
				null						AS [flid_sljednik], 
				obvupl.flid					AS [migrationFlid], 
				obvupl.dssobv				AS [dssobv], 
				obvupl.dpsobv				AS [dpsobv] 	
			FROM stage.zoroh.obvupl obvupl
				INNER JOIN obvupl_insert ON obvupl.id = obvupl_insert.obvupl_id AND obvupl.flid = obvupl_insert.obvupl_flid
				JOIN stage.zoroh.vrobup on obvupl.vrobup_id = vrobup.id
				LEFT JOIN cpt c ON obvupl.vrobup_id = c.MigrationID
				LEFT JOIN dbo.Persons pers ON pers.UniqueIdentificationNumber = obvupl.idenos_jmbg_ide
				LEFT JOIN dbo.RegionalUnits ru ON ru.MigrationID = obvupl.orgjed_sif_mis
				LEFT JOIN dbo.Companies comp_o ON comp_o.Code = obvupl.pospar_sif_v 
				LEFT JOIN dbo.Companies comp ON comp.Code = obvupl.pospar_sif 
				left join stage.stg.stg_Companies companies1 on obvupl.pospar_sif = companies1.pospar_sif  
				left join stage.stg.stg_Companies companies2 on obvupl.pospar_sif_v = companies2.pospar_sif	
			WHERE c.ContributionPayerTypeID IS NOT NULL
				AND (obvupl.idenos_jmbg_ide IS NOT NULL OR obvupl.pospar_sif IS NOT NULL) 
				AND vrobup.sifra not in ('00016','00030')

			UNION

			SELECT
				c.ContributionPayerTypeID	AS [ContributionPayerTypeID], 
				CASE 
					WHEN obvupl.idenos_jmbg_ide IS NOT NULL THEN pers.PersonID
					ELSE comp.CompanyID
				END							AS [LinkID], 
				CASE
					WHEN obvupl.pospar_sif_v IS NOT NULL THEN comp_o.CompanyID
					WHEN obvupl.pospar_sif IS NOT NULL THEN comp.CompanyID
					ELSE NULL
				END							AS [CompanyID], 																
				CASE 
					WHEN obvupl.idenos_jmbg_ide is not null THEN 0 
					ELSE 1 
				END							AS [TaxPayerType], 
				ru.RegionalUnitID			AS [CreatedIn], 
				CASE 
					WHEN obvupl.devpri < '1900-02-22' OR obvupl.devpri IS NULL THEN '1900-01-01' 
					ELSE obvupl.devpri 
				END							AS [CreatedOn], 
				'MIGRACIJA'					AS [CreatedBy], 
				GETDATE()					AS [ModifiedOn], 
				'MIGRACIJA'					AS [ModifiedBy], 
				ru.RegionalUnitID			AS [RegionalUnitID], 
				obvupl.id					AS [MigrationID], 
				obvupl.id					AS [id], 
				obvupl.flid					AS [flid], 
				2							AS [rnk], 
				trim(obvupl.idenos_jmbg_ide) AS [obv_jmbg], 
				trim(obvupl.pospar_sif)		AS [obv_pospar_tvrt], 
				trim(obvupl.pospar_sif_v)	AS [obv_pospar_obrt], 
				vrobup.id					AS [vrobv_id], 
				trim(vrobup.sifra)			AS [vrobv_sifra], 
				99999999					AS [drnk], 
				null						AS [id_sljednik], 
				null						AS [flid_sljednik], 
				obvupl.flid					AS [migrationFlid], 
				obvupl.dssobv				AS [dssobv], 
				obvupl.dpsobv				AS [dpsobv] 
			FROM stage.zoroh.obvupl obvupl
				INNER JOIN obvupl_insert ON obvupl.id = obvupl_insert.obvupl_id AND obvupl.flid = obvupl_insert.obvupl_flid
				join stage.zoroh.vrobup on obvupl.vrobup_id = vrobup.id
				LEFT JOIN cpt c ON obvupl.vrobup_id = c.MigrationID
				LEFT JOIN dbo.Persons pers ON pers.UniqueIdentificationNumber = obvupl.idenos_jmbg_ide
				LEFT JOIN dbo.RegionalUnits ru ON ru.MigrationID = obvupl.orgjed_sif_mis
				LEFT JOIN dbo.Companies comp_o ON comp_o.Code = obvupl.pospar_sif_v 
				LEFT JOIN dbo.Companies comp ON comp.Code = obvupl.pospar_sif 
				left join stage.stg.stg_Companies companies1 on obvupl.pospar_sif = companies1.pospar_sif  
				left join stage.stg.stg_Companies companies2 on obvupl.pospar_sif_v = companies2.pospar_sif	
			WHERE c.ContributionPayerTypeID IS NOT NULL
				AND (obvupl.idenos_jmbg_ide IS NOT NULL OR obvupl.pospar_sif IS NOT NULL) 
				AND vrobup.sifra in ('00016','00030')
		) tp


		-- 3. punimo TaxPayer.TaxPayers novim podacima iz temp_taxpayers tabele
		--==========================================
		-- INSERT novih redova u TaxPayer.TaxPayers
		--==========================================
		DECLARE
			@ContributionPayerTypeID INT, @LinkID INT, @CompanyID INT, @TaxPayerType INT, @CreatedIn INT, @RegionalUnitID INT, @MigrationID INT, @MigrationFlid INT

		DECLARE ErrorLogCursor CURSOR FAST_FORWARD 
		FOR
			SELECT
				tt.ContributionPayerTypeID, 
				tt.LinkID,
				tt.CompanyID, 
				tt.TaxPayerType, 
				tt.CreatedIn, 
				tt.RegionalUnitID, 
				tt.MigrationID, 
				tt.MigrationFlid 
			FROM temp_taxpayers tt
			WHERE tt.MigrationID NOT IN (SELECT MigrationID FROM TaxPayer.TaxPayers) AND LinkID IS NOT NULL

		OPEN ErrorLogCursor;
		FETCH NEXT FROM ErrorLogCursor INTO @ContributionPayerTypeID, @LinkID, @CompanyID, @TaxPayerType, @CreatedIn, @RegionalUnitID, @MigrationID, @MigrationFlid

		WHILE @@FETCH_STATUS = 0
			BEGIN
				BEGIN TRY
					INSERT INTO TaxPayer.TaxPayers (
						ContributionPayerTypeID,
						LinkID,
						CompanyID,
						TaxPayerType,
						CreatedIn,
						RegionalUnitID,
						MigrationID,
						MigrationFlid
					)
					VALUES (@ContributionPayerTypeID, @LinkID, @CompanyID, @TaxPayerType, @CreatedIn, @RegionalUnitID, @MigrationID, @MigrationFlid)
					FETCH NEXT FROM ErrorLogCursor INTO @ContributionPayerTypeID, @LinkID, @CompanyID, @TaxPayerType, @CreatedIn, @RegionalUnitID, @MigrationID, @MigrationFlid
				END TRY
				BEGIN CATCH
						INSERT INTO errorTbls.TaxPayers_error_sync (
						ContributionPayerTypeID,
						LinkID,
						CompanyID,
						TaxPayerType,
						CreatedIn,
						RegionalUnitID,
						MigrationID,
						MigrationFlid,
						ErrorMessage
					)
					VALUES (@ContributionPayerTypeID, @LinkID, @CompanyID, @TaxPayerType, @CreatedIn, @RegionalUnitID, @MigrationID, @MigrationFlid, CONCAT('INSERT - ', ERROR_MESSAGE()))

					FETCH NEXT FROM ErrorLogCursor INTO @ContributionPayerTypeID, @LinkID, @CompanyID, @TaxPayerType, @CreatedIn, @RegionalUnitID, @MigrationID, @MigrationFlid
				END CATCH

			END;

		CLOSE ErrorLogCursor;
		DEALLOCATE ErrorLogCursor;


		-- 4. punimo stage tabelu novim podacima iz temp_taxpayers tabele
		INSERT INTO stage.stg.stg_TaxPayers 
		SELECT
			tmp.ContributionPayerTypeID AS [ContributionPayerTypeID], 
			tmp.LinkID AS [LinkID], 
			tmp.CompanyID AS [CompanyID], 
			tmp.TaxPayerType AS [TaxPayerType], 
			tmp.CreatedIn AS [CreatedIn], 
			tmp.CreatedOn AS [CreatedOn], 
			tmp.CreatedBy AS [CreatedBy], 
			tmp.ModifiedOn AS [ModifiedOn], 
			tmp.ModifiedBy AS [ModifiedBy], 
			tmp.RegionalUnitID AS [RegionalUnitID], 
			tmp.MigrationID AS [MigrationID], 
			tmp.id AS [id], 
			tmp.flid AS [flid], 
			tmp.rnk AS [rnk], 
			tmp.obv_jmbg AS [obv_jmbg], 
			tmp.obv_pospar_tvrt AS [obv_pospar_tvrt], 
			tmp.obv_pospar_obrt AS [obv_pospar_obrt], 
			tmp.vrobv_id AS [vrobv_id], 
			tmp.vrobv_sifra AS [vrobv_sifra],
			tmp.drnk AS [drnk], 
			tmp.id_sljednik AS [id_sljednik], 
			tmp.flid_sljednik AS [flid_sljednik], 
			tmp.migrationFlid AS [migrationFlid], 
			tmp.dssobv AS [dssobv], 
			tmp.dpsobv AS [dpsobv] 
		FROM temp_taxpayers tmp
			LEFT JOIN stage.stg.stg_TaxPayers stpt ON stpt.MigrationID = tmp.MigrationID
		WHERE stpt.MigrationID IS NULL 


		-- 5. update stage tabele - update sljednika za zapise koji se ne migriraju, sluzi za povezivanje osiguranja na obveznike
		update t1
		set 
			t1.id_sljednik = t2.id,
			t1.flid_sljednik = t2.flid
		from stage.stg.stg_TaxPayers t1
			join stage.stg.stg_TaxPayers t2 on t1.drnk = t2.drnk
		where t1.rnk >1 and t2.rnk = 1
			and t1.linkid is not null  and t1.drnk <> 99999999 ;

		-- update sljednika za bivsa tijela za vezu, to je sada HZZO
		update t1
		set 
			t1.id_sljednik = t2.id,
			t1.flid_sljednik = t2.flid
		from stage.stg.stg_TaxPayers t1
			join stage.stg.stg_TaxPayers t2 on t1.drnk = t2.drnk and t1.vrobv_id = t2.vrobv_id
		where t1.rnk >1 and t2.rnk = 1
			and t1.linkid is not null  and t1.drnk = 99999999 ;


		-- 6. update stage tabele za rnk i drnk
		UPDATE t1
		SET rnk = tp.rnk, 
			drnk = tp.drnk
		FROM stage.stg.stg_TaxPayers t1
			LEFT JOIN (
				SELECT DISTINCT
					obvupl.id AS [id], 
					obvupl.flid AS [flid], 
					rank() over (partition by obvupl.vrobup_id, obvupl.idenos_jmbg_ide, companies1.sif_sljednik, companies2.sif_sljednik order by obvupl.devpri desc, obvupl.id desc ) AS [rnk], -- NOT NULL,
					dense_rank() over (order by obvupl.vrobup_id, obvupl.idenos_jmbg_ide, companies1.sif_sljednik,companies2.sif_sljednik ) AS [drnk]	

				FROM stage.zoroh.obvupl obvupl
					join stage.zoroh.vrobup on obvupl.vrobup_id = vrobup.id
					left join stage.stg.stg_Companies companies1 on obvupl.pospar_sif = companies1.pospar_sif  
					left join stage.stg.stg_Companies companies2 on obvupl.pospar_sif_v = companies2.pospar_sif	
				WHERE (obvupl.idenos_jmbg_ide IS NOT NULL OR obvupl.pospar_sif IS NOT NULL) 
					AND vrobup.sifra not in ('00016','00030')

				UNION

				SELECT
					obvupl.id AS [id], 
					obvupl.flid AS [flid], 
					2 AS [rnk], 
					99999999 AS [drnk]	
				FROM stage.zoroh.obvupl obvupl
					join stage.zoroh.vrobup on obvupl.vrobup_id = vrobup.id
					left join stage.stg.stg_Companies companies1 on obvupl.pospar_sif = companies1.pospar_sif  
					left join stage.stg.stg_Companies companies2 on obvupl.pospar_sif_v = companies2.pospar_sif	
				WHERE (obvupl.idenos_jmbg_ide IS NOT NULL OR obvupl.pospar_sif IS NOT NULL) 
					AND vrobup.sifra in ('00016','00030')
			) tp ON t1.id = tp.id AND t1.flid = tp.flid
		WHERE tp.rnk is not null


		-- drop indexa
		DROP INDEX IF EXISTS IDX_obvupl_insert_obvupl_id ON obvupl_insert;
		DROP INDEX IF EXISTS IDX_obvupl_insert_obvupl_flid ON obvupl_insert;

		-- drop pomocnih tabela
		DROP TABLE obvupl_insert;
		DROP TABLE temp_taxpayers;

	 -- kraj dela za insert

	 /* Region Update */

		-- 1. kreiram temp tabelu gde ce biti samo 'id' i 'flid' iz tabele elog_obvupl koje treba da se updateuju (al_a = 'U')
		IF object_id('obvupl_update','U') IS NOT NULL
			DROP TABLE obvupl_update;

		SELECT   [id] AS obvupl_id, 
				 [flid] AS obvupl_flid 
		INTO obvupl_update
		FROM stage.zoroh.elog_obvupl
		WHERE al_a = 'U' AND id IS NOT NULL
		GROUP BY [id], [flid]


		-- kreiram indexe
		IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name='IDX_obvupl_update_obvupl_id' AND object_id = OBJECT_ID('obvupl_update')) 
			create index IDX_obvupl_update_obvupl_id on obvupl_update (obvupl_id);
		IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name='IDX_obvupl_update_obvupl_flid' AND object_id = OBJECT_ID('obvupl_update')) 
			create index IDX_obvupl_update_obvupl_flid on obvupl_update (obvupl_flid);


		-- 2. napuniti temp tabelu podacima koji treba da se updateuju za 'id' i 'flid' iz obvupl_update tabele
		DROP TABLE IF EXISTS temp_taxpayers;

		;WITH cpt AS (
			SELECT 
				MigrationID,
				MAX(ContributionPayerTypeID) AS ContributionPayerTypeID
			FROM TaxPayer.ContributionPayerTypes
			GROUP BY MigrationID
		)
		SELECT 
			[ContributionPayerTypeID], 
			[LinkID], 
			[CompanyID], 
			[TaxPayerType], 
			[CreatedIn], 
			[CreatedOn], 
			[CreatedBy],
			[ModifiedOn], 
			[ModifiedBy], 
			[RegionalUnitID], 
			[MigrationID], 
			[id], 
			[flid], 
			[rnk], 
			[obv_jmbg], 
			[obv_pospar_tvrt], 
			[obv_pospar_obrt], 
			[vrobv_id], 
			[vrobv_sifra], 
			[drnk], 
			[id_sljednik], 
			[flid_sljednik], 
			[migrationFlid], 
			[dssobv], 
			[dpsobv] 
		INTO temp_taxpayers
		FROM (
			SELECT DISTINCT
				c.ContributionPayerTypeID	AS [ContributionPayerTypeID], 
				CASE 
					WHEN obvupl.idenos_jmbg_ide IS NOT NULL THEN pers.PersonID
					ELSE comp.CompanyID
				END							AS [LinkID], 
				CASE
					WHEN obvupl.pospar_sif_v IS NOT NULL THEN comp_o.CompanyID
					WHEN obvupl.pospar_sif IS NOT NULL THEN comp.CompanyID
					ELSE NULL
				END							AS [CompanyID], 																
				CASE 
					WHEN obvupl.idenos_jmbg_ide is not null THEN 0 
					ELSE 1 
				END							AS [TaxPayerType], 
				ru.RegionalUnitID			AS [CreatedIn], 
				CASE 
					WHEN obvupl.devpri < '1900-02-22' OR obvupl.devpri IS NULL THEN '1900-01-01' 
					ELSE obvupl.devpri 
				END							AS [CreatedOn], 
				'MIGRACIJA'					AS [CreatedBy], 
				GETDATE()					AS [ModifiedOn], 
				'MIGRACIJA'					AS [ModifiedBy], 
				ru.RegionalUnitID			AS [RegionalUnitID], 
				obvupl.id					AS [MigrationID], 
				obvupl.id					AS [id], 
				obvupl.flid					AS [flid], 
				rank() over (partition by obvupl.vrobup_id, obvupl.idenos_jmbg_ide, companies1.sif_sljednik,companies2.sif_sljednik order by obvupl.devpri desc, obvupl.id desc ) 
											AS [rnk], 
				trim(obvupl.idenos_jmbg_ide) AS [obv_jmbg], 
				companies1.sif_sljednik		AS [obv_pospar_tvrt], 
				companies2.sif_sljednik		AS [obv_pospar_obrt], 
				vrobup.id					AS [vrobv_id], 
				trim(vrobup.sifra)			AS [vrobv_sifra], 
				dense_rank() over (order by obvupl.vrobup_id, obvupl.idenos_jmbg_ide, companies1.sif_sljednik,companies2.sif_sljednik ) 
											AS [drnk], 
				null						AS [id_sljednik], 
				null						AS [flid_sljednik], 
				obvupl.flid					AS [migrationFlid], 
				obvupl.dssobv				AS [dssobv], 
				obvupl.dpsobv				AS [dpsobv] 	
			FROM stage.zoroh.obvupl obvupl
				INNER JOIN obvupl_update ou ON obvupl.id = ou.obvupl_id AND obvupl.flid = ou.obvupl_flid
				join stage.zoroh.vrobup vrobup on obvupl.vrobup_id = vrobup.id
				LEFT JOIN cpt c ON obvupl.vrobup_id = c.MigrationID
				LEFT JOIN dbo.Persons pers ON pers.UniqueIdentificationNumber = obvupl.idenos_jmbg_ide
				LEFT JOIN dbo.RegionalUnits ru ON ru.MigrationID = obvupl.orgjed_sif_mis
				LEFT JOIN dbo.Companies comp_o ON comp_o.Code = obvupl.pospar_sif_v 
				LEFT JOIN dbo.Companies comp ON comp.Code = obvupl.pospar_sif 
				left join stage.stg.stg_Companies companies1 on obvupl.pospar_sif = companies1.pospar_sif  
				left join stage.stg.stg_Companies companies2 on obvupl.pospar_sif_v = companies2.pospar_sif

			WHERE c.ContributionPayerTypeID IS NOT NULL
				AND (obvupl.idenos_jmbg_ide IS NOT NULL OR obvupl.pospar_sif IS NOT NULL) 
				AND vrobup.sifra not in ('00016','00030')

			UNION

			SELECT DISTINCT
				c.ContributionPayerTypeID AS [ContributionPayerTypeID], 
				CASE 
					WHEN obvupl.idenos_jmbg_ide IS NOT NULL THEN pers.PersonID
					ELSE comp.CompanyID
				END							AS [LinkID], 
				CASE
					WHEN obvupl.pospar_sif_v IS NOT NULL THEN comp_o.CompanyID
					WHEN obvupl.pospar_sif IS NOT NULL THEN comp.CompanyID
					ELSE NULL
				END							AS [CompanyID], 																
				CASE 
					WHEN obvupl.idenos_jmbg_ide is not null THEN 0 
					ELSE 1 
				END							AS [TaxPayerType], 
				ru.RegionalUnitID			AS [CreatedIn], 
				CASE 
					WHEN obvupl.devpri < '1900-02-22' OR obvupl.devpri IS NULL THEN '1900-01-01' 
					ELSE obvupl.devpri 
				END							AS [CreatedOn], 
				'MIGRACIJA'					AS [CreatedBy], 
				GETDATE()					AS [ModifiedOn], 
				'MIGRACIJA'					AS [ModifiedBy], 
				ru.RegionalUnitID			AS [RegionalUnitID], 
				obvupl.id					AS [MigrationID],
				obvupl.id					AS [id], 
				obvupl.flid					AS [flid], 
				2							AS [rnk], 
				trim(obvupl.idenos_jmbg_ide) AS [obv_jmbg], 
				trim(obvupl.pospar_sif)		AS [obv_pospar_tvrt], 
				trim(obvupl.pospar_sif_v)	AS [obv_pospar_obrt], 
				vrobup.id					AS [vrobv_id], 
				trim(vrobup.sifra)			AS [vrobv_sifra], 
				99999999					AS [drnk], 
				null						AS [id_sljednik], 
				null						AS [flid_sljednik], 
				obvupl.flid					AS [migrationFlid], 
				obvupl.dssobv				AS [dssobv],
				obvupl.dpsobv				AS [dpsobv] 

			FROM stage.zoroh.obvupl obvupl
				INNER JOIN obvupl_update ou ON obvupl.id = ou.obvupl_id AND obvupl.flid = ou.obvupl_flid
				join stage.zoroh.vrobup vrobup on obvupl.vrobup_id = vrobup.id
				LEFT JOIN cpt c ON obvupl.vrobup_id = c.MigrationID
				LEFT JOIN dbo.Persons pers ON pers.UniqueIdentificationNumber = obvupl.idenos_jmbg_ide
				LEFT JOIN dbo.RegionalUnits ru ON ru.MigrationID = obvupl.orgjed_sif_mis
				LEFT JOIN dbo.Companies comp_o ON comp_o.Code = obvupl.pospar_sif_v 
				LEFT JOIN dbo.Companies comp ON comp.Code = obvupl.pospar_sif 
				left join stage.stg.stg_Companies companies1 on obvupl.pospar_sif = companies1.pospar_sif  
				left join stage.stg.stg_Companies companies2 on obvupl.pospar_sif_v = companies2.pospar_sif

			WHERE c.ContributionPayerTypeID IS NOT NULL
				AND (obvupl.idenos_jmbg_ide IS NOT NULL OR obvupl.pospar_sif IS NOT NULL) 
				AND vrobup.sifra in ('00016','00030')
		) tp



		-- 3. Update tabele TaxPayer.TaxPayers za 'id' i 'flid' iz temp_taxpayers tabele
		--============
		-- UPDATE
		--============
		DECLARE @ContributionPayerTypeID_u INT, @LinkID_u INT, @CompanyID_u INT, @TaxPayerType_u INT, @CreatedIn_u INT, @RegionalUnitID_u INT, @MigrationID_u INT, @MigrationFlid_u INT

		DECLARE ErrorLogCursor_update CURSOR FAST_FORWARD 
		FOR
			SELECT DISTINCT
				ContributionPayerTypeID,
				LinkID,
				CompanyID,
				TaxPayerType,
				CreatedIn,
				RegionalUnitID,
				MigrationID,
				MigrationFlid
			FROM temp_taxpayers 
			WHERE LinkID IS NOT NULL

		OPEN ErrorLogCursor_update;
		FETCH NEXT FROM ErrorLogCursor_update INTO @ContributionPayerTypeID_u, @LinkID_u, @CompanyID_u, @TaxPayerType_u, @CreatedIn_u, @RegionalUnitID_u, @MigrationID_u, @MigrationFlid_u

		WHILE @@FETCH_STATUS = 0
			BEGIN
				BEGIN TRY

					UPDATE TaxPayer.TaxPayers 
					SET 
						ContributionPayerTypeID = @ContributionPayerTypeID_u,
						LinkID = @LinkID_u,
						CompanyID = @CompanyID_u, 
						TaxPayerType = @TaxPayerType_u, 
						CreatedIn = @CreatedIn_u, 
						ModifiedOn = GETDATE(),
						RegionalUnitID = @RegionalUnitID_u, 
						MigrationID = @MigrationID_u, 
						MigrationFlid = @migrationFlid_u
					FROM TaxPayer.TaxPayers tptp
					WHERE tptp.MigrationID = @MigrationID_u AND tptp.MigrationFlid = @MigrationFlid_u

					FETCH NEXT FROM ErrorLogCursor_update INTO @ContributionPayerTypeID_u, @LinkID_u, @CompanyID_u, @TaxPayerType_u, @CreatedIn_u, @RegionalUnitID_u, @MigrationID_u, @MigrationFlid_u
				END TRY
				BEGIN CATCH
					INSERT INTO errorTbls.TaxPayers_error_sync (
								ContributionPayerTypeID,
								LinkID,
								CompanyID,
								TaxPayerType,
								CreatedIn,
								RegionalUnitID,
								MigrationID,
								MigrationFlid,
								ErrorMessage
							)
					VALUES(@ContributionPayerTypeID_u, @LinkID_u, @CompanyID_u, @TaxPayerType_u, @CreatedIn_u, @RegionalUnitID_u, @MigrationID_u, @MigrationFlid_u, 'UPDATE Error - ' + ERROR_MESSAGE())

					FETCH NEXT FROM ErrorLogCursor_update INTO @ContributionPayerTypeID_u, @LinkID, @CompanyID, @TaxPayerType, @CreatedIn, @RegionalUnitID, @MigrationID, @MigrationFlid
				END CATCH
			END;

		CLOSE ErrorLogCursor_update;
		DEALLOCATE ErrorLogCursor_update;	


		-- 4. Update stage tabele za 'id' i 'flid' iz temp_taxpayers tabele
		UPDATE stage.stg.stg_TaxPayers
		SET 
			ContributionPayerTypeID = tt.ContributionPayerTypeID,
			LinkID = tt.LinkID,
			CompanyID = tt.CompanyID, 
			TaxPayerType = tt.TaxPayerType, 
			CreatedIn = tt.CreatedIn, 
			CreatedOn = tt.CreatedOn, 
			CreatedBy = tt.CreatedBy, 
			ModifiedOn = tt.ModifiedOn,
			ModifiedBy = tt.ModifiedBy, 
			RegionalUnitID = tt.RegionalUnitID, 
			MigrationID = tt.MigrationID, 
			id = tt.id, 
			flid = tt.flid, 
			rnk = tt.rnk, 
			obv_jmbg = tt.obv_jmbg, 
			obv_pospar_tvrt = tt.obv_pospar_tvrt, 
			obv_pospar_obrt = tt.obv_pospar_obrt, 
			vrobv_id = tt.vrobv_id, 
			vrobv_sifra = tt.vrobv_sifra, 
			drnk = tt.drnk, 
			id_sljednik = tt.id_sljednik, 
			flid_sljednik = tt.flid_sljednik, 
			migrationFlid = tt.migrationFlid, 
			dssobv = tt.dssobv, 
			dpsobv = tt.dpsobv 
		FROM stage.stg.stg_TaxPayers taxp
			INNER JOIN temp_taxpayers tt ON tt.MigrationID = taxp.MigrationID AND tt.migrationFlid = taxp.migrationFlid


		 -- 5. update temp_taxpayers tabele - update sljednika za zapise koji se ne migriraju, sluzi za povezivanje osiguranja na obveznike
		update t1
		set 
			t1.id_sljednik = t2.id,
			t1.flid_sljednik = t2.flid
		from stage.stg.stg_TaxPayers t1
			join stage.stg.stg_TaxPayers t2 on t1.drnk = t2.drnk
		where t1.rnk >1 and t2.rnk = 1
			and t1.linkid is not null  and t1.drnk <> 99999999 ;


		-- update sljednika za bivsa tijela za vezu, to je sada HZZO
		update t1
		set 
			t1.id_sljednik = t2.id,
			t1.flid_sljednik = t2.flid
		from stage.stg.stg_TaxPayers t1
			join stage.stg.stg_TaxPayers t2 on t1.drnk = t2.drnk and t1.vrobv_id = t2.vrobv_id
		where t1.rnk >1 and t2.rnk = 1
			and t1.linkid is not null  and t1.drnk = 99999999 ;



		-- 6. update stage tabele za rnk i drnk
		update t1
		set rnk = tp.rnk, 
			drnk = tp.drnk
		FROM stage.stg.stg_TaxPayers t1
			LEFT JOIN (
				SELECT DISTINCT
					obvupl.id AS [id], 
					obvupl.flid AS [flid], 
					rank() over (partition by obvupl.vrobup_id, obvupl.idenos_jmbg_ide, companies1.sif_sljednik, companies2.sif_sljednik order by obvupl.devpri desc, obvupl.id desc ) AS [rnk], -- NOT NULL,
					dense_rank() over (order by obvupl.vrobup_id, obvupl.idenos_jmbg_ide, companies1.sif_sljednik,companies2.sif_sljednik ) AS [drnk]	

				FROM stage.zoroh.obvupl obvupl
					join stage.zoroh.vrobup vrobup on obvupl.vrobup_id = vrobup.id
					left join stage.stg.stg_Companies companies1 on obvupl.pospar_sif = companies1.pospar_sif  
					left join stage.stg.stg_Companies companies2 on obvupl.pospar_sif_v = companies2.pospar_sif	
				WHERE (obvupl.idenos_jmbg_ide IS NOT NULL OR obvupl.pospar_sif IS NOT NULL) 
					AND vrobup.sifra not in ('00016','00030')

				UNION

				SELECT
					obvupl.id AS [id], 
					obvupl.flid AS [flid], 
					2 AS [rnk], 
					99999999 AS [drnk]	
				FROM stage.zoroh.obvupl obvupl
					join stage.zoroh.vrobup vrobup on obvupl.vrobup_id = vrobup.id
					left join stage.stg.stg_Companies companies1 on obvupl.pospar_sif = companies1.pospar_sif  
					left join stage.stg.stg_Companies companies2 on obvupl.pospar_sif_v = companies2.pospar_sif	
				WHERE (obvupl.idenos_jmbg_ide IS NOT NULL OR obvupl.pospar_sif IS NOT NULL) 
					AND vrobup.sifra in ('00016','00030')
			) tp ON t1.id = tp.id AND t1.flid = tp.flid
	   	 WHERE tp.rnk is not null


		-- drop indexa
		DROP INDEX IF EXISTS IDX_obvupl_update_obvupl_id ON obvupl_update;
		DROP INDEX IF EXISTS IDX_obvupl_update_obvupl_flid ON obvupl_update;
		DROP INDEX IF EXISTS IDX_Companies_Code ON dbo.Companies;
		DROP INDEX IF EXISTS IDX_stg_Companies_pospar_sif ON stage.stg.stg_Companies;

		-- drop pomocnih tabela
		DROP TABLE obvupl_update;
		DROP TABLE temp_taxpayers;


	 -- kraj dela za update

	 /* Region Delete */

		-- 1. kreiram temp tabelu gde ce biti samo 'id' i 'flid' iz tabele elog_obvupl koje treba da se obrisu (al_a = 'D')
		IF object_id('obvupl_delete','U') IS NOT NULL
			DROP TABLE obvupl_delete;

		SELECT   [id] AS obvupl_id, 
				 [flid] AS obvupl_flid,
				 [vrijeme_ehzzo] AS valid_until
		INTO obvupl_delete
		FROM stage.zoroh.elog_obvupl
		WHERE al_a = 'D'
		GROUP BY [id], [flid], [vrijeme_ehzzo]


		-- ne radimo delete vec radimo update polja ValidUntil
		UPDATE TaxPayer.TaxPayers 
		SET ValidUntil = od.valid_until
		FROM TaxPayer.TaxPayers tptp
			INNER JOIN obvupl_delete od ON od.obvupl_id = tptp.MigrationID AND od.obvupl_flid = tptp.MigrationFlid


		/* **** Ako je netko prilikom inserta puknio na IX_Obvrznici.. **** */

			UPDATE tp
				SET
					tp.CreatedIn = tpe.CreatedIn,
					tp.RegionalUnitID = tpe.RegionalUnitID,
					tp.MigrationID = tpe.MigrationID,
					tp.MigrationFlid = tpe.MigrationFlid,
					tp.ModifiedOn = GETDATE()
				FROM TaxPayer.TaxPayers tp 
				JOIN errorTbls.TaxPayers_error_sync tpe ON tp.LinkID = tpe.LinkID AND tp.CompanyID = tpe.CompanyID
						AND tp.ContributionPayerTypeID = tpe.ContributionPayerTypeID AND tp.TaxPayerType = tpe.TaxPayerType

	---> History zapis hendla trigger

	---- obriši iz error tablice koje su dodati u prošlom koraku za CompanyID NOT NULL

		delete tpe 
		from errorTbls.TaxPayers_error_sync tpe
		join TaxPayer.TaxPayers tp ON tp.LinkID = tpe.LinkID AND tp.CompanyID = tpe.CompanyID
						AND tp.ContributionPayerTypeID = tpe.ContributionPayerTypeID AND tp.TaxPayerType = tpe.TaxPayerType


		UPDATE tp
		SET
			tp.CreatedIn = tpe.CreatedIn,
			tp.RegionalUnitID = tpe.RegionalUnitID,
			tp.MigrationID = tpe.MigrationID,
			tp.MigrationFlid = tpe.MigrationFlid,
			tp.ModifiedOn = GETDATE()
		FROM TaxPayer.TaxPayers tp 
		JOIN errorTbls.TaxPayers_error_sync tpe ON tp.LinkID = tpe.LinkID /*AND tp.CompanyID = tpe.CompanyID*/ 
				AND tp.ContributionPayerTypeID = tpe.ContributionPayerTypeID AND tp.TaxPayerType = tpe.TaxPayerType

	---> History zapis hendla trigger

	---- obriši iz error tablice koje su dodati u prošlom koraku za CompanyID IS NULL

		delete tpe 
		from errorTbls.TaxPayers_error_sync tpe
		join TaxPayer.TaxPayers tp ON tp.LinkID = tpe.LinkID /*AND tp.CompanyID = tpe.CompanyID*/ 
						AND tp.ContributionPayerTypeID = tpe.ContributionPayerTypeID AND tp.TaxPayerType = tpe.TaxPayerType



	END -- kraj dela za delete

GO


/*
===================================================
PROCEDURA ZA MedicalWorkers
===================================================
*/
CREATE OR ALTER PROCEDURE [dbo].[MedicalWorkerSync]
AS 
	BEGIN

		/****** 1. INSERT ZAPISA KOJI NISU JOŠ MedicalWorker.MedicalWorkers ********/

		DECLARE @PersonID INT, @MedicalWorkerTypeID INT, @MedicalWorkerZorohID INT;

		DECLARE ErrorLogCursor CURSOR FAST_FORWARD
		FOR
		SELECT DISTINCT
				P.PersonID,
				dbo.GetMedicalWorkerTypeID(z.tipzdje, z.strspr_id) AS MedicalWorkerTypeID,
				z.id AS MedicalWorkerZorohID
			FROM stage.zoroh.zdrdje AS z
			LEFT JOIN dbo.Persons AS P ON p.UniqueIdentificationNumber = z.idenos_jmbg
			LEFT JOIN MedicalWorker.MedicalWorkers AS mw ON mw.PersonID = P.PersonID
			WHERE mw.PersonID IS NULL  
				AND P.PersonID IS NOT NULL


		OPEN ErrorLogCursor;
		FETCH NEXT FROM ErrorLogCursor INTO @PersonID, @MedicalWorkerTypeID, @MedicalWorkerZorohID;

		WHILE @@FETCH_STATUS = 0
		BEGIN
			BEGIN TRY
				INSERT INTO MedicalWorker.MedicalWorkers(PersonID, MedicalWorkerTypeID, MedicalWorkerZorohID, CreatedBy, CreatedOn, ModifiedBy, ModifiedOn)
				VALUES (@PersonID, @MedicalWorkerTypeID, @MedicalWorkerZorohID, 'MIGRACIJA', GETDATE(), 'MIGRACIJA', GETDATE());
				
				FETCH NEXT FROM ErrorLogCursor INTO @PersonID, @MedicalWorkerTypeID, @MedicalWorkerZorohID;
			END TRY
			BEGIN CATCH
				INSERT INTO errorTbls.MedicalWorkers_error_sync
				(
					PersonID,
					MedicalWorkerTypeID,
					MedicalWorkerZorohID,
					errorMessage
				)
				VALUES
				(
					@PersonID,
					@MedicalWorkerTypeID,
					@MedicalWorkerZorohID,
					ERROR_MESSAGE()
				);

				FETCH NEXT FROM ErrorLogCursor INTO @PersonID, @MedicalWorkerTypeID, @MedicalWorkerZorohID;
			END CATCH
		END
		CLOSE ErrorLogCursor;
		DEALLOCATE ErrorLogCursor

		PRINT 'New MedicalWorkers Inserted';
			
	
		
		/****** 2. NAPRAVI UPDATE NA  MedicalWorker.MedicalWorkers TABLICU********/
		
			BEGIN TRY		
				ENABLE TRIGGER [AfterUpdate_MedicalWorkers] ON [MedicalWorker].[MedicalWorkers];
			END TRY
			BEGIN CATCH
				PRINT N'Trigger already enabled!'
			END CATCH;

			;WITH cte_update AS (
			SELECT DISTINCT
				P.PersonID,
				dbo.GetMedicalWorkerTypeID(z.tipzdje, z.strspr_id) AS 	MedicalWorkerTypeID,
				z.id AS MedicalWorkerZorohID
			FROM stage.zoroh.zdrdje AS z
			LEFT JOIN dbo.Persons AS P ON p.UniqueIdentificationNumber = z.idenos_jmbg
			JOIN MedicalWorker.MedicalWorkers AS mw ON mw.PersonID = P.PersonID
			WHERE mw.PersonID IS NOT NULL
			)
			UPDATE mw
			SET 
				mw.PersonID = cte.PersonID,
				mw.MedicalWorkerZorohID = cte.MedicalWorkerZorohID,
				mw.MedicalWorkerTypeID = cte.MedicalWorkerTypeID,
				mw.ModifiedOn = GETDATE()
			FROM MedicalWorker.MedicalWorkers mw
			JOIN cte_update cte ON mw.PersonID = cte.PersonID;
			PRINT 'New MedicalWorkers data updated'
		
			--- DISABLE TRIGGER [AfterUpdate_MedicalWorkers] ON [MedicalWorker].[MedicalWorkers];


		/* *** 2.1 INSERT U HISTORY TABLICU  *** */
		---TODO RJEŠAVA TRIGER!


		/* *** UPDATE  FAKSIMILA - zatvori neaktivan faksimil *** */
	
			UPDATE F
				SET 
					F.ValidTo = DATEADD(DAY, -1, GETDATE()),
					F.ModifiedOn = GETDATE()
			FROM MedicalWorker.Facsimiles F
			JOIN stage.zoroh.zdrdje z on z.matbr = f.Facsimile
			WHERE (z.idenos_jmbg = N'' or z.idenos_jmbg IS NULL) AND f.ValidTo IS NULL;
			PRINT 'Old Facsimiles closed!'
		

		/* *** UBACI NOVI AKTIVNI FAKSIMIL  *** */

		
			INSERT INTO MedicalWorker.Facsimiles (
				MedicalWorkerID,
				Facsimile,
				ValidFrom,
				MedicalWorkerZorohId
			)
			SELECT 
				P.PersonID,
				z.matbr,
				GETDATE() AS ValidFrom,
				z.id
			FROM stage.zoroh.zdrdje z
			JOIN dbo.Persons P ON p.UniqueIdentificationNumber = z.idenos_jmbg
			JOIN MedicalWorker.MedicalWorkers mw ON mw.PersonID = P.PersonID
			LEFT JOIN MedicalWorker.Facsimiles F ON F.MedicalWorkerID = mw.PersonID AND F.Facsimile = z.matbr
			WHERE F.FacsimileID IS NULL;
			PRINT 'New Facsimiles opened!'
			
		/* *** ŠTO AKO IMA JMBG KOJI NIJE U PERSONS? *** */
			
			INSERT INTO errorTbls.MedicalWorkers_error_sync
				(
					PersonID,
					MedicalWorkerTypeID,
					MedicalWorkerZorohID,
					zorohIdenosJmbg,
					errorMessage
				)
			SELECT DISTINCT
				P.PersonID,
				dbo.GetMedicalWorkerTypeID(z.tipzdje, z.strspr_id) AS MedicalWorkerTypeID,
				z.id AS MedicalWorkerZorohID,
				z.idenos_jmbg,
				'JMBG NOT FOUND IN dbo.Persons'
			FROM stage.zoroh.zdrdje AS z
			LEFT JOIN dbo.Persons AS P ON p.UniqueIdentificationNumber = z.idenos_jmbg
			LEFT JOIN MedicalWorker.MedicalWorkers AS mw ON mw.PersonID = P.PersonID
			WHERE z.idenos_jmbg <> '' 
				AND P.PersonID is null 
				AND mw.PersonID IS NULL;


END

GO


/*
========================================================
PROCEDURA ZA Insurance Sync
========================================================
*/

CREATE OR ALTER PROCEDURE [dbo].[InsurancesSync]
AS
		BEGIN

		BEGIN /* Region Insert */

			--================================
			-- INSERT za Insurance.Insurances tabelu kada ima promena u zoroh.osig tabeli
			--================================

			-- kreiram temp tabelu gde ce biti samo 'id' i 'flid' iz tabele elog_osig koje treba da se insertuju (al_a = 'I')
			IF object_id('insurance_insert','U') IS NOT NULL
				DROP TABLE insurance_insert;

			SELECT   [id] AS osig_id, 
					 [flid] AS osig_flid 
			INTO insurance_insert
			FROM stage.zoroh.elog_osig
			WHERE al_a = 'I' AND id IS NOT NULL
			GROUP BY [id], [flid]


			-- napuniti temp tabelu podacima koji treba da se insertuju samo za 'id' i 'flid' iz insurance_insert tabele
			DROP TABLE IF EXISTS pom_insurances;

			-- prvo punim pom_insurances
			--=====================================
			SELECT  
				osnos_sifra, rstat, katos, id, flid, obvupl_id_o, obvupl_flid_o, osig_strspr_id, idenos_jmbg, nositeljJmbg, srodstvo_sifra, nivoEdukacije, datZaprimanja, datStjecanjaPrava,
				datPocetkaOsig, datZavrsetkaOsig, radniSati, napomenaPrijava, napomenaOdjava, datKreiranja, osigMigrationId, osigMigrationFlid, obvupl_OrigMigrationId,
				obvupl_OrigMigrationFlid, obvupl_migrationId, obvupl_migrationFlid, drnk, devidodj
			INTO pom_insurances
			FROM (
				SELECT
					ltrim(rtrim(osig.osnos_sifra))							AS osnos_sifra,  
					osig.rstat												AS rstat, 
					trim(osig.katos)										AS katos, 
					osig.id													AS id, 
					trim(osig.flid)											AS flid, 
					osig.obvupl_id_o										AS obvupl_id_o,
					trim(osig.obvupl_flid_o)								AS obvupl_flid_o, 
					osig.strspr_id											AS osig_strspr_id,
					trim(osig.idenos_jmbg)									AS idenos_jmbg, 
					trim(osig.idenos_jmbg_n)								AS nositeljJmbg, 
					osig.vrsrod_sifra										AS srodstvo_sifra, 
					osig.strspr_id											AS nivoEdukacije, 
					ISNULL(osig.dzaprpri, osig.devidpri)					AS datZaprimanja, 
					ISNULL(ISNULL(osig.dsposig,osig.dssosig), getdate())	AS datStjecanjaPrava, 
					ISNULL(ISNULL(osig.dssosig,osig.dsposig), getdate())	AS datPocetkaOsig, 
					osig.dposig												AS datZavrsetkaOsig, 
					osig.sati												AS radniSati, 
					osig.ibrpri												AS napomenaPrijava, 
					osig.ibrodj												AS napomenaOdjava, 
					osig.devidpri											AS datKreiranja, 
					cast(osig.id as int)									AS osigMigrationId, 
					cast(osig.flid as int)									AS osigMigrationFlid, 
					osig.obvupl_id_o										AS obvupl_OrigMigrationId,
					osig.obvupl_flid_o										AS obvupl_OrigMigrationFlid,
					CAST(osig.obvupl_id_o AS INT)							AS obvupl_migrationId, 
					osig.obvupl_flid_o										AS obvupl_migrationFlid, 
					tp1.drnk												AS drnk,
					osig.devidodj											AS devidodj
				FROM stage.zoroh.osig osig
					INNER JOIN insurance_insert ii ON ii.osig_id = osig.id And ii.osig_flid = osig.flid
			--		left join stage.zoroh.osnos osnos ON osig.osnos_sifra = osnos.sifra 
					left join stage.stg.stg_TaxPayers tp1 ON osig.obvupl_id_o = tp1.id and osig.obvupl_flid_o = tp1.flid
				WHERE rstat = 'G' and tp1.rnk = 1

				UNION

				SELECT
					osig.osnos_sifra										AS osnos_sifra, --
					osig.rstat												AS rstat, 
					trim(osig.katos)										AS katos, --
					osig.id													AS id, 
					osig.flid												AS flid, --
					osig.obvupl_id_o										AS obvupl_id_o,
					osig.obvupl_flid_o										AS obvupl_flid_o, 
					osig.strspr_id											AS osig_strspr_id,
					trim(osig.idenos_jmbg)									AS idenos_jmbg, --
					trim(osig.idenos_jmbg_n)								AS nositeljJmbg, 
					osig.vrsrod_sifra										AS srodstvo_sifra, --
					osig.strspr_id											AS nivoEdukacije, --
					osig.dzaprpri											AS datZaprimanja, --
					osig.dssosig											AS datStjecanjaPrava, --
					osig.dsposig											AS datPocetkaOsig, --
					osig.dposig												AS datZavrsetkaOsig, --
					osig.sati												AS radniSati, --
					osig.ibrpri												AS napomenaPrijava, --
					osig.ibrodj												AS napomenaOdjava, --
					osig.devidpri											AS datKreiranja, --
					cast(osig.id as int)									AS osigMigrationId, --
					cast(osig.flid as int)									AS osigMigrationFlid, --
					osig.obvupl_id_o										AS obvupl_OrigMigrationId,
					osig.obvupl_flid_o										AS obvupl_OrigMigrationFlid,
					CAST(tp2.MigrationID AS INT)							AS obvupl_migrationId, --
					tp2.MigrationFlid										AS obvupl_migrationFlid, --
					tp1.drnk												AS drnk,
					osig.devidodj											AS devidodj
				FROM stage.zoroh.osig osig
					INNER JOIN insurance_insert ii ON ii.osig_id = osig.id And ii.osig_flid = osig.flid
			--		left join stage.zoroh.osnos osnos on osig.osnos_sifra = osnos.sifra  
					left join stage.stg.stg_TaxPayers tp1 on osig.obvupl_id_o = tp1.id and osig.obvupl_flid_o = tp1.flid
					left join stage.stg.stg_TaxPayers tp2 on tp1.drnk = tp2.drnk and tp2.rnk = 1 
					--left join zoroh.vrsrod vrsrod on osig.vrsrod_sifra = vrsrod.sifra  
				WHERE rstat = 'G' and tp1.rnk > 1
			) pomins


			--=======================================================
			-- punim Insurance.Insurances podacima iz pom_insurance
			--========================================================
			INSERT INTO Insurance.Insurances (
				[InsuranceTypeID], 
				[InsuranceCategoryID], 
				[TaxPayerID], 
				[PersonID], 
			--	[OwnerID], 
			--	[OwnerPersonID], 
				[InsuranceRelationID],
				[EducationLevelID], 
				[StartConventionRequestID], 
				[EndConventionRequestID], 
				[SubmissionDate], 
				[ContributionStartDate], 
				[StartDate], 
				[EndDate], 
				[WorkingHours], 
				[StartNote],
				[EndNote], 
				[CheckedOutOn], 
				[CreatedIn], 
				[CreatedOn], 
				[CreatedBy], 
				[ModifiedOn], 
				[ModifiedBy], 
				[MigrationID], 
				[MigrationFlid] 
			)
			SELECT DISTINCT
				it.InsuranceTypeID		AS [InsuranceTypeID],
				ic.InsuranceCategoryID	AS [InsuranceCategoryID], 
				tp.TaxPayerID			AS [TaxPayerID],
				p.PersonID				AS [PersonID], 
			--	AS [OwnerID], 
			--	AS [OwnerPersonID], 
				ir.InsuranceRelationID	AS [InsuranceRelationID], 
				el.EducationLevelID		AS [EducationLevelID], 
				NULL					AS [StartConventionRequestID],
				NULL					AS [EndConventionRequestID], 
				osig.datZaprimanja		AS [SubmissionDate], 
				osig.datStjecanjaPrava	AS [ContributionStartDate], 
				osig.datPocetkaOsig		AS [StartDate], 
				osig.datZavrsetkaOsig	AS [EndDate], 
				osig.radnisati			AS [WorkingHours], 
				osig.napomenaPrijava	AS [StartNote], 
				osig.napomenaOdjava		AS [EndNote], 
				osig.devidodj			AS [CheckedOutOn], 
				ru.RegionalUnitID		AS [CreatedIn], 
				COALESCE(osig.datKreiranja, GETDATE()) AS [CreatedOn], 
				'MIGRACIJA'				AS [CreatedBy], 
				GETDATE()				AS [ModifiedOn], 
				'MIGRACIJA'				AS [ModifiedBy], 
				osig.osigMigrationID	AS [MigrationID], 
				osig.osigMigrationFlid	AS [MigrationFlid] 
			FROM pom_insurances osig	
				LEFT JOIN Insurance.Insurances sit ON sit.MigrationID = osig.id
				LEFT JOIN Insurance.InsuranceTypes it ON osig.osnos_sifra = it.code
				LEFT JOIN Insurance.InsuranceCategories ic ON osig.katos = ic.code
				LEFT JOIN TaxPayer.TaxPayers tp ON tp.MigrationID = osig.obvupl_MigrationId AND tp.MigrationFLID = osig.obvupl_MigrationFlid
				LEFT JOIN dbo.Persons p ON p.UniqueIdentificationNumber = osig.idenos_jmbg
				LEFT JOIN Insurance.InsuranceRelations ir ON ir.code = osig.srodstvo_sifra
				LEFT JOIN dbo.EducationLevels el ON el.MigrationID = osig.nivoEdukacije
				LEFT JOIN dbo.RegionalUnits ru ON ru.MigrationID = osig.flid or ru.Code = osig.flid
			WHERE it.InsuranceTypeID IS NOT NULL
				AND ic.InsuranceCategoryID IS NOT NULL
				AND p.PersonId IS NOT NULL
				AND tp.TaxPayerID IS NOT NULL
				AND sit.MigrationID IS NULL


			-- punim errorTbls.Insurances_error_sync 
			INSERT INTO errorTbls.Insurances_error_sync ( 
				[InsuranceTypeID], 
				[InsuranceCategoryID], 
				[TaxPayerID], 
				[PersonID], 
				[InsuranceRelationID],
				[EducationLevelID], 
				[SubmissionDate], 
				[ContributionStartDate], 
				[StartDate], 
				[EndDate], 
				[WorkingHours], 
				[StartNote],
				[EndNote], 
				[CheckedOutOn], 
				[CreatedIn], 
				[CreatedOn], 
				[CreatedBy], 
				[ModifiedOn], 
				[ModifiedBy], 
				[MigrationID], 
				[MigrationFlid], 
				[errorDescription]
			)
			SELECT 
				it.InsuranceTypeID		AS [InsuranceTypeID], 
				ic.InsuranceCategoryID	AS [InsuranceCategoryID], 
				tp.TaxPayerID			AS [TaxPayerID], 
				p.PersonID				AS [PersonID], 
				ir.InsuranceRelationID	AS [InsuranceRelationID], 
				el.EducationLevelID		AS [EducationLevelID], 
				osig.datZaprimanja		AS [SubmissionDate], 
				osig.datStjecanjaPrava	AS [ContributionStartDate], 
				osig.datPocetkaOsig		AS [StartDate], 
				osig.datZavrsetkaOsig	AS [EndDate], 
				osig.radnisati			AS [WorkingHours], 
				osig.napomenaPrijava	AS [StartNote], 
				osig.napomenaOdjava		AS [EndNote], 
				osig.devidodj			AS [CheckedOutOn], 
				ru.RegionalUnitID		AS [CreatedIn], 
				COALESCE(osig.datKreiranja, GETDATE()) AS [CreatedOn], 
				'MIGRACIJA'				AS [CreatedBy], 
				GETDATE()				AS [ModifiedOn], 
				'MIGRACIJA'				AS [ModifiedBy], 
				osig.osigMigrationID	AS [MigrationID], 
				osig.osigMigrationFlid	AS [MigrationFlid], 
				CASE
					WHEN it.InsuranceTypeID IS NULL THEN 'osnos_sifra/code NOT FOUND '
					ELSE ''
				END + 
				CASE 
					WHEN ic.InsuranceCategoryID IS NULL THEN 'katos/code NOT FOUND '
					ELSE ''
				END + 
				CASE 
					WHEN p.PersonId IS NULL THEN 'PersonID NOT FOUND '
					ELSE ''
				END + 
				CASE
					WHEN tp.TaxPayerID IS NULL THEN 'TaxPayerID NOT FOUND '
					ELSE ''
				END AS errorDescription
			FROM pom_insurances osig	
				LEFT JOIN Insurance.Insurances sit ON sit.MigrationID = osig.id
				LEFT JOIN Insurance.InsuranceTypes it ON osig.osnos_sifra = it.code
				LEFT JOIN Insurance.InsuranceCategories ic ON osig.katos = ic.code
				LEFT JOIN TaxPayer.TaxPayers tp ON tp.MigrationID = osig.obvupl_MigrationId AND tp.MigrationFLID = osig.obvupl_MigrationFlid--LEFT JOIN TaxPayer.TaxPayers tp ON tp.MigrationID = osig.obvupl_MigrationId AND tp.MigrationFLID = osig.obvupl_MigrationFlid
				LEFT JOIN dbo.Persons p ON p.UniqueIdentificationNumber = osig.idenos_jmbg
				LEFT JOIN Insurance.InsuranceRelations ir ON ir.code = osig.srodstvo_sifra
				LEFT JOIN dbo.EducationLevels el ON el.MigrationID = osig.nivoEdukacije
				LEFT JOIN dbo.RegionalUnits ru ON ru.MigrationID = osig.flid or ru.Code = osig.flid
			WHERE NOT (it.InsuranceTypeID IS NOT NULL
				AND ic.InsuranceCategoryID IS NOT NULL
				AND p.PersonId IS NOT NULL
				AND tp.TaxPayerID IS NOT NULL)
				AND sit.MigrationID IS NULL


			--==========================
			-- update Insurance_owners
			--==========================

			UPDATE i_member
			SET OwnerID = i_owner.InsuranceID,
				OwnerPersonID = i_owner.PersonID
			FROM Insurance.Insurances i_owner
				INNER JOIN pom_insurances pins ON pins.id = i_owner.MigrationID AND pins.flid = i_owner.MigrationFlid
				join 
					(select stosig,  osig.osnos_sifra , osig.rstat,
						osig.id, osig.flid,
						osig.obvupl_id_o,osig.obvupl_flid_o, osig.strspr_id as osig_strspr_id,
						osig.idenos_jmbg as idenos_jmbg, 
						osig.osig_id_n as osig_nositelj,
						osig.osig_flid_n as osig_nositelj_flid,
						osig.id as osigMigrationId,
						osig.flid as osigMigrationFlid
					from stage.zoroh.osig osig
					where rstat = 'G' and stosig <> 'N'
					) o	on i_owner.MigrationID = o.osig_nositelj and i_owner.MigrationFlid = o.osig_nositelj_flid
				join Insurance.Insurances i_member on i_member.MigrationID = o.osigMigrationId and i_member.MigrationFlid = o.osigMigrationFlid


			--================================
			-- UPDATE Prijave Odjave
			--================================

			/* ***** UPDATE PRIJAVA *****  */
			UPDATE Insurance.Insurances
			SET CreatedBy = dt.ipuno
			FROM Insurance.Insurances i 
				INNER JOIN pom_insurances pins ON pins.id = i.MigrationID AND pins.flid = i.MigrationFlid
				JOIN stage.zoroh.datpos dt ON i.MigrationID = dt.osig_id and i.MigrationFlid = dt.osig_flid and i.ModifiedBy = 'MIGRACIJA'
				JOIN stage.stg.stg_InsurancePrijaveOdjave po on po.AkcijaOpis = dt.akcija
			WHERE po.Tip = 'P'


			/* ***** UPDATE ODJAVE *****  */
			UPDATE Insurance.Insurances
			SET CheckedOutBy = dt.ipuno
			FROM Insurance.Insurances i 
				INNER JOIN pom_insurances pins ON pins.id = i.MigrationID AND pins.flid = i.MigrationFlid
				JOIN stage.zoroh.datpos dt ON i.MigrationID = dt.osig_id and i.MigrationFlid = dt.osig_flid and i.ModifiedBy = 'MIGRACIJA'
				JOIN stage.stg.stg_InsurancePrijaveOdjave po on po.AkcijaOpis = dt.akcija
			WHERE po.Tip = 'O'


			-- drop pomocnih tabela
			DROP TABLE insurance_insert;
			DROP TABLE pom_insurances;

		END


		BEGIN /* Region Update */
			--================================
			-- UPDATE za Insurance.Insurances tabelu kada ima promena u zoroh.osig tabeli
			--================================

			-- kreiram temp tabelu gde ce biti samo 'id' i 'flid' iz tabele elog_osig koje treba da se updateuju (al_a = 'U')
			IF object_id('insurance_update','U') IS NOT NULL
				DROP TABLE insurance_update;

			SELECT   [id] AS osig_id, 
					 [flid] AS osig_flid 
			INTO insurance_update
			FROM stage.zoroh.elog_osig
			WHERE al_a = 'U' AND id IS NOT NULL
			GROUP BY [id], [flid]



			-- napuniti temp tabelu podacima koji treba da se updateuju samo za 'id' i 'flid' iz insurance_update tabele
			DROP TABLE IF EXISTS pom_insurances;

			-- prvo punim pom_insurances
			SELECT  
				osnos_sifra, rstat, katos, id, flid,obvupl_id_o,obvupl_flid_o, osig_strspr_id,idenos_jmbg,nositeljJmbg,srodstvo_sifra,nivoEdukacije, datZaprimanja, datStjecanjaPrava,
				datPocetkaOsig,datZavrsetkaOsig,radniSati,napomenaPrijava,napomenaOdjava,datKreiranja, osigMigrationId,osigMigrationFlid,obvupl_OrigMigrationId,
				obvupl_OrigMigrationFlid,obvupl_migrationId,obvupl_migrationFlid,drnk, devidodj
			INTO pom_insurances
			FROM (
				SELECT 
					ltrim(rtrim(osig.osnos_sifra))							AS osnos_sifra,  
					osig.rstat												AS rstat, 
					trim(osig.katos)										AS katos, 
					osig.id													AS id, 
					trim(osig.flid)											AS flid, 
					osig.obvupl_id_o										AS obvupl_id_o,
					trim(osig.obvupl_flid_o)								AS obvupl_flid_o, 
					osig.strspr_id											AS osig_strspr_id,
					trim(osig.idenos_jmbg)									AS idenos_jmbg, 
					trim(osig.idenos_jmbg_n)								AS nositeljJmbg, 
					osig.vrsrod_sifra										AS srodstvo_sifra, 
					osig.strspr_id											AS nivoEdukacije, 
					ISNULL(osig.dzaprpri, osig.devidpri)					AS datZaprimanja, 
					ISNULL(ISNULL(osig.dsposig,osig.dssosig), getdate())	AS datStjecanjaPrava, 
					ISNULL(ISNULL(osig.dssosig,osig.dsposig), getdate())	AS datPocetkaOsig, 
					osig.dposig												AS datZavrsetkaOsig, 
					osig.sati												AS radniSati, 
					osig.ibrpri												AS napomenaPrijava, 
					osig.ibrodj												AS napomenaOdjava, 
					osig.devidpri											AS datKreiranja, 
					cast(osig.id as int)									AS osigMigrationId, 
					cast(osig.flid as int)									AS osigMigrationFlid, 
					osig.obvupl_id_o										AS obvupl_OrigMigrationId,
					osig.obvupl_flid_o										AS obvupl_OrigMigrationFlid,
					CAST(osig.obvupl_id_o AS INT)							AS obvupl_migrationId, 
					osig.obvupl_flid_o										AS obvupl_migrationFlid, 
					tp1.drnk												AS drnk,
					osig.devidodj											AS devidodj
				FROM stage.zoroh.osig osig
					INNER JOIN insurance_update ii ON ii.osig_id = osig.id And ii.osig_flid = osig.flid
			--		left join stage.zoroh.osnos osnos ON osig.osnos_sifra = osnos.sifra 
					left join stage.stg.stg_TaxPayers tp1 ON osig.obvupl_id_o = tp1.id and osig.obvupl_flid_o = tp1.flid
				WHERE rstat = 'G' and tp1.rnk = 1

				UNION

				SELECT 
					osig.osnos_sifra										AS osnos_sifra, 
					osig.rstat												AS rstat, 
					trim(osig.katos)										AS katos, 
					osig.id													AS id, 
					osig.flid												AS flid, 
					osig.obvupl_id_o										AS obvupl_id_o,
					osig.obvupl_flid_o										AS obvupl_flid_o, 
					osig.strspr_id											AS osig_strspr_id,
					trim(osig.idenos_jmbg)									AS idenos_jmbg, 
					trim(osig.idenos_jmbg_n)								AS nositeljJmbg, 
					osig.vrsrod_sifra										AS srodstvo_sifra, 
					osig.strspr_id											AS nivoEdukacije, 
					osig.dzaprpri											AS datZaprimanja, 
					osig.dssosig											AS datStjecanjaPrava, 
					osig.dsposig											AS datPocetkaOsig, 
					osig.dposig												AS datZavrsetkaOsig, 
					osig.sati												AS radniSati, 
					osig.ibrpri												AS napomenaPrijava, 
					osig.ibrodj												AS napomenaOdjava, 
					osig.devidpri											AS datKreiranja, 
					cast(osig.id as int)									AS osigMigrationId, 
					cast(osig.flid as int)									AS osigMigrationFlid, 
					osig.obvupl_id_o										AS obvupl_OrigMigrationId,
					osig.obvupl_flid_o										AS obvupl_OrigMigrationFlid,
					CAST(tp2.MigrationID AS INT)							AS obvupl_migrationId, 
					tp2.MigrationFlid										AS obvupl_migrationFlid, 
					tp1.drnk												AS drnk,
					osig.devidodj											AS devidodj
				FROM stage.zoroh.osig osig
					INNER JOIN insurance_update ii ON ii.osig_id = osig.id And ii.osig_flid = osig.flid
				--	left join stage.zoroh.osnos osnos on osig.osnos_sifra = osnos.sifra  
					left join stage.stg.stg_TaxPayers tp1 on osig.obvupl_id_o = tp1.id and osig.obvupl_flid_o = tp1.flid
					left join stage.stg.stg_TaxPayers tp2 on tp1.drnk = tp2.drnk and tp2.rnk = 1
					--left join zoroh.vrsrod vrsrod on osig.vrsrod_sifra = vrsrod.sifra  
				WHERE rstat = 'G' and tp1.rnk > 1
			) pomins



			--===============================================================================
			-- Update Insurance.Insurances tabele za 'id' i 'flid' iz pom_insurances tabele
			--===============================================================================
			UPDATE Insurance.Insurances
			SET 
				InsuranceTypeID = it.InsuranceTypeID,	
				InsuranceCategoryID = ic.InsuranceCategoryID,
				TaxPayerID = tp.TaxPayerID,		
				PersonID = p.PersonID,	
				InsuranceRelationID = ir.InsuranceRelationID,
				EducationLevelID = el.EducationLevelID,		
				SubmissionDate = osig.datZaprimanja,		
				ContributionStartDate = osig.datStjecanjaPrava,	
				StartDate = osig.datPocetkaOsig,
				EndDate = osig.datZavrsetkaOsig,	
				WorkingHours = osig.radnisati,	
				StartNote = osig.napomenaPrijava,
				EndNote = osig.napomenaOdjava,	
				CheckedOutOn = osig.devidodj,	
				CreatedIn = ru.RegionalUnitID,	
				CreatedOn = COALESCE(osig.datKreiranja, GETDATE()), 
				CreatedBy = 'MIGRACIJA',	
				ModifiedOn = GETDATE(),	
				ModifiedBy = 'MIGRACIJA',	
				MigrationID = osig.osigMigrationID,
				MigrationFlid = osig.osigMigrationFlid	

			FROM Insurance.Insurances stgins
				INNER JOIN pom_insurances osig ON osig.osigMigrationId = stgins.MigrationID AND osig.osigMigrationFlid = stgins.MigrationFlid
				LEFT JOIN Insurance.InsuranceTypes it ON osig.osnos_sifra = it.code
				LEFT JOIN Insurance.InsuranceCategories ic ON osig.katos = ic.code
				LEFT JOIN TaxPayer.TaxPayers tp ON tp.MigrationID = osig.obvupl_MigrationId AND tp.MigrationFLID = osig.obvupl_MigrationFlid
				LEFT JOIN dbo.Persons p ON p.UniqueIdentificationNumber = osig.idenos_jmbg
				LEFT JOIN Insurance.InsuranceRelations ir ON ir.code = osig.srodstvo_sifra
				LEFT JOIN dbo.EducationLevels el ON el.MigrationID = osig.nivoEdukacije
				LEFT JOIN dbo.RegionalUnits ru ON ru.MigrationID = osig.flid or ru.Code = osig.flid

			WHERE it.InsuranceTypeID IS NOT NULL
				AND ic.InsuranceCategoryID IS NOT NULL
				AND p.PersonId IS NOT NULL
				AND tp.TaxPayerID IS NOT NULL


			-- ===========================================
			-- Kako dođe netko za update tko nije u eHZZO
			-- ==========================================

			INSERT INTO Insurance.Insurances ( 
				[InsuranceTypeID], 
				[InsuranceCategoryID], 
				[TaxPayerID], 
				[PersonID], 
				[InsuranceRelationID],
				[EducationLevelID], 
				[SubmissionDate], 
				[ContributionStartDate], 
				[StartDate], 
				[EndDate], 
				[WorkingHours], 
				[StartNote],
				[EndNote], 
				[CheckedOutOn], 
				[CreatedIn], 
				[CreatedOn], 
				[CreatedBy], 
				[ModifiedOn], 
				[ModifiedBy], 
				[MigrationID], 
				[MigrationFlid]
			)
			SELECT 
				it.InsuranceTypeID		AS [InsuranceTypeID], 
				ic.InsuranceCategoryID	AS [InsuranceCategoryID], 
				tp.TaxPayerID			AS [TaxPayerID], 
				p.PersonID				AS [PersonID], 
				ir.InsuranceRelationID	AS [InsuranceRelationID], 
				el.EducationLevelID		AS [EducationLevelID], 
				osig.datZaprimanja		AS [SubmissionDate], 
				osig.datStjecanjaPrava	AS [ContributionStartDate], 
				osig.datPocetkaOsig		AS [StartDate], 
				osig.datZavrsetkaOsig	AS [EndDate], 
				osig.radnisati			AS [WorkingHours], 
				osig.napomenaPrijava	AS [StartNote], 
				osig.napomenaOdjava		AS [EndNote], 
				osig.devidodj			AS [CheckedOutOn], 
				ru.RegionalUnitID		AS [CreatedIn], 
				COALESCE(osig.datKreiranja, GETDATE()) AS [CreatedOn], 
				'MIGRACIJA'				AS [CreatedBy], 
				GETDATE()				AS [ModifiedOn], 
				'MIGRACIJA'				AS [ModifiedBy], 
				osig.osigMigrationID	AS [MigrationID], 
				osig.osigMigrationFlid	AS [MigrationFlid]
			FROM  pom_insurances osig 
			LEFT JOIN Insurance.Insurances stgins ON osig.osigMigrationId = stgins.MigrationID AND osig.osigMigrationFlid = stgins.MigrationFlid
			LEFT JOIN Insurance.InsuranceTypes it ON osig.osnos_sifra = it.code
			LEFT JOIN Insurance.InsuranceCategories ic ON osig.katos = ic.code
			LEFT JOIN TaxPayer.TaxPayers tp ON tp.MigrationID = osig.obvupl_MigrationId AND tp.MigrationFLID = osig.obvupl_MigrationFlid
			LEFT JOIN dbo.Persons p ON p.UniqueIdentificationNumber = osig.idenos_jmbg
			LEFT JOIN Insurance.InsuranceRelations ir ON ir.code = osig.srodstvo_sifra
			LEFT JOIN dbo.EducationLevels el ON el.MigrationID = osig.nivoEdukacije
			LEFT JOIN dbo.RegionalUnits ru ON ru.MigrationID = osig.flid or ru.Code = osig.flid
			WHERE stgins.MigrationID IS NULL AND stgins.MigrationFlid IS NULL
			AND it.InsuranceTypeID IS NOT NULL
				AND ic.InsuranceCategoryID IS NOT NULL
				AND p.PersonId IS NOT NULL
				AND tp.TaxPayerID IS NOT NULL
				---AND sit.MigrationID IS NULL

			-----
			--Ako je netko dosao kao update, a treba insert ali nedostaju neki podaci 
			----
			INSERT INTO errorTbls.Insurances_error_sync ( 
				[InsuranceTypeID], 
				[InsuranceCategoryID], 
				[TaxPayerID], 
				[PersonID], 
				[InsuranceRelationID],
				[EducationLevelID], 
				[SubmissionDate], 
				[ContributionStartDate], 
				[StartDate], 
				[EndDate], 
				[WorkingHours], 
				[StartNote],
				[EndNote], 
				[CheckedOutOn], 
				[CreatedIn], 
				[CreatedOn], 
				[CreatedBy], 
				[ModifiedOn], 
				[ModifiedBy], 
				[MigrationID], 
				[MigrationFlid],
				[errorDEscription]
			)
			SELECT 
				it.InsuranceTypeID		AS [InsuranceTypeID], 
				ic.InsuranceCategoryID	AS [InsuranceCategoryID], 
				tp.TaxPayerID			AS [TaxPayerID], 
				p.PersonID				AS [PersonID], 
				ir.InsuranceRelationID	AS [InsuranceRelationID], 
				el.EducationLevelID		AS [EducationLevelID], 
				osig.datZaprimanja		AS [SubmissionDate], 
				osig.datStjecanjaPrava	AS [ContributionStartDate], 
				osig.datPocetkaOsig		AS [StartDate], 
				osig.datZavrsetkaOsig	AS [EndDate], 
				osig.radnisati			AS [WorkingHours], 
				osig.napomenaPrijava	AS [StartNote], 
				osig.napomenaOdjava		AS [EndNote], 
				osig.devidodj			AS [CheckedOutOn], 
				ru.RegionalUnitID		AS [CreatedIn], 
				COALESCE(osig.datKreiranja, GETDATE()) AS [CreatedOn], 
				'MIGRACIJA'				AS [CreatedBy], 
				GETDATE()				AS [ModifiedOn], 
				'MIGRACIJA'				AS [ModifiedBy], 
				osig.osigMigrationID	AS [MigrationID], 
				osig.osigMigrationFlid	AS [MigrationFlid], 
				CASE
					WHEN it.InsuranceTypeID IS NULL THEN 'osnos_sifra/code NOT FOUND '
					ELSE ''
				END + 
				CASE 
					WHEN ic.InsuranceCategoryID IS NULL THEN 'katos/code NOT FOUND '
					ELSE ''
				END + 
				CASE 
					WHEN p.PersonId IS NULL THEN 'PersonID NOT FOUND '
					ELSE ''
				END + 
				CASE
					WHEN tp.TaxPayerID IS NULL THEN 'TaxPayerID NOT FOUND '
					ELSE ''
				END AS errorDescription
			FROM  pom_insurances osig 
			LEFT JOIN Insurance.Insurances stgins ON osig.osigMigrationId = stgins.MigrationID AND osig.osigMigrationFlid = stgins.MigrationFlid
			LEFT JOIN Insurance.InsuranceTypes it ON osig.osnos_sifra = it.code
			LEFT JOIN Insurance.InsuranceCategories ic ON osig.katos = ic.code
			LEFT JOIN TaxPayer.TaxPayers tp ON tp.MigrationID = osig.obvupl_MigrationId AND tp.MigrationFLID = osig.obvupl_MigrationFlid
			LEFT JOIN dbo.Persons p ON p.UniqueIdentificationNumber = osig.idenos_jmbg
			LEFT JOIN Insurance.InsuranceRelations ir ON ir.code = osig.srodstvo_sifra
			LEFT JOIN dbo.EducationLevels el ON el.MigrationID = osig.nivoEdukacije
			LEFT JOIN dbo.RegionalUnits ru ON ru.MigrationID = osig.flid or ru.Code = osig.flid
			WHERE stgins.MigrationID IS NULL AND stgins.MigrationFlid IS NULL
			AND it.InsuranceTypeID IS NOT NULL
				AND ic.InsuranceCategoryID IS NOT NULL
				AND p.PersonId IS NOT NULL
				AND tp.TaxPayerID IS NOT NULL
				---AND sit.MigrationID IS NULL



			--==========================
			-- update Insurance_owners
			--==========================

			update i_member
			set OwnerID = i_owner.InsuranceID,
				OwnerPersonID = i_owner.PersonID
			from Insurance.Insurances i_owner
				INNER JOIN pom_insurances pins ON pins.id = i_owner.MigrationID AND pins.flid = i_owner.MigrationFlid
				join 
					(select stosig,  osig.osnos_sifra , osig.rstat,
						osig.id, osig.flid,
						osig.obvupl_id_o,osig.obvupl_flid_o, osig.strspr_id as osig_strspr_id,
						osig.idenos_jmbg as idenos_jmbg, 
						osig.osig_id_n as osig_nositelj,
						osig.osig_flid_n as osig_nositelj_flid,
						osig.id as osigMigrationId,
						osig.flid as osigMigrationFlid
					from stage.zoroh.osig osig
					where rstat = 'G'
						and stosig <> 'N'
					) o	on i_owner.MigrationID = o.osig_nositelj and i_owner.MigrationFlid = o.osig_nositelj_flid
				join Insurance.Insurances i_member on i_member.MigrationID = o.osigMigrationId and i_member.MigrationFlid = o.osigMigrationFlid


			--================================
			-- UPDATE Prijave Odjave
			--================================

			/* ***** UPDATE PRIJAVA *****  */
			UPDATE Insurance.Insurances
			SET CreatedBy = dt.ipuno
			FROM Insurance.Insurances i 
				INNER JOIN pom_insurances pins ON pins.id = i.MigrationID AND pins.flid = i.MigrationFlid
				JOIN stage.zoroh.datpos dt ON i.MigrationID = dt.osig_id and i.MigrationFlid = dt.osig_flid and i.ModifiedBy = 'MIGRACIJA'
				JOIN stage.stg.stg_InsurancePrijaveOdjave po on po.AkcijaOpis = dt.akcija
			WHERE po.Tip = 'P'

			/* ***** UPDATE ODJAVE *****  */
			UPDATE Insurance.Insurances
			SET CheckedOutBy = dt.ipuno
			FROM Insurance.Insurances i 
				INNER JOIN pom_insurances pins ON pins.id = i.MigrationID AND pins.flid = i.MigrationFlid
				JOIN stage.zoroh.datpos dt ON i.MigrationID = dt.osig_id and i.MigrationFlid = dt.osig_flid and i.ModifiedBy = 'MIGRACIJA'
				JOIN stage.stg.stg_InsurancePrijaveOdjave po on po.AkcijaOpis = dt.akcija
			WHERE po.Tip = 'O'


			-- drop pomocnih tabela
			DROP TABLE insurance_update;
			DROP TABLE pom_insurances;

		END


		BEGIN /* Region Delete*/

			--===============
			-- DELETE za Insurance.Insurances tabelu kada ima promena u zoroh.osig tabeli
			--===============

			-- 1. kreiram temp tabelu gde ce biti samo 'id' i 'flid' iz tabele elog_osig koje treba da se obrisu (al_a = 'D')
			IF object_id('insurance_delete','U') IS NOT NULL
				DROP TABLE insurance_delete;

			SELECT   [id] AS obvupl_id, 
					 [flid] AS obvupl_flid,
					 [vrijeme_ehzzo] AS valid_until
			INTO insurance_delete
			FROM stage.zoroh.elog_osig
			WHERE al_a = 'D' AND id IS NOT NULL
			GROUP BY [id], [flid], [vrijeme_ehzzo]

			-- ne radimo delete vec radimo update polja ValidUntil
			UPDATE Insurance.Insurances
			SET ValidUntil = ind.valid_until
			FROM Insurance.Insurances insdel
				INNER JOIN insurance_delete ind ON ind.obvupl_id = insdel.MigrationID AND ind.obvupl_flid = insdel.MigrationFlid


			-- drop pomocnih tabela
			DROP TABLE insurance_delete;

		END

	END
GO



/*
========================================
PROCEDURA ZA ContractsSync
========================================
*/

CREATE OR ALTER PROCEDURE [dbo].[ConcratsSync]
AS
BEGIN
	if object_id('tempdb..#tmpContractsNewData') is not null
	drop table #tmpContractsNewData

if object_id('tempdb..#tmpContractNewSum') is not null
	drop table #tmpContractNewSum

if object_id('tempdb..#tmpContractOldSum') is not null
	drop table #tmpContractOldSum


;WITH ugv_data AS (
SELECT
    broj,
    flid,
    brdod,
    tip,
    min(potpis) OVER(PARTITION BY broj, flid) AS potpis,
    min(primjena) OVER(PARTITION BY broj, flid) AS primjena,
    status,
    ulakt_urubro,
    predmet_klozna,
    -- FIXME: There should not be open-ended Contracts. Include Instituion Closure Date in calculation.
    COALESCE(max(datdo) OVER(PARTITION BY broj,
    flid),
    DATEADD(YEAR, DATEDIFF(YEAR, 0, max(primjena) OVER(PARTITION BY broj, flid)) + 1, -1)) AS datdo,
    specka,
    vrugo,
    davzu_sif,
    djelzz_id,
    DENSE_RANK() OVER(PARTITION BY broj,
    flid
ORDER BY
    brdod ASC) AS rnk_no
FROM
    stage.zoroh.ugdzu),
ugv_djl_data AS (
SELECT
    DISTINCT ugdzu.broj,
    ugdzu.flid,
    ugdzu.djelzz_id
FROM
    stage.zoroh.ugdzu ugdzu
UNION
SELECT
    DISTINCT djugbol.ugdzu_broj,
    djugbol.ugdzu_flid,
    djugbol.djelzz_id
FROM
    stage.zoroh.djugbol djugbol
UNION
SELECT
    DISTINCT ugdzhsr.ugdzu_broj,
    ugdzhsr.ugdzu_flid,
    ugdzhsr.djelzz_id
FROM
    stage.zoroh.ugdzhsr ugdzhsr
UNION
SELECT
    DISTINCT ugdzsgl.ugdzu_broj,
    ugdzsgl.ugdzu_flid,
    ugdzsgl.djelzz_id
FROM
    stage.zoroh.ugdzsgl ugdzsgl
UNION
SELECT
    DISTINCT ugdzshi.ugdzu_broj,
    ugdzshi.ugdzu_flid,
    ugdzshi.djelzz_id
FROM
    stage.zoroh.ugdzshi ugdzshi
UNION
SELECT
    DISTINCT ugprim.ugdzu_broj,
    ugprim.ugdzu_flid,
    ugprim.djelzz_id
FROM
    stage.zoroh.ugprim ugprim),
ugv_djl_cnt_data AS (
SELECT
    *,
    count(*) OVER(PARTITION BY broj,
    flid) AS cnt
FROM
    ugv_djl_data
WHERE
    djelzz_id IS NOT NULL),
epnd_data AS (
SELECT
    prnt.id AS broj,
    prnt.id AS broj_rt,
    0 AS flid,
    0 AS brdod,
    LOWER(prnt.tipust) AS tip,
    prnt.datprih AS potpis,
    COALESCE(prnt.datugo,
    prnt.datprih,
    prnt.datpri,
    prnt.datsort) AS primjena,
    prnt.ugostat AS status,
    CAST(NULL AS nvarchar(15)) AS ulakt_urubro,
    CAST(NULL AS nvarchar(25)) AS predmet_klozna,
    -- Not all annexed Contracts have End Date (Modify Date) so try to figure out when the first child started.
    CASE
        prnt.ugostat WHEN 'I' THEN COALESCE(prnt.datprom,
        chld.datugo,
        chld.datprih,
        chld.datpri,
        chld.datsort)
        ELSE DATEADD(YEAR, DATEDIFF(YEAR, 0, COALESCE(prnt.datugo, prnt.datprih, prnt.datpri, prnt.datsort)) + 1, -1)
    END AS datdo,
    NULL AS specka,
    CAST(NULL AS nvarchar(1)) AS vrugo,
    prnt.davzu_sif AS davzu_sif
FROM
    stage.zoroh.eponudesb prnt
LEFT OUTER JOIN stage.zoroh.eponudesb chld ON
    prnt.id = chld.izvponid
    AND prnt.ugostat = 'I'
WHERE
    -- Root ePonuda records (Contracts).
    prnt.izvponid IS NULL
UNION ALL
SELECT
    chld.id AS broj,
    prnt.broj_rt AS broj_rt,
    0 AS flid,
    0 AS brdod,
    LOWER(chld.tipust) AS tip,
    chld.datprih AS potpis,
    COALESCE(chld.datugo,
    chld.datprih,
    chld.datpri,
    chld.datsort) AS primjena,
    chld.ugostat AS status,
    CAST(NULL AS nvarchar(15)) AS ulakt_urubro,
    CAST(NULL AS nvarchar(25)) AS predmet_klozna,
    -- Not all annexed Contracts have End Date (Modify Date) so try to figure out when the first child started.
    CASE
        chld.ugostat WHEN 'I' THEN COALESCE(chld.datprom,
        chld.datugo,
        chld.datprih,
        chld.datpri,
        chld.datsort)
        ELSE DATEADD(YEAR, DATEDIFF(YEAR, 0, COALESCE(chld.datugo, chld.datprih, chld.datpri, chld.datsort)) + 1, -1)
    END AS datdo,
    NULL AS specka,
    CAST(NULL AS nvarchar(1)) AS vrugo,
    chld.davzu_sif AS davzu_sif
FROM
    stage.zoroh.eponudesb chld
INNER JOIN epnd_data prnt ON
    chld.izvponid = prnt.broj),
epnd_djl_data AS (
SELECT
    DISTINCT epnd.broj_rt,
    rdl.djelzz_id
FROM
    epnd_data epnd
INNER JOIN stage.zoroh.radiliste rdl ON
    epnd.broj = rdl.eponudesb_id),
epnd_djl_cnt_data AS (
SELECT
    broj_rt,
    djelzz_id,
    count(*) OVER(PARTITION BY broj_rt) AS cnt
FROM
    epnd_djl_data),
cntr_data AS (
SELECT
    ugv.broj,
    ugv.flid,
    ugv.brdod,
    ugv.tip,
    ugv.potpis,
    ugv.primjena,
    ugv.status,
    ugv.ulakt_urubro,
    ugv.predmet_klozna,
    ugv.datdo,
    ugv.specka,
    ugv.vrugo,
    ugv.davzu_sif,
    ugv_djl_cnt.djelzz_id,
    concat(CASE WHEN (ugv.tip = 'O' AND ugv.primjena < CAST('2012-03-01' AS date)) OR ugv.primjena < CAST('2007-01-01' AS date) THEN 'ACTV_FRM_OOS;' END, CASE WHEN ugv.datdo IS NULL THEN 'ACTV_TO_NULL;' END) AS dm_vldtn_rslt
FROM
    ugv_data ugv
LEFT OUTER JOIN ugv_djl_cnt_data ugv_djl_cnt ON
    ugv.broj = ugv_djl_cnt.broj
    AND ugv.flid = ugv_djl_cnt.flid
    AND ugv_djl_cnt.cnt = 1
WHERE
    ((ugv.tip != 'O'
        AND ugv.primjena >= CAST('2007-01-01' AS date))
    -- Shortcut, I know.
        OR ugv.primjena >= CAST('2012-03-01' AS date))
        AND ugv.rnk_no = 1
UNION ALL
SELECT
    epnd.broj,
    epnd.flid,
    epnd.brdod,
    epnd.tip,
    epnd.potpis,
    epnd.primjena,
    epnd.status,
    epnd.ulakt_urubro,
    epnd.predmet_klozna,
    epnd.datdo,
    epnd.specka,
    epnd.vrugo,
    epnd.davzu_sif,
    epnd_djl_cnt.djelzz_id,
    concat(CASE WHEN epnd.primjena < CAST('2007-01-01' AS date) THEN 'ACTV_FRM_OOS;' END, CASE WHEN epnd.datdo IS NULL THEN 'ACTV_TO_NULL;' END) AS dm_vldtn_rslt
FROM
    epnd_data epnd
LEFT OUTER JOIN epnd_djl_cnt_data epnd_djl_cnt ON
    epnd.broj = epnd_djl_cnt.broj_rt
    AND epnd_djl_cnt.cnt = 1
WHERE
    epnd.brdod = 0),
lctn_data AS (
SELECT
    DISTINCT lctn.Code AS UnitCode,
    lctn.HealthcareInstitutionID,
    hinst.HealthcareInstitutionTypeID
FROM
    MedicalWorker.Locations lctn
INNER JOIN MedicalWorker.HealthcareInstitutions hinst ON
    lctn.HealthcareInstitutionID = hinst.HealthcareInstitutionID),
hst_data AS (
SELECT
    hiuhst.UnitCode UnitCode,
    hiunt.CompanyID AS HealthcareInstitutionID,
    hiuhst.HealthcareInstitutionTypeID
FROM
    MedicalWorker.HealthcareInstitutionUnits hiunt
INNER JOIN MedicalWorker.HealthcareInstitutionUnitsHistory hiuhst ON
    hiunt.HealthcareInstitutionUnitID = hiuhst.HealthcareInstitutionUnitID
LEFT OUTER JOIN MedicalWorker.HealthcareInstitutionUnits iunt_lkp ON
    hiuhst.UnitCode = iunt_lkp.UnitCode
WHERE
    iunt_lkp.UnitCode IS NULL),
unt_data AS (
SELECT
    UnitCode AS UnitCode,
    CompanyID AS HealthcareInstitutionID,
    HealthcareInstitutionTypeID,
    HealthcareInstitutionUnitTypeID,
    0 AS typ
FROM
    MedicalWorker.HealthcareInstitutionUnits
UNION
SELECT
    UnitCode,
    HealthcareInstitutionID,
    HealthcareInstitutionTypeID,
    NULL AS HealthcareInstitutionUnitTypeID,
    1 AS typ
FROM
    lctn_data
UNION
SELECT
    UnitCode,
    HealthcareInstitutionID,
    HealthcareInstitutionTypeID,
    NULL AS HealthcareInstitutionUnitTypeID,
    2 AS typ
FROM
    hst_data),
enrch_data AS (
SELECT
    NULL AS ProposalID,
    CASE
        -- FIXME: There should be no invalid values here.
        WHEN cntr.djelzz_id = 123 THEN 11
        WHEN cntr.djelzz_id = 124 THEN 13
        WHEN cntr.djelzz_id = 128 THEN 4
        WHEN cntr.djelzz_id = 129 THEN 3
        WHEN cntr.djelzz_id = 131 THEN 2
        WHEN cntr.djelzz_id = 132 THEN 1
        WHEN cntr.djelzz_id = 144 THEN 8
        -- WHEN cntr.djelzz_id = 162 THEN 1 -- Removed as tip != P cannot be Contract Type ID 1
        WHEN cntr.djelzz_id = 168 THEN 4
        WHEN cntr.djelzz_id = 172 THEN 10
        WHEN cntr.djelzz_id = 254 THEN 21
        WHEN cntr.djelzz_id = 271 THEN 4
        WHEN cntr.djelzz_id = 274 THEN 4
        WHEN cntr.djelzz_id = 285 THEN 18
        WHEN cntr.djelzz_id = 347 THEN 21
        WHEN cntr.djelzz_id = 370 THEN 8
        WHEN cntr.djelzz_id = 430 THEN 4
        WHEN cntr.djelzz_id = 452 THEN 10
        WHEN cntr.djelzz_id = 453 THEN 7
        WHEN cntr.djelzz_id = 468 THEN 7
        WHEN cntr.djelzz_id = 478 THEN 12
        WHEN cntr.djelzz_id = 513 THEN 20
        WHEN cntr.djelzz_id = 563 THEN 4
        WHEN cntr.djelzz_id = 564 THEN 4
        WHEN cntr.djelzz_id = 585 THEN 21
        WHEN cntr.djelzz_id = 591 THEN 21
        WHEN hiknd.Name = 'P'
            AND magrp.Code IN ('1010000', '1010200') THEN 1
        WHEN hiknd.Name = 'P'
            AND magrp.Code = '1020000' THEN 2
        WHEN hiknd.Name = 'P'
            AND magrp.Code = '1040000' THEN 3
        WHEN hiknd.Name = 'P'
            AND magrp.Code IN ('1050000', '1050400') THEN 4
        WHEN hiknd.Name = 'D' THEN
        CASE
            cntr.tip WHEN 'B' THEN 20
            WHEN 'C' THEN 20
            WHEN 'F' THEN 8
            WHEN 'H' THEN 13
            WHEN 'L' THEN 7
            WHEN 'M' THEN 12
            WHEN 'N' THEN 8
            WHEN 'O' THEN 21
            WHEN 'P' THEN 14
            -- promijenjeno u 5 iz 14
            WHEN 'S' THEN 16
        END
        WHEN hiknd.Name = 'C'
            AND cntr.tip = 'P' THEN 6 -- rjelic suggested condition.
        WHEN magrp.Code IN ('1120000', '1120100') THEN 7
        WHEN magrp.Code = '1010100' THEN 8
        WHEN hiknd.Name = 'J' THEN
        CASE
            cntr.tip WHEN 'P' THEN 9
            --- promijenjeno jer je sve bilo 15
            WHEN 'S' THEN 15
            --- dodano 
            WHEN 'C' THEN 24
            -- dodani posebni probrami
        END
        WHEN hiknd.Name = 'H'
            AND magrp.Code = '1110000' THEN 10
        WHEN magrp.Code IN ('1070000', '1070200') THEN 11
        WHEN magrp.Code = '1200000' THEN 12
        WHEN hiknd.Name = 'H'
            AND magrp.Code = '1060000' THEN 13
        WHEN magrp.Code = '2300000' THEN 14
        WHEN cntr.tip = 'b' THEN 20
        WHEN cntr.tip = 'c' THEN 20
        WHEN cntr.tip = 'f' THEN 8
        WHEN cntr.tip = 'H' THEN 13
        WHEN cntr.tip = 'M' THEN 12
        WHEN cntr.tip = 'N' THEN 8
        WHEN cntr.tip = 'O' THEN 16
        WHEN cntr.tip = 'P' THEN 4
        WHEN cntr.tip = 's' THEN 4
        ELSE -1
    END AS ContractTypeID,
    COALESCE(unt.HealthcareInstitutionID,
    -1) AS HealthcareInstitutionID,
    CASE
    WHEN cntr.status = 'S'
        OR COALESCE(cntr.datdo,
        CURRENT_TIMESTAMP) <= cntr.primjena THEN 7
        WHEN cntr.status IN ('G', 'I', 'O', 'R') THEN CASE
            WHEN COALESCE(cntr.datdo,
            CURRENT_TIMESTAMP) <= CURRENT_TIMESTAMP THEN 5
            ELSE 4
        END
        -- FIXME: There should be no nulls here.
        ELSE -1
    END AS ContractStatusID,
    1 AS DocumentCreatorUserID,
    cntr.primjena AS StartDate,
    cntr.datdo AS EndDate,
    cntr.potpis AS LastSignedOn,
    cntr.ulakt_urubro AS ArchiveNumber,
    cntr.predmet_klozna AS ArchiveClassNumber,
    NULL AS BankAccount,
    NULL AS ValidationNote,
    NULL AS ValidationDate,
    cast( NULL as datetime) AS DateArchived,
    NULL AS DocumentIdentifier,
    NULL AS DocumentGenerateTime,
    cast( NULL as datetime ) AS OriginalEndDate,
	NULL AS RejectionArchiveNumber,
    NULL AS RejectionClassNumber,
    NULL AS TerminationNote,
    NULL AS TerminationDate,
    -- If Contract is Cancelled...
    CASE
    WHEN cntr.status = 'S'
        OR COALESCE(cntr.datdo,
        CURRENT_TIMESTAMP) <= cntr.primjena THEN COALESCE(cntr.datdo,
        CURRENT_TIMESTAMP)
    END AS ValidUntil,
    CURRENT_TIMESTAMP AS CreatedOn,
    'MIGRACIJA' AS CreatedBy,
    CURRENT_TIMESTAMP AS ModifiedOn,
    'MIGRACIJA' AS ModifiedBy,
    cntr.brdod AS brdod,
    cntr.broj AS broj,
    cntr.flid AS flid,
    NULL AS parentContractId,
    CASE
        WHEN cntr.vrugo = 'N' THEN 1
        ELSE 2
    END AS ContractModelTypeID,
    cntr.tip AS ugdzu_tip,
    cntr.specka AS ugdzu_specka,
    cntr.davzu_sif AS ugdzu_davzu_sif,
    unt.typ AS unt_typ,
    hiknd.Name AS hiknd_nm,
    magrp.Code AS magrp_cd,
    hiknd.Description AS hiknd_dsc,
    magrp.Name AS magrp_nm,
    cntr.djelzz_id AS ugdzu_djelzz_id,
    cntr.dm_vldtn_rslt
FROM
    cntr_data cntr
LEFT OUTER JOIN dbo.MedicalActivities mactv ON
    cntr.djelzz_id = mactv.MigrationID
LEFT OUTER JOIN dbo.MedicalActivityGroups magrp ON
    mactv.MedicalActivityGroupID = magrp.MedicalActivityGroupID
LEFT OUTER JOIN dbo.MedicalActivitySupergroups masgrp ON
    magrp.MedicalActivitySupergroupID = masgrp.MedicalActivitySupergroupID
LEFT OUTER JOIN unt_data unt ON
    cntr.davzu_sif = unt.UnitCode
LEFT JOIN MedicalWorker.HealthcareInstitutionTypes hityp ON
    unt.HealthcareInstitutionTypeID = hityp.HealthcareInstitutionTypeID
LEFT JOIN MedicalWorker.HealthcareInstitutionKind hiknd ON
    hityp.HealthcareInstitutionKindID = hiknd.HealthcareInstitutionKindID),
cntr_rw_data AS (
SELECT
    ProposalID,
    ContractTypeID,
    HealthcareInstitutionID,
    ContractStatusID,
    DocumentCreatorUserID,
    StartDate,
    EndDate,
    LastSignedOn,
    ArchiveNumber,
    ArchiveClassNumber,
    BankAccount,
    ValidationNote,
    ValidationDate,
    DateArchived,
    DocumentIdentifier,
    DocumentGenerateTime,
    OriginalEndDate,
    RejectionArchiveNumber,
    RejectionClassNumber,
    TerminationNote,
    TerminationDate,
    ValidUntil,
    CreatedOn,
    CreatedBy,
    ModifiedOn,
    ModifiedBy,
    brdod,
    broj,
    flid,
    parentContractId,
    ContractModelTypeID,
    ugdzu_tip,
    ugdzu_specka,
    ugdzu_davzu_sif,
    hiknd_nm,
    hiknd_dsc,
    magrp_cd,
    magrp_nm,
    ugdzu_djelzz_id,
    -- Will use this to merge multiple Contracts of the same type with the same Institution into one.
    CASE
        WHEN count(CASE WHEN EndDate > CURRENT_TIMESTAMP THEN 1 ELSE NULL END) OVER(PARTITION BY CASE
            WHEN EndDate > CURRENT_TIMESTAMP THEN 1
        END,
        HealthcareInstitutionID,
        ContractTypeID) > 1 THEN 1
        ELSE 0
    END AS is_cntr_grp,
    ROW_NUMBER() OVER(
ORDER BY
    broj ASC,
    flid ASC,
    brdod ASC) AS rw_no,
    CASE
        WHEN (dm_vldtn_rslt IS NOT NULL
            AND dm_vldtn_rslt != '')
        OR ContractTypeID = -1
        OR HealthcareInstitutionID = -1
        OR ContractStatusID = -1 THEN 0
        ELSE 1
    END AS dm_is_vld,
    concat(dm_vldtn_rslt,
    CASE
        ContractTypeID WHEN -1 THEN 'CTYP_NULL;'
    END,
    CASE
        HealthcareInstitutionID WHEN -1 THEN 'HINST_NULL;'
    END,
    CASE
        ContractStatusID WHEN -1 THEN 'CNTR_STS_NULL;'
    END) AS dm_vldtn_rslt
FROM
    enrch_data),
cntr_rnk_data AS (
SELECT
    CASE
        is_cntr_grp WHEN 1 THEN min(rw_no) OVER(PARTITION BY HealthcareInstitutionID,
        ContractTypeID,
        is_cntr_grp
    ORDER BY
        brdod ASC,
        broj ASC,
        flid ASC)
        ELSE rw_no
    END AS ContractID,
    ProposalID,
    ContractTypeID,
    HealthcareInstitutionID,
    ContractStatusID,
    DocumentCreatorUserID,
    StartDate,
    EndDate,
    LastSignedOn,
    ArchiveNumber,
    ArchiveClassNumber,
    BankAccount,
    ValidationNote,
    ValidationDate,
    DateArchived,
    DocumentIdentifier,
    DocumentGenerateTime,
    OriginalEndDate,
    RejectionArchiveNumber,
    RejectionClassNumber,
    TerminationNote,
    TerminationDate,
    ValidUntil,
    CreatedOn,
    CreatedBy,
    ModifiedOn,
    ModifiedBy,
    brdod,
    broj,
    flid,
    parentContractId,
    ContractModelTypeID,
    ugdzu_tip,
    ugdzu_specka,
    ugdzu_davzu_sif,
    hiknd_nm,
    hiknd_dsc,
    magrp_cd,
    magrp_nm,
    ugdzu_djelzz_id,
    is_cntr_grp,
    rw_no,
    dm_is_vld,
    dm_vldtn_rslt
FROM
    cntr_rw_data)
SELECT
    ContractID,
    ProposalID,
    ContractTypeID,
    HealthcareInstitutionID,
    ContractStatusID,
    DocumentCreatorUserID,
    -- StartDate,
    CASE
        is_cntr_grp WHEN 0 THEN StartDate
        ELSE min(CASE is_cntr_grp WHEN 1 THEN StartDate END) OVER(PARTITION BY HealthcareInstitutionID,
        ContractTypeID)
    END AS StartDate,
    -- EndDate,
    CASE
        is_cntr_grp WHEN 0 THEN EndDate
        ELSE max(CASE is_cntr_grp WHEN 1 THEN EndDate END) OVER(PARTITION BY HealthcareInstitutionID,
        ContractTypeID)
    END AS EndDate,
    -- LastSignedOn,
    CASE
        is_cntr_grp WHEN 0 THEN LastSignedOn
        ELSE max(CASE is_cntr_grp WHEN 1 THEN LastSignedOn END) OVER(PARTITION BY HealthcareInstitutionID,
        ContractTypeID)
    END AS LastSignedOn,
    ArchiveNumber,
    ArchiveClassNumber,
    BankAccount,
    ValidationNote,
    ValidationDate,
    DateArchived,
    DocumentIdentifier,
    DocumentGenerateTime,
    OriginalEndDate,
    RejectionArchiveNumber,
    RejectionClassNumber,
    TerminationNote,
    TerminationDate,
    ValidUntil,
    CreatedOn,
    CreatedBy,
    ModifiedOn,
    ModifiedBy,
    brdod,
    broj,
    flid,
    parentContractId,
    ContractModelTypeID,
    ugdzu_tip,
    ugdzu_specka,
    ugdzu_davzu_sif,
    -- TODO: Remove columns once done debugging...
    -- hiknd_nm,
    -- hiknd_dsc,
    -- magrp_cd,
    -- magrp_nm,
    -- ugdzu_djelzz_id,
    -- ... remove to here.
    CASE
        is_cntr_grp WHEN 0 THEN dm_is_vld
        ELSE CASE
            rw_no WHEN ContractID THEN dm_is_vld
            ELSE 0
        END
    END AS dm_is_vld,
    CASE
        is_cntr_grp WHEN 0 THEN dm_vldtn_rslt
        ELSE CASE
            rw_no WHEN ContractID THEN dm_vldtn_rslt
            ELSE concat(dm_vldtn_rslt, 'DOOPE_CNTR;')
        END
    END AS dm_vldtn_rslt 
into #tmpContractsNewData
-- INTO stage.stg.stg_Contracts_jt_crnt
FROM
    cntr_rnk_data
WHERE
    1 = 1


	-- suma od novi drop table #tmpContractNewSum
	;with sumNewData as
	(
		select ProposalID, ContractTypeID, HealthcareInstitutionID, ContractStatusID, DocumentCreatorUserID, StartDate, 
		cast( EndDate as date ) EndDate, Cast( LastSignedOn as date ) LastSignedOn, ArchiveNumber, ArchiveClassNumber, BankAccount, ValidationNote, 
			ValidationDate, DateArchived, DocumentIdentifier, DocumentGenerateTime, OriginalEndDate, RejectionArchiveNumber, RejectionClassNumber, TerminationNote, TerminationDate, ValidUntil,   
		brdod, broj, flid, parentContractId, ContractModelTypeID 
		From #tmpContractsNewData
	)
	select *, checksum(*) newSum into #tmpContractNewSum from sumNewData

	-- suma od stari -- drop table #tmpContractOldSum
	;with sumOldData as 
	(
		select ProposalID, ContractTypeID, HealthcareInstitutionID, ContractStatusID, DocumentCreatorUserID, StartDate, cast( EndDate as date ) EndDate, cast( LastSignedOn as date )LastSignedOn, ArchiveNumber, ArchiveClassNumber, BankAccount, ValidationNote, 
		ValidationDate, DateArchived, DocumentIdentifier, DocumentGenerateTime, OriginalEndDate, RejectionArchiveNumber, RejectionClassNumber, TerminationNote, TerminationDate, ValidUntil, 
		brdod, broj, flid, parentContractId, ContractModelTypeID
		From Contract.Contracts
	)
	select *, checksum(*) oldSum into #tmpContractOldSum from sumOldData

	---

	;with promeniPodatoci as 
	(
		select a.* From #tmpContractNewSum a
			join #tmpContractOldSum b on a.broj = b.broj and a.flid = b.flid and a.brdod = b.brdod
		where oldSum <> newSum
	)
	update c set
		c.ProposalID = a.ProposalID,
		c.ContractTypeID = a.ContractTypeID,
		c.HealthcareInstitutionID =  a.HealthcareInstitutionID,
		c.ContractStatusID = a.ContractStatusID,
		c.DocumentCreatorUserID = a.DocumentCreatorUserID,
		c.StartDate = a.StartDate,
		c.EndDate = a.EndDate,
		c.LastSignedOn = a.LastSignedOn,
		c.ArchiveNumber = a.ArchiveNumber,
		c.ArchiveClassNumber = a.ArchiveClassNumber,
		c.BankAccount = a.BankAccount,
		c.ValidationNote = a.ValidationNote,
		c.ValidationDate = a.ValidationDate,
		c.DateArchived = a.DateArchived,
		c.DocumentIdentifier = a.DocumentIdentifier,
		c.DocumentGenerateTime = a.DocumentGenerateTime,
		c.OriginalEndDate = a.OriginalEndDate,
		c.RejectionArchiveNumber = a.RejectionArchiveNumber,
		c.RejectionClassNumber = a.RejectionClassNumber,
		c.TerminationNote = a.TerminationNote,
		c.TerminationDate = a.TerminationDate,
		c.ValidUntil = a.ValidUntil,
		c.ModifiedOn = GETDATE(),
		c.parentContractId = a.parentContractId,
		c.ContractModelTypeID = a.ContractModelTypeID
	from promeniPodatoci a
		join Contract.Contracts c on a.broj = c.broj and a.flid = c.flid and a.brdod = c.brdod

	PRINT N'Contracts Updated'
	------- 

	DECLARE
		@ProposalID INT, @ContractTypeID INT, @HealthcareInstitutionID INT, @ContractStatusID INT, 	@DocumentCreatorUserID INT, @StartDate DATE, 
		@EndDate DATE, 	@LastSignedOn DATE, @ArchiveNumber NVARCHAR(MAX), @ArchiveClassNumber NVARCHAR(MAX), @BankAccount NVARCHAR(MAX), @ValidationNote NVARCHAR(MAX), 
		@ValidationDate DATE, @DateArchived DATE, @DocumentIdentifier NVARCHAR(MAX), @DocumentGenerateTime DATETIME, @OriginalEndDate DATE, @RejectionArchiveNumber NVARCHAR(MAX),
		@RejectionClassNumber NVARCHAR(MAX), @TerminationNote NVARCHAR(MAX), @TerminationDate DATETIME, @ValidUntil DATETIME, @brdod INT, @broj INT, 
		@flid INT, 	@parentContractId INT, 	@ContractModelTypeID INT

		DECLARE ErrorLogCursor_Contrats CURSOR FAST_FORWARD
		FOR
			SELECT DISTINCT
			b.ProposalID,
			b.ContractTypeID,
			b.HealthcareInstitutionID,
			b.ContractStatusID,
			b.DocumentCreatorUserID,
			b.StartDate,
			b.EndDate,
			b.LastSignedOn,
			b.ArchiveNumber,
			b.ArchiveClassNumber,
			b.BankAccount,
			b.ValidationNote,
			b.ValidationDate,
			b.DateArchived,
			b.DocumentIdentifier,
			b.DocumentGenerateTime,
			b.OriginalEndDate,
			b.RejectionArchiveNumber,
			b.RejectionClassNumber,
			b.TerminationNote,
			b.TerminationDate,
			b.ValidUntil,
			b.brdod,
			b.broj,
			b.flid,
			b.parentContractId,
			b.ContractModelTypeID
		from #tmpContractNewSum a
			join #tmpContractsNewData b on a.broj = b.broj and a.flid = b.flid and a.brdod = b.brdod
		where not exists ( select '' from Contract.Contracts c where a.broj = c.broj and a.flid = c.flid and a.brdod = c.brdod )

		OPEN ErrorLogCursor_Contrats;
		FETCH NEXT FROM ErrorLogCursor_Contrats INTO @ProposalID, @ContractTypeID, @HealthcareInstitutionID, @ContractStatusID, @DocumentCreatorUserID, @StartDate, 
			@EndDate, @LastSignedOn, @ArchiveNumber, @ArchiveClassNumber, @BankAccount, @ValidationNote, 
			@ValidationDate, @DateArchived, @DocumentIdentifier, @DocumentGenerateTime, @OriginalEndDate, @RejectionArchiveNumber, 
			@RejectionClassNumber, @TerminationNote, @TerminationDate, @ValidUntil, @brdod, @broj, 
			@flid, @parentContractId, @ContractModelTypeID;

		WHILE @@FETCH_STATUS = 0
		BEGIN
			BEGIN TRY
				INSERT INTO Contract.Contracts (
					ProposalID, ContractTypeID, HealthcareInstitutionID, ContractStatusID, DocumentCreatorUserID, StartDate, EndDate, LastSignedOn, 
					ArchiveNumber, 	ArchiveClassNumber, BankAccount, ValidationNote, ValidationDate, DateArchived, DocumentIdentifier, 	DocumentGenerateTime,
					OriginalEndDate, RejectionArchiveNumber, RejectionClassNumber, TerminationNote, TerminationDate, ValidUntil, brdod, broj, 	flid, 
					parentContractId, 	ContractModelTypeID
				)
				VALUES (@ProposalID, @ContractTypeID, @HealthcareInstitutionID, @ContractStatusID, @DocumentCreatorUserID, @StartDate, 
						@EndDate, @LastSignedOn, @ArchiveNumber, @ArchiveClassNumber, @BankAccount, @ValidationNote, 
						@ValidationDate, @DateArchived, @DocumentIdentifier, @DocumentGenerateTime, @OriginalEndDate, @RejectionArchiveNumber, 
						@RejectionClassNumber, @TerminationNote, @TerminationDate, @ValidUntil, @brdod, @broj, 
						@flid, @parentContractId, @ContractModelTypeID
				)

				/*aleksandar#: ako e ova ovde, ima verojatnost deka nema nikad da zavrsi. Probue inser, pada, ide u catch, nema fetch na next row
				FETCH NEXT FROM ErrorLogCursor_Contrats INTO @ProposalID, @ContractTypeID, @HealthcareInstitutionID, @ContractStatusID, @DocumentCreatorUserID, @StartDate, 
					@EndDate, @LastSignedOn, @ArchiveNumber, @ArchiveClassNumber, @BankAccount, @ValidationNote, 
					@ValidationDate, @DateArchived, @DocumentIdentifier, @DocumentGenerateTime, @OriginalEndDate, @RejectionArchiveNumber, 
					@RejectionClassNumber, @TerminationNote, @TerminationDate, @ValidUntil, @brdod, @broj, 
					@flid, @parentContractId, @ContractModelTypeID;*/

			END TRY
			BEGIN CATCH

			INSERT INTO errorTbls.Contracts_error_sync (
					ProposalID, ContractTypeID, HealthcareInstitutionID, ContractStatusID, DocumentCreatorUserID, StartDate, EndDate, LastSignedOn, 
					ArchiveNumber, 	ArchiveClassNumber, BankAccount, ValidationNote, ValidationDate, DateArchived, DocumentIdentifier, 	DocumentGenerateTime,
					OriginalEndDate, RejectionArchiveNumber, RejectionClassNumber, TerminationNote, TerminationDate, ValidUntil, brdod, broj, 	flid, 
					parentContractId, 	ContractModelTypeID, ErrorMessage
			)
			VALUES (@ProposalID, @ContractTypeID, @HealthcareInstitutionID, @ContractStatusID, @DocumentCreatorUserID, @StartDate, 
						@EndDate, @LastSignedOn, @ArchiveNumber, @ArchiveClassNumber, @BankAccount, @ValidationNote, 
						@ValidationDate, @DateArchived, @DocumentIdentifier, @DocumentGenerateTime, @OriginalEndDate, @RejectionArchiveNumber, 
						@RejectionClassNumber, @TerminationNote, @TerminationDate, @ValidUntil, @brdod, @broj, 
						@flid, @parentContractId, @ContractModelTypeID, ERROR_MESSAGE()
				)

			END CATCH
			/*aleksandar#: preneseno ovde!!!*/
			FETCH NEXT FROM ErrorLogCursor_Contrats INTO @ProposalID, @ContractTypeID, @HealthcareInstitutionID, @ContractStatusID, @DocumentCreatorUserID, @StartDate, 
					@EndDate, @LastSignedOn, @ArchiveNumber, @ArchiveClassNumber, @BankAccount, @ValidationNote, 
					@ValidationDate, @DateArchived, @DocumentIdentifier, @DocumentGenerateTime, @OriginalEndDate, @RejectionArchiveNumber, 
					@RejectionClassNumber, @TerminationNote, @TerminationDate, @ValidUntil, @brdod, @broj, 
					@flid, @parentContractId, @ContractModelTypeID;
		END
		CLOSE ErrorLogCursor_Contrats;
		DEALLOCATE ErrorLogCursor_Contrats

		PRINT 'New Contracts Inserted';


END	

GO

/*
========================================
PROCEDURA ZA ContractsTeamsSync
========================================
*/

create or alter procedure dbo.ContractTeams_OwnersMembersReplacement_Sync
as
begin
-- STAGEING TABLICE

-- za zoroh imamo trenutna sostojba kakva je na produkcii, u onaj moment koji se sinhronizira
-- imamo dodatna tablica gde vodimo koji red je promjenen
					-- **********************************************************************************************************
					-- ****									ContractTeams!!!!!											*****
					-- **********************************************************************************************************
if OBJECT_ID('tempdb..#tmpContractTeams') is not null
	drop table #tmpContractTeams

if OBJECT_ID('tempdb..#tmpTableWithNewData') is not null
	drop table #tmpTableWithNewData

if OBJECT_ID('tempdb..#tmpTableWithOldData') is not null
	drop table #tmpTableWithOldData

if OBJECT_ID('tempdb..#sumOld') is not null
	drop table #sumOld
if OBJECT_ID('tempdb..#sumNew') is not null
	drop table #sumNew

-- Privatne ordinacije insert timova s nositeljima 
;with dataSet as
(
select distinct
	u.broj, u.flid, u.brdod, c.ContractID, 
	u.tip,
	null as AnugoBroj,
	null as AnugoFlid,
	null as ContractTeamId,
	clanovi.id as MigrationTeamId,
	dense_rank() over (order by u.broj, u.flid/*, u.brdod*/) as TempTeamId,
	clanovi.aktivan as tim_aktivan, 
	clanovi.davzu_sif as tim_davzu_sif, 
	hi.HealthcareInstitutionUnitID as HealthcareInstitutionUnitID,
	null as ProposalTeamId,
	tt.TeamTypeID as TeamTypeID,
	ma.MedicalActivityID,
	clanovi.djelzz_id as tim_djelzz_id,
	null as ParentContractTeamID,
	null as WorkingTimeTypeID,
	cast( null as nvarchar(450))  as NumberOfShifts,
	cast( null as nvarchar(450))  as NumberOfOperatingRooms,
	cast( null as nvarchar(450))  as TeamPhoneNumber,
	cast( null as nvarchar(450))  as TeamEmailAddress,
	cast( null as nvarchar(450))  as TeamVirtualOwnerFacsimil,
	null as MedicalWorkerZorohId,
	cast( null as nvarchar(500))  as VirtualTeamName,
	c.startDate as DateFrom,
	c.Enddate as DateTo,
	clanovi.datod as clan_datOd, clanovi.datdo as clan_datDo, 
	clanovi.orig_zdrdje_id,
	case when clanovi.storno = 'S' then clanovi.datpro end as ValidUntil,
	u.zdrdje_id as zdrdje_id,
	mw.PersonId as MedicalWorkerId,
	case when u.specka =1 then 1 else 0 end as IsSpecialist,
	null as errorDescription,
	cast( 'P_privatneOrdinacije' as nvarchar(50)) as source,
	cast( 'PO_' + cast(u.broj as nvarchar(15))+'-'+ltrim(rtrim(u.flid))+'-'/*+cast(u.brdod as varchar(5))+'-'*/+cast(clanovi.id as nvarchar(10)) as varchar(max)) UniqueSyncColumnTmpId
	,cast(clanovi.id as nvarchar(10)) SortColumn
from stage.zoroh.ugdzu u
	join stage.zoroh.davzu d
		on u.davzu_sif = d.sif
	join Contract.Contracts c 
		on u.broj = c.broj and u.flid = c.flid /* and u.brdod = c.brdod*/
	left join medicalWorker.healthcareInstitutionUnits hi
		on u.davzu_sif = hi.UnitCode
	join MedicalWorker.HealthcareInstitutionTypes t
		on hi.HealthcareInstitutionTypeID = t.HealthcareInstitutionTypeID
	join MedicalWorker.HealthcareInstitutionKind k
		on t.HealthcareInstitutionKindID = k.HealthcareInstitutionKindID
	join ( select distinct ugdzu_broj, ugdzu_flid,ugdzu_brdod,  ugdzuv_specka, djelzz_id from stage.zoroh.ugdzsgl ) s
		on u.broj = s.ugdzu_broj and u.flid = s.ugdzu_flid and u.brdod = s.ugdzu_brdod
	left join
	( select  tim.id, tim.aktivan, tim.davzu_sif, tim.zdrdje_id as orig_zdrdje_id, tim.djelzz_id, cl.* 
		from stage.zoroh.timzz tim
			join stage.zoroh.timzzcl cl
		on tim.id = cl.timzz_id and cl.clan = 'N' and cl.storno <>'S' ) clanovi
		on u.davzu_sif = clanovi.davzu_sif and s.djelzz_id = clanovi.djelzz_id 
--		/*and clanovi.datod >=u.primjena */and ( clanovi.datDo <= u.datdo or (clanovi.datdo is null and u.datdo >=getdate()))
and
(case 
	when coalesce (u.datdo, getdate()) <= coalesce(clanovi.datDo, getdate()) and COALESCE(u.primjena, cast ( '1973-01-01' as datetime)) >= COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime))
		and coalesce (u.datdo, getdate()) >= COALESCE(u.primjena, cast ( '1973-01-01' as datetime))
		then  datediff (day, COALESCE(u.primjena, cast ( '1973-01-01' as datetime)), coalesce (u.datdo, getdate()))
	when coalesce (u.datdo, getdate()) <= coalesce(clanovi.datDo, getdate()) and COALESCE(u.primjena, cast ( '1973-01-01' as datetime)) <= COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime))
		and coalesce (u.datdo, getdate()) >= COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime))
		then datediff (day, COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime)), coalesce (u.datdo, getdate()))
	when coalesce (u.datdo, getdate()) >= coalesce(clanovi.datDo, getdate()) and COALESCE(u.primjena, cast ( '1973-01-01' as datetime)) <= COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime))
		and coalesce (clanovi.datDo, getdate()) >= COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime))
		then datediff (day, COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime)), coalesce (clanovi.datDo, getdate()))
	when coalesce (u.datdo, getdate()) >= coalesce(clanovi.datDo, getdate()) and COALESCE(u.primjena, cast ( '1973-01-01' as datetime)) >= COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime))
		and coalesce (clanovi.datDo, getdate()) >= COALESCE(u.primjena, cast ( '1973-01-01' as datetime))
		then datediff (day, COALESCE(u.primjena, cast ( '1973-01-01' as datetime)), coalesce (clanovi.datDo, getdate()))
else -1 end ) >1
left join MedicalWorker.MedicalWorkers mw
	on clanovi.zdrdje_id = mw.MedicalWorkerZorohId
join dbo.MedicalActivities ma
	on s.djelzz_id = ma.MigrationID
join contract.TeamTypes tt
	on ma.MedicalActivityID = tt.MedicalActivityID and tt.IsVirtualTeam = 0
where u.tip ='P' and primjena >= '2007-01-01' 
and k.name in ('P') and clanovi.orig_zdrdje_id = u.zdrdje_id
 --and u.broj = 281102 and u.flid = 114 and u.brdod = 0

-- domovi zdravlja - timovi s nositeljem
union all

select distinct  --a.*
	c.broj as Broj,
	c.flid as flid,
	c.brdod as BrDod, c.ContractID, 
	u.tip as tip,
	a.broj as AnugoBroj,
	a.flid as AnugoFlid,
	null as ContractTeamID,
	null as MigrationTeamID,
	null as tempTeamID,
	null as team_aktivan,
	a.davzu_sif_ord as tim_davzu_sif,
	hu.HealthcareInstitutionUnitID as HealthcareInstitutionUnitID,
	null as ProposalTeamId,
	tt.TeamTypeID as TeamTypeID,
	ma.MedicalActivityID as MedicalActivityID,
	ast.djelzz_id_dob as tim_djelzz_id,
	null as ParentContractTeamId,
	null as WorkingTimeTypeID,
	null as NumberOfShifts,
	null as NumberofOPeratingRooms,
	null as TeamPhoneNumber,
	null as TeamEmailAddress,
	null as TeamVirtualOwnerFascimil,
	null as MedicalWorkerZorohId,
	cast( null as nvarchar(500)) as VirtualTeamName,
	c.StartDate as DateFrom,
	c.EndDate as DateTo,
	a.datod AS clan_DatOd,
	a.datpres AS clan_DatDo,
	a.zdrdje_id as orig_zdrdje_Id,
	null as ValidUntil,
	a.zdrdje_id as zdrdje_id,
	mw.PersonID as MedicalWorkerId,
	case when a.specka =1 then 1 else 0 end as isSpecialist,
	null as errorDescription,
	cast( 'P_domoviZdravlja_snos' as nvarchar(50)),
	cast( 'DZN_'+cast(u.broj as nvarchar(15))+'-'+ltrim(rtrim(u.flid))+'-'/*+cast(u.brdod as varchar(5))+'-'*/+cast(a.broj as nvarchar(10))+'-'+cast(ltrim(rtrim(a.flid)) as nvarchar(10))
	/*+'-'+ltrim(rtrim(ast.ugdzuv_sifra_dob))+'-'+cast(ast.ugdzuv_specka_dob as varchar(2)) */ as varchar(max)) UniqueSyncColumnTmpId

	, cast(a.broj as nvarchar(10))+'-'+cast(ltrim(rtrim(a.flid)) as nvarchar(10))/*+'-'+ltrim(rtrim(ast.ugdzuv_sifra_dob))+'-'+
	cast(ast.ugdzuv_specka_dob as varchar(2))*/ SortColumn
from 
Contract.Contracts c
join stage.zoroh.ugdzu u
	on u.broj = c.broj and u.flid = c.flid -- and u.brdod = c.brdod
join stage.zoroh.anugo a 
	on c.broj = a.ugdzu_broj and c.flid = a.ugdzu_flid and c.brdod = a.ugdzu_brdod
join stage.zoroh.anugost ast
	on a.broj = ast.anugo_broj and a.flid = anugo_flid and a.zdrdje_id = ast.zdrdje_id
left join dbo.MedicalActivities ma
	on ast.djelzz_id_dob = ma.MigrationID
left join Contract.TeamTypes tt
	on ma.MedicalActivityID = tt.MedicalActivityID and tt.IsVirtualTeam = 0
left join MedicalWorker.HealthcareInstitutionUnits hu
	on davzu_sif_ord = hu.UnitCode
left join stage.zoroh.zdrdje z 
	on a.zdrdje_id = z.id 
left join MedicalWorker.MedicalWorkers mw
	on a.zdrdje_id = mw.MedicalWorkerZorohID 
/*join (select tz.djelzz_id ,tz.davzu_sif,  tz.zdrdje_id , tcl.datod, tcl.datdo, id from stage.zoroh.timzz tz
	join stage.zoroh.timzzcl tcl
		on tz.id = tcl.timzz_id and tz.zdrdje_id = tcl.zdrdje_id and tcl.clan ='N' )
			pom on ---(pom.datdo <=u.datdo or pom.datdo is null)
			((u.datDo > getdate() and pom.datDo is null) or (u.datDo < getdate() and (pom.datDo <= u.datDo or pom.datdo is null)))
	and pom.davzu_sif = coalesce(a.davzu_sif_ord, a.davzu_sif) and ast.djelzz_id_dob = pom.djelzz_id and a.zdrdje_id = pom.zdrdje_id
*/where --u.broj = 308968 and u.flid = 34 and u.brdod = 0
u.tip = 'P' and  c.StartDate >= '2007-01-01' and u.zdrdje_id is null
and ma.MedicalActivityID in (2, 12, 13, 8)  and z.matbr not like '99%'
 

-- select * From #tmpContractTeams
-- domovi zdravlja - timovi bez nositelja
union all

select distinct  --a.*
	c.broj as Broj,
	c.flid as flid,
	c.brdod as BrDod, c.ContractID, 
	u.tip as tip,
	a.broj as AnugoBroj,
	a.flid as AnugoFlid,
	null as ContractTeamID,
	null as MigrationTeamID,
	null as tempTeamID,
	null as team_aktivan,
	a.davzu_sif_ord as tim_davzu_sif,
	hu.HealthcareInstitutionUnitID as HealthcareInstitutionUnitID,
	null as ProposalTeamId,
	tt.TeamTypeID as TeamTypeID,
	ma.MedicalActivityID as MedicalActivityID,
	ast.djelzz_id_dob as tim_djelzz_id,
	null as ParentContractTeamId,
	null as WorkingTimeTypeID,
	null as NumberOfShifts,
	null as NumberofOPeratingRooms,
	null as TeamPhoneNumber,
	null as TeamEmailAddress,
	ztim.matbr as TeamVirtualOwnerFascimil,
	ztim.id as MedicalWorkerZorohId,
	concat(concat(ztim.ime, ' '), ztim.prezime) as VirtualTeamName,
	a.datod as DateFrom,
	a.datpres as DateTo,
	ct.datod AS clan_DatOd,
	ct.datdo AS clan_DatDo,
	a.zdrdje_id as orig_zdrdje_Id,
	null as ValidUntil,
	ct.zdrdje_id_tbn as zdrdje_id,
	mw.PersonID as MedicalWorkerId,
	case when a.specka =1 then 1 else 0 end as isSpecialist,
	null as errorDescription,
	cast( 'P_domoviZdravlja_beznos' as nvarchar(50)),
	cast( 'DZBN_'+ cast(u.broj as nvarchar(15))+'-'+ltrim(rtrim(u.flid))+'-'/*+cast(u.brdod as varchar(5))+'-'*/+
		isnull( cast(ct.datod as nvarchar(10)),'')+'-'+ltrim(rtrim(isnull(a.broj,'')))
	+'-'+cast(ltrim(Rtrim(isnull(a.flid,''))) as nvarchar(5)) +'-'+ltrim(rtrim(isnull(ct.zdrdje_id_tbn,'')))  as varchar(max)) UniqueSyncColumnTmpId

	,isnull( cast(ct.datod as nvarchar(10)),'')+'-'+ltrim(rtrim(isnull(a.broj,'')))
	+'-'+cast(ltrim(Rtrim(isnull(a.flid,''))) as nvarchar(5)) +'-'+ltrim(rtrim(isnull(ct.zdrdje_id_tbn,''))) SortColumn
from Contract.Contracts c
	join stage.zoroh.ugdzu u
		on u.broj = c.broj and u.flid = c.flid --and u.brdod = c.brdod
	join stage.zoroh.anugo a
		on c.broj = a.ugdzu_broj and c.flid = a.ugdzu_flid and c.brdod = a.ugdzu_brdod
	join stage.zoroh.anugost ast
		on a.broj = ast.anugo_broj and a.flid = anugo_flid and a.zdrdje_id = ast.zdrdje_id
	left join dbo.MedicalActivities ma
		on ast.djelzz_id_dob = ma.MigrationID
	left join Contract.TeamTypes tt
		on ma.MedicalActivityID = tt.MedicalActivityID and tt.IsVirtualTeam = 1
	left join MedicalWorker.HealthcareInstitutionUnits hu
		on davzu_sif_ord = hu.UnitCode
	left join stage.zoroh.cltbn ct
		on a.broj = ct.anugo_broj and a.flid = ct.anugo_flid
	left join stage.zoroh.zdrdje ztim 
		on a.zdrdje_id = ztim.id
	left join stage.zoroh.zdrdje znos
		on ct.zdrdje_id_tbn = znos.id
	left join MedicalWorker.MedicalWorkers mw
		on znos.id = mw.MedicalWorkerZorohID 
	/*join (select tz.djelzz_id ,tz.davzu_sif,  tz.zdrdje_id , tcl.datod, tcl.datdo, id from stage.zoroh.timzz tz
		join stage.zoroh.timzzcl tcl
			on tz.id = tcl.timzz_id and tz.zdrdje_id = tcl.zdrdje_id and tcl.clan ='N' )
				pom on ---(pom.datdo <=u.datdo or pom.datdo is null)
				((u.datDo > getdate() and pom.datDo is null) or (u.datDo < getdate() and (pom.datDo <= u.datDo or pom.datdo is null)))
		and pom.davzu_sif = coalesce(a.davzu_sif_ord, a.davzu_sif) and ast.djelzz_id_dob = pom.djelzz_id and a.zdrdje_id = pom.zdrdje_id
	*/
where --u.broj = 308968 and u.flid = 34 and u.brdod = 0
u.tip = 'P' and  c.StartDate >= '2007-01-01' and u.zdrdje_id is null
   and ztim.matbr like '99%' -- and c.ContractID=2841
   )
select * into #tmpContractTeams 
From dataSet 
option(maxdop 1)



alter table #tmpContractTeams add DateToLast date, DateFromFirst date, UniqueSyncColumnId varchar(256)


-- select * from #tmpContractTeams where orig_zdrdje_id = 150374

-- update na [UniqueSyncColumnTmpId], za tia BEZ anugo
update a set a.UniqueSyncColumnTmpId = q.novUnique 
from #tmpContractTeams a 
	cross apply (
		select sct.broj, sct.flid, sct.brdod, source, 
			string_agg(UniqueSyncColumnTmpId, '_') within group ( order by cast( SortColumn as varchar(max)) ) novUnique
		from #tmpContractTeams sct 
		where a.broj = sct.broj and a.flid = sct.flid and a.brdod = sct.brdod and a.source = sct.source
			and a.AnugoBroj is null			 
		group by sct.broj, sct.flid, sct.brdod, sct.source
	) q 

-- update na [UniqueSyncColumnTmpId], za tia SO anugo
update a set a.UniqueSyncColumnTmpId = q.novUnique 
from #tmpContractTeams a 
	cross apply (
		select sct.broj, sct.flid, sct.brdod, source, 
			string_agg(UniqueSyncColumnTmpId, '_') within group ( order by cast( SortColumn as varchar(max)) ) novUnique
		from #tmpContractTeams sct 
		where a.broj = sct.broj and a.flid = sct.flid and a.brdod = sct.brdod and a.source = sct.source
			and a.AnugoBroj is not null and ( a.AnugoBroj = sct.AnugoBroj and a.AnugoFlid = sct.AnugoFlid )
		group by sct.broj, sct.flid, sct.brdod, sct.source
	) q  
----
-- trgni SortColumn, ne treba vishe 
alter table #tmpContractTeams drop column SortColumn

if object_id('tempdb..#ContractTeamsWorkingComplete') is not null
	drop table #ContractTeamsWorkingComplete

--- 
select distinct * into #ContractTeamsWorkingComplete From #tmpContractTeams

-- dropni temp da ne fakja mesto bezeveze
drop table #tmpContractTeams
---

/*update pom1
	set tempTeamId = TempTeamId_rank,
	DateToLast = last,
	dateFromFirst = first
from (
		select *,
	dense_rank () over (order by broj, flid, HealthcareINstitutionUnitId, TeamVirtualOwnerFacsimil, diff) as TempTeamId_rank
	,last_VALUE(Dateto) over (partition by broj, flid, HealthcareINstitutionUnitId, TeamVirtualOwnerFacsimil, diff order by DateFrom asc rows between current row and unbounded following) as last 
	,last_VALUE(DateFrom) over (partition by broj, flid,HealthcareINstitutionUnitId, TeamVirtualOwnerFacsimil, diff order by DateFrom desc rows between current row and unbounded following) as first 
	from (
	select *, 
	lag(ct1.dateto) over (partition by broj, flid, HealthcareINstitutionUnitId, TeamVirtualOwnerFacsimil order by datefrom ) as lagdateto ,
	case when DATEDIFF (dd, lag(ct1.dateto) over (partition by broj, flid, HealthcareINstitutionUnitId, TeamVirtualOwnerFacsimil order by datefrom ) ,datefrom ) >1 then 1 else 0 end as diff
	--,last_VALUE(Dateto) over (partition by broj, flid, VirtualTeamName order by DateFrom asc rows between current row and unbounded following) as last 
	from #ContractTeamsWorkingComplete ct1
	where ct1.source in ( 'P_domoviZdravlja_beznos' )) as pom
	) pom1
option (maxdop 1)*/

-- generiraj ID 
update #ContractTeamsWorkingComplete set UniqueSyncColumnId = convert(varchar(256), hashbytes('SHA2_256', UniqueSyncColumnTmpId ), 2) 

update s set
DateFrom = case when source in  ('P_patronaza', 'P_domoviZdravlja_snos') then clan_datOd
				when source in ('P_domoviZdravlja_beznos') then dateFrom
	else DateFrom end,
DateTo =   case when source in  ('P_patronaza', 'P_domoviZdravlja_snos') then clan_datDo
				when source in ('P_domoviZdravlja_beznos') then dateto
	else DateTo end    
from #ContractTeamsWorkingComplete s where 
case when source in  ('P_patronaza', 'P_domoviZdravlja_snos') then clan_datOd
				when source in ('P_domoviZdravlja_beznos') then datefrom
	else DateFrom end is not null

---- kreiraj tabela od izvoren select, samo tia kolone koi se insertiraa -- drop table #tmpTableWithNewData
select distinct
	c.ContractID,
	ct.HealthcareInstitutionUnitID as [HealthcareInstitutionUnitIdD],
	null as ProposalTeamId,
	ct.TeamTypeID,
	ct.MedicalActivityID,
	null as [ParentContractTeamID],
	ct.WorkingTimeTypeID,
	ct.[NumberOfShifts],
	ct.[NumberOfOperatingRooms],
	ct.[TeamPhoneNumber],
	ct.[TeamEmailAddress] ,
	ct.TeamVirtualOwnerFacsimil, 
	ct.[VirtualTeamName],
	ct.[MedicalWorkerZorohID],
	null as [ArchiveNumber],
    null as [ArchiveClassNumber] ,
    null as [SpecialProgramDescription],
    null as [SpecialProgramFinancialCosts],
    null as [SpecialProgramInkindCosts],
    null as [SpecialProgramMedicalDescription],
    null as [DateArchived],
	ct.DateFrom,
    ct.DateTo,
    null as [ValidUntil],
    null as [FoundingTeamFrom],
    null as [FoundingTeamTo],
	--ct.TempTeamId,
	ct.source,
	ct.UniqueSyncColumnId
	into #tmpTableWithNewData
from #ContractTeamsWorkingComplete ct
	join Contract.Contracts c on ct.broj = c.broj and ct.flid = c.flid /*and ct.brdod = c.brdod*/ -- and c.source = ct.source !!!! ne znam dali e ova ednoznacno sekogas. dali e mozno ist broj, flid, i brdod za razlicni source
where ct.source in ( 'P_privatneOrdinacije', 'P_patronaza', 'P_domoviZdravlja_snos', 'P_domoviZdravlja_beznos')
	and ct.HealthcareInstitutionUnitID is not null

--- 
if object_id('tempdb..#ContractTeams') is not null
	drop table #ContractTeams

--  zemi momentalni vrednosti
--;with contractTeams as
--(

select c.ContractID, c.[HealthcareInstitutionUnitID], c.ProposalTeamId, c.TeamTypeID, c.MedicalActivityID, c.[ParentContractTeamID], c.WorkingTimeTypeID,
	c.[NumberOfShifts], c.[NumberOfOperatingRooms] , c.[TeamPhoneNumber], c.[TeamEmailAddress] , c.TeamVirtualOwnerFacsimil,  c.[VirtualTeamName],
	c.[MedicalWorkerZorohID], c.[ArchiveNumber], c.[ArchiveClassNumber] , c.[SpecialProgramDescription], c.[SpecialProgramFinancialCosts], c.[SpecialProgramInkindCosts],
    c.[SpecialProgramMedicalDescription], c.[DateArchived], c.DateFrom, c.DateTo, c.[ValidUntil], c.[FoundingTeamFrom], c.[FoundingTeamTo], 
	c.source, ContractTeamID, UniqueSyncColumnId 
into #ContractTeams
From Contract.ContractTeams c
where source in ( 'P_privatneOrdinacije', 'P_patronaza', 'P_domoviZdravlja_snos', 'P_domoviZdravlja_beznos' )
--option ( maxdop 1 )

--) drop table #tmpTableWithOldData
select distinct
	c.ContractID,
	c.[HealthcareInstitutionUnitID],
	c.ProposalTeamId,
	c.TeamTypeID,
	c.MedicalActivityID,
	c.[ParentContractTeamID],
	c.WorkingTimeTypeID,
	c.[NumberOfShifts],
	c.[NumberOfOperatingRooms] ,
	c.[TeamPhoneNumber],
	c.[TeamEmailAddress] ,
	c.TeamVirtualOwnerFacsimil, 
	c.[VirtualTeamName],
	c.[MedicalWorkerZorohID],
	c.[ArchiveNumber],
    c.[ArchiveClassNumber] ,
    c.[SpecialProgramDescription],
    c.[SpecialProgramFinancialCosts],
    c.[SpecialProgramInkindCosts],
    c.[SpecialProgramMedicalDescription],
    c.[DateArchived],
    c.DateFrom,
    c.DateTo,
    c.[ValidUntil],
    c.[FoundingTeamFrom],
    c.[FoundingTeamTo],
	c.source,
	c.UniqueSyncColumnId
	  into #tmpTableWithOldData 
From #ContractTeams c
	--join #tmpTableWithNewData a on a.UniqueSyncColumnId = c.UniqueSyncColumnId -- a.TempTeamId = c.TempTeamId and a.ContractID = c.ContractID

-- ********************************  
--- *********** Promena: ContractTeams **********

-- napraj checksum na svi redovi za kolonete koi sa kao kljuc drop table #sumOld drop table #sumNew
select source, ContractID, UniqueSyncColumnId, checksum(*) compColumn into #sumOld From #tmpTableWithOldData 
select source, ContractID, UniqueSyncColumnId, checksum(*) compColumn into #sumNew From #tmpTableWithNewData 

create index compColumninx1 on #sumOld(source, ContractId, UniqueSyncColumnId) include (compColumn)
create index compColumninx2 on #sumNew(source, ContractId, UniqueSyncColumnId) include (compColumn)
 
-- ako sumata e razlicna znaci se slucila promena na nekoja od kolonete, napraj update
;with forUpdate as
(
	select a.source, a.UniqueSyncColumnId, a.ContractID 
	from #sumNew a
		join #sumOld b on a.UniqueSyncColumnId = b.UniqueSyncColumnId and a.source = b.source and a.ContractID = b.ContractID
	where a.compColumn <> b.compColumn
)
update c set 
	c.[HealthcareInstitutionUnitID] = a.HealthcareInstitutionUnitIdD,
	c.ProposalTeamId = a.ProposalTeamId,
	--c.TeamTypeID = a.TempTeamId,
	c.MedicalActivityID = a.MedicalActivityID,
	c.[ParentContractTeamID] = a.ParentContractTeamID,
	c.WorkingTimeTypeID = a.WorkingTimeTypeID,
	c.[NumberOfShifts] = a.NumberOfShifts,
	c.[NumberOfOperatingRooms] = a.NumberOfOperatingRooms,
	c.[TeamPhoneNumber] = a.TeamPhoneNumber,
	c.[TeamEmailAddress] = a.TeamEmailAddress,
	c.TeamVirtualOwnerFacsimil = a.TeamVirtualOwnerFacsimil, 
	c.[VirtualTeamName] = a.VirtualTeamName,
	c.[MedicalWorkerZorohID] = a.MedicalWorkerZorohId,
	c.[ArchiveNumber] = a.ArchiveNumber,
    c.[ArchiveClassNumber] = a.ArchiveClassNumber,
    c.[SpecialProgramDescription] = a.SpecialProgramDescription,
    c.[SpecialProgramFinancialCosts] = a.SpecialProgramFinancialCosts,
    c.[SpecialProgramInkindCosts] = a.SpecialProgramInkindCosts,
    c.[SpecialProgramMedicalDescription] = a.SpecialProgramMedicalDescription,
    c.[DateArchived] = a.DateArchived,
    c.DateFrom = a.DateFrom,
    c.DateTo = a.DateTo,
    c.[ValidUntil] = a.ValidUntil,
    c.[FoundingTeamFrom] = a.FoundingTeamFrom,
    c.[FoundingTeamTo] = a.FoundingTeamTo
from #tmpTableWithNewData a
	join #ContractTeams c1 on a.UniqueSyncColumnId = c1.UniqueSyncColumnId and a.source = c1.source and a.ContractID = c1.ContractID
	join Contract.ContractTeams c on c1.ContractTeamID = c.ContractTeamID
where exists ( select '' from forUpdate v where a.UniqueSyncColumnId = v.UniqueSyncColumnId and a.source = v.source and a.ContractID = v.ContractID )

-- *****************************
-- za tia sto gi nema u old, znaci sa novi zapisi pa napraj insert
insert into Contract.ContractTeams
(      [ContractID]
	  ,[HealthcareInstitutionUnitID]
      ,[ProposalTeamID]
      ,[TeamTypeID]
      ,[MedicalActivityID]
      ,[ParentContractTeamID]
      ,[WorkingTimeTypeID]
      ,[NumberOfShifts]
      ,[NumberOfOperatingRooms]
      ,[TeamPhoneNumber]
      ,[TeamEmailAddress]
      ,[TeamVirtualOwnerFacsimil]
      ,[VirtualTeamName]
      ,[MedicalWorkerZorohID]
      ,[ArchiveNumber]
      ,[ArchiveClassNumber]
      ,[SpecialProgramDescription]
      ,[SpecialProgramFinancialCosts]
      ,[SpecialProgramInkindCosts]
      ,[SpecialProgramMedicalDescription]
      ,[DateArchived]
      ,[DateFrom]
      ,[DateTo]
      ,[ValidUntil]
      ,[CreatedOn]
      ,[CreatedBy]
      ,[ModifiedOn]
      ,[ModifiedBy]
      ,[FoundingTeamFrom]
      ,[FoundingTeamTo]
	  --,[stageMigrationId]
	  ,[source]
	  ,[UniqueSyncColumnId]
	)
	select distinct
	ct.ContractID,
	ct.HealthcareInstitutionUnitIdD as [HealthcareInstitutionUnitID],
	null as ProposalTeamId,
	ct.TeamTypeID,
	ct.MedicalActivityID,
	null as [ParentContractTeamID],
	ct.WorkingTimeTypeID,
	ct.[NumberOfShifts],
	ct.[NumberOfOperatingRooms],
	ct.[TeamPhoneNumber],
	ct.[TeamEmailAddress],
	ct.TeamVirtualOwnerFacsimil, 
	ct.[VirtualTeamName],
	ct.[MedicalWorkerZorohID],
	null as [ArchiveNumber],
    null as [ArchiveClassNumber] ,
    null as [SpecialProgramDescription],
    null as [SpecialProgramFinancialCosts],
    null as [SpecialProgramInkindCosts],
    null as [SpecialProgramMedicalDescription],
    null as [DateArchived],
   ct.DateFrom,
   ct.DateTo,
    null as [ValidUntil],
    getdate() as [CreatedOn],
    'MIGRACIJA' as [CreatedBy],
    getdate() as [ModifiedOn],
    'MIGRACIJA' as [ModifiedBy],
    null as [FoundingTeamFrom],
    null as [FoundingTeamTo],
	--ct.TempTeamId,
	ct.source,
	ct.UniqueSyncColumnId
from #tmpTableWithNewData ct
where not exists ( select '' from #ContractTeams c where ct.UniqueSyncColumnId = c.UniqueSyncColumnId and ct.source = c.source and ct.ContractID = c.ContractID )

 
---------
-- zapisi sto nema u NEW, a gi ima u OLD, brisi
;with zaBrisenje as 
(
	select a.UniqueSyncColumnId, a.source, a.ContractID From #tmpTableWithOldData a
	where 
		not exists ( select '' from #tmpTableWithNewData aa 
					where 
						aa.UniqueSyncColumnId = a.UniqueSyncColumnId and 
						a.source = aa.source and 
						a.ContractID = aa.ContractID)
)
update c
	set c.ValidUntil = getdate()
From #ContractTeams ct 
	join zaBrisenje b on ct.UniqueSyncColumnId = b.UniqueSyncColumnId and ct.source = b.source and ct.ContractID = b.ContractID
	join Contract.ContractTeams c on ct.ContractTeamID = c.ContractTeamID

--- ***********END: Promena: ContractTeams **********

					-- **********************************************************************************************************
					-- ****									ContractTeamMember!!!!!											*****
					-- **********************************************************************************************************

if OBJECT_ID('tempdb..#tmpContractTeamMembersNew') is not null
	drop table #tmpContractTeamMembersNew


--- Privatne ordinacije - èlanovi timova
--insert into stage.stg.stg_ContractTeamMembers
--([broj]
--      ,[flid]
--      ,[brdod]
--      ,[tip]
--      ,[AnugoBroj]
--      ,[AnugoFlid]
--      ,[ContractTeamId]
--      ,[MigrationTeamId]
--      ,[TempTeamId]
--      ,[DateFrom]
--      ,[DateTo]
--      ,[clan_datOd]
--      ,[clan_datDo]
--      ,[ValidUntil]
--      ,[zdrdje_id]
--      ,[MedicalWorkerId]
--      ,[errorDescription]
--      ,[source]
--	  )

select distinct 
	u.broj, u.flid, u.brdod, u.tip, c.ContractID, c.StartDate, c.EndDate,
	null as AnugoBroj,
	null as AnugoFlid,
	ct.ContractTeamID as ContractTeamId,
	c.startDate as DateFrom,
	c.Enddate as DateTo,
	clanovi.datod as clan_datOd, clanovi.datdo as clan_datDo, 
	case when clanovi.storno = 'S' then clanovi.datpro end as ValidUntil,
	clanovi.zdrdje_id as zdrdje_id,
	mw.PersonId as MedicalWorkerId,
	null as errorDescription,
	'P_privatneOrdinacije' source
	
/*,cast( 'PO_' + cast(u.broj as nvarchar(15))+'-'+ltrim(rtrim(u.flid))+'-'+cast(u.brdod as varchar(5))+'-'+cast(clanovi.zdrdje_id as nvarchar(15))
		+'-'+cast(clanovi.datod as nvarchar(25))+'-'+cast(clanovi.id as nvarchar(10)) as varchar(max)) UniqueSyncColumnTmpId
,cast(clanovi.id as nvarchar(10)) SortColumn*/

into #tmpContractTeamMembersNew
from stage.zoroh.ugdzu u
	join stage.zoroh.davzu d
		on u.davzu_sif = d.sif
	join Contract.Contracts c
		on u.broj = c.broj and u.flid = c.flid -- and u.brdod = c.brdod
	left join medicalWorker.healthcareInstitutionUnits hi
		on u.davzu_sif = hi.UnitCode
	join MedicalWorker.HealthcareInstitutionTypes t
		on hi.HealthcareInstitutionTypeID = t.HealthcareInstitutionTypeID
	join MedicalWorker.HealthcareInstitutionKind k
		on t.HealthcareInstitutionKindID = k.HealthcareInstitutionKindID
	join ( select distinct ugdzu_broj, ugdzu_flid,ugdzu_brdod,  ugdzuv_specka, djelzz_id from stage.zoroh.ugdzsgl )   s
		on u.broj = s.ugdzu_broj and u.flid = s.ugdzu_flid and u.brdod = s.ugdzu_brdod
	left join
	( select  tim.id, tim.aktivan, tim.davzu_sif, tim.zdrdje_id as orig_zdrdje_id, tim.djelzz_id, cl.* from stage.zoroh.timzz tim
		join stage.zoroh.timzzcl cl
		on tim.id = cl.timzz_id and cl.clan <> 'N' and cl.tip = 'T' and cl.storno <>'S' ) clanovi
		on u.davzu_sif = clanovi.davzu_sif and s.djelzz_id = clanovi.djelzz_id 
			--and /*clanovi.datod >=u.primjena and*/ ( clanovi.datDo <= u.datdo or (clanovi.datdo is null and u.datdo >=getdate()))
	left join MedicalWorker.MedicalWorkers mw
		on clanovi.zdrdje_id = mw.MedicalWorkerZorohId
	join dbo.MedicalActivities ma
		on s.djelzz_id = ma.MigrationID
	join contract.TeamTypes tt
		on ma.MedicalActivityID = tt.MedicalActivityID and tt.IsVirtualTeam = 0
	join Contract.ContractTeams ct on c.ContractID = ct.ContractID  and ct.source = 'P_privatneOrdinacije' 
	--join Contract.ContractTeams ct
--	on clanovi.id = ct.stageMigrationID and ct.source = 'P_privatneOrdinacije'
--	and ct.broj = u.broj and ct.flid = u.flid
	--and clanovi.datod >= ct.clan_datOd and ( clanovi.datDo <= ct.clan_datDo or (clanovi.datdo is null and ct.clan_datDo >=getdate()))
	and
	(case 
	when coalesce (c.Enddate, getdate()) <= coalesce(clanovi.datDo, getdate()) and COALESCE(c.startDate, cast ( '1973-01-01' as datetime)) >= COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime))
		and coalesce (c.Enddate, getdate()) > COALESCE(c.startDate, cast ( '1973-01-01' as datetime))
		then  datediff (day, COALESCE(c.startDate, cast ( '1973-01-01' as datetime)), coalesce (c.Enddate, getdate()))
	when coalesce (c.Enddate, getdate()) <= coalesce(clanovi.datDo, getdate()) and COALESCE(c.startDate, cast ( '1973-01-01' as datetime)) <= COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime))
		and coalesce (c.Enddate, getdate()) > COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime))
		then datediff (day, COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime)), coalesce (c.Enddate, getdate()))
	when coalesce (c.Enddate, getdate()) >= coalesce(clanovi.datDo, getdate()) and COALESCE(c.startDate, cast ( '1973-01-01' as datetime)) <= COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime))
		and coalesce (clanovi.datDo, getdate()) > COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime))
		then datediff (day, COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime)), coalesce (clanovi.datDo, getdate()))
	when coalesce (c.Enddate, getdate()) >= coalesce(clanovi.datDo, getdate()) and COALESCE(c.startDate, cast ( '1973-01-01' as datetime)) >= COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime))
		and coalesce (clanovi.datDo, getdate()) > COALESCE(c.startDate, cast ( '1973-01-01' as datetime))
		then datediff (day, COALESCE(c.startDate, cast ( '1973-01-01' as datetime)), coalesce (clanovi.datDo, getdate()))
else -1 end ) > 0
where u.tip ='P' and primjena >= '2007-01-01' 
and k.name in ('P') --and clanovi.orig_zdrdje_id = u.zdrdje_id

union

-- èlnovi timova sa i bez nositelja u Domovima zdravlja 
select distinct 
	u.broj, u.flid, u.brdod, u.tip, c.ContractID, c.StartDate, c.EndDate,
	/*a.broj*/ null as AnugoBroj,
	/*a.flid*/ null as AnugoFlid,
	null ContractTeamId,
	a.datod as DateFrom,
	a.datpres as DateTo,
	clanovi.datod as clan_datOd, clanovi.datdo as clan_datDo, 
	case when clanovi.storno = 'S' then clanovi.datpro end as ValidUntil,
	clanovi.zdrdje_id as zdrdje_id,
	mw.PersonId as MedicalWorkerId,
	null as errorDescription,
	'P_domoviZdravlja'

	/*,cast( 'DZ_'+cast(u.broj as nvarchar(15))+'-'+ltrim(rtrim(u.flid))+'-'+cast(u.brdod as varchar(5))+'-'+
	+'-'+cast(ltrim(rtrim(isnull(a.broj,''))) as nvarchar(50))+'-'+cast( ltrim(rtrim(isnull(a.flid,''))) as nvarchar(10)) +
	cast(clanovi.zdrdje_id as nvarchar(15))+'-'+cast(clanovi.datod as nvarchar(25))+'-'+cast(clanovi.id as nvarchar(10))  as varchar(max)) UniqueSyncColumnId
	,cast(clanovi.id as nvarchar(10)) SortColumn*/

from Contract.Contracts c
	join stage.zoroh.ugdzu u
		on u.broj = c.broj and u.flid = c.flid -- and u.brdod = c.brdod
	join stage.zoroh.anugo a 
		on c.broj = a.ugdzu_broj and c.flid = a.ugdzu_flid and c.brdod = a.ugdzu_brdod
	join stage.zoroh.anugost ast
		on a.broj = ast.anugo_broj and a.flid = anugo_flid and a.zdrdje_id = ast.zdrdje_id
	left join dbo.MedicalActivities ma
		on ast.djelzz_id_dob = ma.MigrationID
	left join MedicalWorker.HealthcareInstitutionUnits hu
		on davzu_sif_ord = hu.UnitCode
	join 
			(select  tim.id, tim.aktivan, tim.davzu_sif, tim.zdrdje_id as orig_zdrdje_id, tim.djelzz_id, cl.* from stage.zoroh.timzz tim
				join stage.zoroh.timzzcl cl
					on tim.id = cl.timzz_id  and cl.tip ='T' and cl.clan <> 'N' and cl.storno <>'S') clanovi
		on coalesce(a.davzu_sif_ord, a.davzu_sif) = clanovi.davzu_sif and ast.djelzz_id_dob = clanovi.djelzz_id 
/*	and pom.davzu_sif = coalesce(a.davzu_sif_ord, a.davzu_sif) and ast.djelzz_id_dob = pom.djelzz_id and a.zdrdje_id = pom.zdrdje_id
*/
	left join MedicalWorker.MedicalWorkers mw
		on clanovi.zdrdje_id = mw.MedicalWorkerZorohID 
	--join Contract.ContractTeams ct 
	--	on c.ContractID = ct.ContractID and ct.source like 'P_domoviZdravlja%'
	
		--join stage.stg.stg_ContractTeams ct
		--	on a.broj = ct.anugobroj and a.flid = ct.anugoflid and ct.source like  'P_domoviZdravlja%'
		--	and ct.broj = u.broj and ct.flid = u.flid
where 
u.tip = 'P' and  c.StartDate >= '2007-01-01' and u.zdrdje_id is null
--and ma.MedicalActivityID in (2,12,13,8)  
	and
	(case 
	when coalesce (a.datpres, getdate()) <= coalesce(clanovi.datDo, getdate()) and COALESCE(a.datOD, cast ( '1973-01-01' as datetime)) >= COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime))
		and coalesce (a.datpres, getdate()) > COALESCE(a.datOD, cast ( '1973-01-01' as datetime))
		then  datediff (day, COALESCE(a.datOD, cast ( '1973-01-01' as datetime)), coalesce (a.datpres, getdate()))
	when coalesce (a.datpres, getdate()) <= coalesce(clanovi.datDo, getdate()) and COALESCE(a.datOD, cast ( '1973-01-01' as datetime)) <= COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime))
		and coalesce (a.datpres, getdate()) > COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime))
		then datediff (day, COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime)), coalesce (a.datpres, getdate()))
	when coalesce (a.datpres, getdate()) >= coalesce(clanovi.datDo, getdate()) and COALESCE(a.datOD, cast ( '1973-01-01' as datetime)) <= COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime))
		and coalesce (clanovi.datDo, getdate()) > COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime))
		then datediff (day, COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime)), coalesce (clanovi.datDo, getdate()))
	when coalesce (a.datpres, getdate()) >= coalesce(clanovi.datDo, getdate()) and COALESCE(a.datOD, cast ( '1973-01-01' as datetime)) >= COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime))
		and coalesce (clanovi.datDo, getdate()) > COALESCE(a.datOD, cast ( '1973-01-01' as datetime))
		then datediff (day, COALESCE(a.datOD, cast ( '1973-01-01' as datetime)), coalesce (clanovi.datDo, getdate()))
else -1 end ) >0 

-- update na contractTeamId kaj sto e NULL
-- drop table #m
;with redoviBezTeamId as 
( 
	select distinct ContractID, StartDate, EndDate, ContractTeamId  from #tmpContractTeamMembersNew  where ContractTeamId is null
)
, zaUpd as
(
	select distinct a.ContractID, a.StartDate, a.EndDate, ct.ContractTeamID 
	From redoviBezTeamId a 
		join Contract.ContractTeams ct on a.ContractID = ct.ContractID
		cross apply dbo.IntervalDate(a.startdate, a.EndDate, ct.DateFrom, ct.DateTo) i
	where i.DatumVaziOd is not null and i.DatumVaziDo is not null
)
update b set b.ContractTeamId = a.ContractTeamID
From zaUpd a
	join #tmpContractTeamMembersNew b on a.ContractID = b.ContractID and a.StartDate = b.StartDate and a.EndDate = b.EndDate


if object_id('dbo.ContractTeamMembers_SyncBcp') is null
begin
	select 0 ContractTeamMemberID, ContractTeamID, MedicalWorkerID, DateFrom, DateTo, WorkingHours, Description, 
			ValidUntil, CreatedOn, CreatedBy, ModifiedOn, ModifiedBy, cast(null as datetime) DateInsert
into dbo.ContractTeamMembers_SyncBcp
from Contract.ContractTeamMembers where 1=0
	
alter table dbo.ContractTeamMembers_SyncBcp add constraint ContractTeamMembersSyncBcp_DateInsert default getdate() for DateInsert
end

----**********END: Promena: ContractTeams *************

-- ******************************************************************************************************************************
-- **************************						ZAMENE													*********************
					
					-- **********************************************************************************************************
					-- ****									ContractAbsenceMemberReplacements!!!!!							 ****
					-- **********************************************************************************************************
-- select * from Contract.ContractAbsenceMemberReplacements
if object_id('tempdb..#tmpTimzz_clPacWorking') is not null
	drop table #tmpTimzz_clPacWorking
 

if object_id('tempdb..#TmpTimzz_clPac') is not null
	drop table #TmpTimzz_clPac
 

declare @replacementTypeId int 
set @replacementTypeId = ( select ReplacementTypeID from Contract.ReplacementTypes where ltrim(rtrim(name)) = N'Bolovanje(dugotrajno)' and IsLongLasting = 1 )

select  tim.id, tim.aktivan, tim.davzu_sif, tim.zdrdje_id as orig_zdrdje_id, tim.djelzz_id, cl.datod, cl.datdo, cl.zdrdje_id, 
		cl.razzam_id, storno, datpro, cl.clan
into #tmpTimzz_clPacWorking
from stage.zoroh.timzz tim
	join stage.zoroh.timzzcl cl on tim.id = cl.timzz_id  and cl.tip ='Z' /*and cl.clan = 'D'*/ and cl.storno <> 'S'

union all 

select  tim.id, tim.aktivan, tim.davzu_sif, tim.zdrdje_id as orig_zdrdje_id, tim.djelzz_id, cl.datod, cl.datdo, cl.zdrdje_id, @replacementTypeId, 
'N' storno /*valjda N*/, null /*valjda NULL, posto nema storno nema da ni treba ni datum */, 
'D' 
from stage.zoroh.timzz tim
	join stage.zoroh.timzzpac cl on tim.id = cl.timzz_id

----
;with a as
(
	select --id, orig_zdrdje_id, datod, datdo, razzam_id, davzu_sif, zdrdje_id,
	row_number() over (partition by id, orig_zdrdje_id, datod, datdo, razzam_id, davzu_sif, zdrdje_id order by id) br
	From #tmpTimzz_clPacWorking
) 
delete From a
where br > 1 
 
--_----------------
select *, 
	case when datediff(D, lead(datod) over ( partition by davzu_sif, zdrdje_id, djelzz_id order by id), datdo) < -1 then datdo 
		else dateadd(d, -1, lead(datod) over ( partition by davzu_sif, zdrdje_id, djelzz_id order by id)) end tmpDatDo 
into #TmpTimzz_clPac
from #tmpTimzz_clPacWorking

--- ********************** zamjene nositelja u domovi zdravlja ( 'P_domoviZdravlja_snos', 'P_domoviZdravlja_beznos' ) ******************************************** 
/*
	#ContractTeamsWorkingComplete e mnozestvo od site ContractTeams, so soodvetni datumi. od niv trgni sve sto e so nelogicen interval
*/
if object_id('tempdb..#TmpTimzz_clPac_Complete') is not null
	drop table #TmpTimzz_clPac_Complete

;with ctw_ds as
(
	select tim_davzu_sif, tim_djelzz_id, DateFrom, DateTo, source 
	From  #ContractTeamsWorkingComplete 
	where source in ('P_domoviZdravlja_snos', 'P_domoviZdravlja_beznos', 'P_privatneOrdinacije')
),
timzz_tmp as
(
	select * From #TmpTimzz_clPac where clan in ( 'D', 'N', 'S' )
),
readyForDel as 
(
	select distinct b.id, a.DateFrom, a.DateTo, b.datod, b.datdo, b.djelzz_id, b.davzu_sif, b.razzam_id, clan, zdrdje_id, orig_zdrdje_id, source
	From ctw_ds a
		join timzz_tmp b on a.tim_davzu_sif = b.davzu_sif and a.tim_djelzz_id = b.djelzz_id
)
select id, datod, datdo, djelzz_id, davzu_sif, razzam_id, clan, zdrdje_id, orig_zdrdje_id, source 
into #TmpTimzz_clPac_Complete
from readyForDel a
	cross apply dbo.IntervalDate(DateFrom, DateTo, datod, datdo) dateInt
where
( dateInt.DatumVaziOd is not null and dateInt.DatumVaziDo is not null )


-- ************* Privatne ordinacije - zamjene nositelja (za privatne ordinacije) ***************
if object_id('tempdb..#tmpContractTeamMemberReplacementsNew') is not null
	drop table #tmpContractTeamMemberReplacementsNew


select distinct 
c.broj, c.flid, c.brdod, c.tip, null as AnugoBroj,
null as AnugoFlid,
/*ct.ContractTeamID*/ null as ContractTeamId,
null MigrationTeamId,-- ct.MigrationTeamId,
-- ct.tempTeamId as TempTeamId,
c.DateFrom,
c.DateTo,
clanovi.datod as clan_datOd, clanovi.datdo as clan_datDo, 
c.ValidUntil,
clanovi.zdrdje_id as zdrdje_id_zamjena,
mw.PersonId as MedicalWorkerId_zamjena,
/*ct.zdrdje_id */ c.zdrdje_id as zdrdje_id_zamijenjeni,
/*ct.MedicalWorkerId*/ null as MedicalWorkerId_zamijenjeni,
clanovi.clan as tip_zamijenjeni,
null as errorDescription,
c.source as "source",
clanovi.razzam_id,
c.UniqueSyncColumnId,
clanovi.orig_zdrdje_id,
rt.ReplacementTypeID,
cast ( ( case c.source 
			when 'P_privatneOrdinacije' then 'PO_' 
			when 'P_domoviZdravlja_snos' then 'DZN_'
			when 'P_domoviZdravlja_beznos' then 'DZBN_' end )
			+cast(c.broj as nvarchar(15))+'-'+ltrim(rtrim(c.flid))+'-'+cast(c.brdod as varchar(5))+'-'
			+cast( clanovi.zdrdje_id as nvarchar(15))+'-'+cast(clanovi.datod as nvarchar(25))+'-'+cast(clanovi.id as nvarchar(10)) as varchar(max)) UniqueSyncColumnTmpId
,cast(clanovi.id as nvarchar(10)) SortColumn
into #tmpContractTeamMemberReplacementsNew

from #ContractTeamsWorkingComplete c
left join medicalWorker.healthcareInstitutionUnits hi
	on c.HealthcareInstitutionUnitID = hi.HealthcareInstitutionUnitID
join MedicalWorker.HealthcareInstitutionTypes t
	on hi.HealthcareInstitutionTypeID = t.HealthcareInstitutionTypeID
join MedicalWorker.HealthcareInstitutionKind k
	on t.HealthcareInstitutionKindID = k.HealthcareInstitutionKindID
join (select distinct ugdzu_broj, ugdzu_flid,ugdzu_brdod,  ugdzuv_specka, djelzz_id from stage.zoroh.ugdzsgl ) s
	on c.broj = s.ugdzu_broj and  c.flid = s.ugdzu_flid and c.brdod = s.ugdzu_brdod
left join
(
	select * From #TmpTimzz_clPac_Complete 
) clanovi
	on c.tim_davzu_sif = clanovi.davzu_sif and s.djelzz_id = clanovi.djelzz_id
		--and /*clanovi.datod >=u.primjena and*/ ( clanovi.datDo <= u.datdo or (clanovi.datdo is null and u.datdo >=getdate()))
left join MedicalWorker.MedicalWorkers mw
	on clanovi.zdrdje_id = mw.MedicalWorkerZorohId
--left join MedicalWorker.MedicalWorkers mwOrig
--	on clanovi.orig_zdrdje_id = mw.MedicalWorkerZorohId
join dbo.MedicalActivities ma
	on s.djelzz_id = ma.MigrationID
join contract.TeamTypes tt
	on ma.MedicalActivityID = tt.MedicalActivityID and tt.IsVirtualTeam = 0
join stage.zoroh.razzam rz on rz.id = clanovi.razzam_id
join Contract.ReplacementTypes rt on rz.sifra = rt.Code
-- join Contract.ContractTeams ct on c.UniqueSyncColumnId = ct.UniqueSyncColumnId
/*join stage.stg.stg_ContractTeams ct
	on clanovi.id = ct.migrationTeamId and clanovi.source = ct.source and ct.source in ( 'P_privatneOrdinacije', 'P_domoviZdravlja_snos', 'P_domoviZdravlja_beznos' )
	and ct.broj = c.broj and ct.flid = c.flid*/
	and
	(case 
	when coalesce (c.DateTo, getdate()) <= coalesce(clanovi.datDo, getdate()) and COALESCE(c.DateFrom, cast ( '1973-01-01' as datetime)) >= COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime))
		and coalesce (c.DateTo, getdate()) > COALESCE(c.DateFrom, cast ( '1973-01-01' as datetime))
		then  datediff (day, COALESCE(c.DateFrom, cast ( '1973-01-01' as datetime)), coalesce (c.DateTo, getdate()))
	when coalesce (c.DateTo, getdate()) <= coalesce(clanovi.datDo, getdate()) and COALESCE(c.DateFrom, cast ( '1973-01-01' as datetime)) <= COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime))
		and coalesce (c.DateTo, getdate()) > COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime))
		then datediff (day, COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime)), coalesce (c.DateTo, getdate()))
	when coalesce (c.DateTo, getdate()) >= coalesce(clanovi.datDo, getdate()) and COALESCE(c.DateFrom, cast ( '1973-01-01' as datetime)) <= COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime))
		and coalesce (clanovi.datDo, getdate()) > COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime))
		then datediff (day, COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime)), coalesce (clanovi.datDo, getdate()))
	when coalesce (c.DateTo, getdate()) >= coalesce(clanovi.datDo, getdate()) and COALESCE(c.DateFrom, cast ( '1973-01-01' as datetime)) >= COALESCE(clanovi.datod, cast ( '1973-01-01' as datetime))
		and coalesce (clanovi.datDo, getdate()) > COALESCE(c.DateFrom, cast ( '1973-01-01' as datetime))
		then datediff (day, COALESCE(c.DateFrom, cast ( '1973-01-01' as datetime)), coalesce (clanovi.datDo, getdate()))
else -1 end ) > 0
--where c.tip ='P' and primjena >= '2007-01-01' and
-- k.name in ('P')
--

update a set a.ContractTeamId = c.ContractTeamID
From #tmpContractTeamMemberReplacementsNew a
	join Contract.ContractTeams c on a.UniqueSyncColumnId = c.UniqueSyncColumnId

update a set a.MedicalWorkerId_zamijenjeni = mwOrig.PersonID From #tmpContractTeamMemberReplacementsNew a
	join  MedicalWorker.MedicalWorkers mwOrig on a.orig_zdrdje_id = mwOrig.MedicalWorkerZorohId

-------------------------------------------------

if object_id('tempdb..#tmpNewCAMR') is not null
	drop table #tmpNewCAMR


if object_id('tempdb..#tmpOldCAMR') is not null
	drop table #tmpOldCAMR

if object_id('tempdb..#promeniPodatoci') is not null
	drop table #promeniPodatoci

 
if object_id('dbo.ContractAbsenceMemberReplacements_SyncBcp') is null
begin
	select 0 ContractAbsenceMemberReplacementID, ContractTeamMemberID, ReplacementMedicalWorkerID, ReplacementTypeID, DateFrom, DateTo, ValidUntil, CreatedOn, 
	CreatedBy, ModifiedOn, ModifiedBy, cast(null as datetime) DateInsert
	into dbo.ContractAbsenceMemberReplacements_SyncBcp 
	from Contract.ContractAbsenceMemberReplacements where 1 = 0
	
	alter table dbo.ContractAbsenceMemberReplacements_SyncBcp add constraint ContractAbsenceMemberReplacementsSyncBcp_DateInsert default getdate() for DateInsert
end
  	
--- ********************************************************************************************************* 
					
					-- **********************************************************************************************************
					-- ****									ContractAbsenceReplacements!!!!!							     ****
					-- **********************************************************************************************************
	
if object_id('dbo.ContractAbsenceReplacements_SyncBcp') is null
begin
	select 0 ContractAbsenceReplacementID, ContractTeamOwnerID, ReplacementMedicalWorkerID, ReplacementTypeID, DateFrom, DateTo, ValidUntil, CreatedOn, 
	CreatedBy, ModifiedOn, ModifiedBy, cast(null as datetime) DateInsert
	into dbo.ContractAbsenceReplacements_SyncBcp 
	from Contract.ContractAbsenceReplacements where 1 = 0
	
	alter table dbo.ContractAbsenceReplacements_SyncBcp add constraint ContractAbsenceReplacementsSyncBcp_DateInsert default getdate() for DateInsert
end

------------------------------------------------------------------------------------------------------------------------------
-------------KONACNI ZAPISI ZA ZAMJENE---------------------------------------------------------------------------------------------------

begin try
begin transaction scope

--						*** DELETE ContractAbsenceReplacements

insert into dbo.ContractAbsenceReplacements_SyncBcp (ContractAbsenceReplacementID, ContractTeamOwnerID, ReplacementMedicalWorkerID, ReplacementTypeID, DateFrom, DateTo, ValidUntil, CreatedOn, 
	CreatedBy, ModifiedOn, ModifiedBy)
select ContractAbsenceReplacementID, ca.ContractTeamOwnerID, ca.ReplacementMedicalWorkerID, ca.ReplacementTypeID, ca.DateFrom, ca.DateTo, ca.ValidUntil, ca.CreatedOn, 
	ca.CreatedBy, ca.ModifiedOn, ca.ModifiedBy 
From Contract.ContractAbsenceReplacements ca

-- izbrisi
delete a 
from Contract.ContractAbsenceReplacements  a
--	join dbo.ContractAbsenceReplacements_SyncBcp b on a.ContractAbsenceReplacementID = b.ContractAbsenceReplacementID
--where cast( b.DateInsert as date ) = cast(getdate() as date)

DBCC checkident ('Contract.ContractAbsenceReplacements', reseed, 0); 

-- ***					end: DELETE ContractAbsenceReplacements
---------
--						*** DELETE ContractAbsenceMemberReplacements

insert into dbo.ContractAbsenceMemberReplacements_SyncBcp (ContractAbsenceMemberReplacementID, ContractTeamMemberID, ReplacementMedicalWorkerID, ReplacementTypeID, DateFrom, DateTo, ValidUntil, CreatedOn, 
	CreatedBy, ModifiedOn, ModifiedBy)
select ContractAbsenceMemberReplacementID, ca.ContractTeamMemberID, ca.ReplacementMedicalWorkerID, ca.ReplacementTypeID, ca.DateFrom, ca.DateTo, ca.ValidUntil, ca.CreatedOn, 
	ca.CreatedBy, ca.ModifiedOn, ca.ModifiedBy 
From Contract.ContractAbsenceMemberReplacements ca

-- izbrisi
delete a 
from Contract.ContractAbsenceMemberReplacements  a
--	join dbo.ContractAbsenceMemberReplacements_SyncBcp b on a.ContractAbsenceMemberReplacementID = b.ContractAbsenceMemberReplacementID
--where cast( b.DateInsert as date ) = cast(getdate() as date)

DBCC checkident ('Contract.ContractAbsenceMemberReplacements', reseed, 0); 

-- ***					end: DELETE ContractAbsenceMemberReplacements
-------

--- zacuvaj bekap pred da brises
insert into dbo.ContractTeamMembers_SyncBcp (ContractTeamMemberID, ContractTeamID, MedicalWorkerID, DateFrom, DateTo, WorkingHours, Description, 
			ValidUntil, CreatedOn, CreatedBy, ModifiedOn, ModifiedBy)
select distinct ContractTeamMemberID, ContractTeamID, MedicalWorkerID, DateFrom, DateTo, WorkingHours, Description, 
			ValidUntil, CreatedOn, CreatedBy, ModifiedOn, ModifiedBy 
from Contract.ContractTeamMembers

--						--- insertiraj

-- ****** Contract.ContractTeamMembers
delete from Contract.ContractTeamMembers
DBCC checkident ('Contract.ContractTeamMembers', reseed, 0); 

insert into contract.ContractTeamMembers (ContractTeamID, MedicalWorkerID, DateFrom, DateTo)
select distinct ContractTeamId, MedicalWorkerId, clan_datOd, clan_datDo 
from #tmpContractTeamMembersNew a
where exists ( select '' from MedicalWorker.MedicalWorkers m where a.MedicalWorkerId = m.PersonID ) and 
ContractTeamId is not  null

-- ****** Contract.ContractAbsenceMemberReplacements
insert into Contract.ContractAbsenceMemberReplacements ( ContractTeamMemberID, ReplacementMedicalWorkerID, ReplacementTypeID, DateFrom, DateTo, ValidUntil )
select distinct cm.ContractTeamMemberID, pd.MedicalWorkerId_zamjena, pd.ReplacementTypeID, pd.clan_datOd, pd.clan_datDo, pd.ValidUntil  
from Contract.ContractTeamMembers cm 
	--join contract.ContractTeams ct on cm.ContractTeamID = ct.ContractTeamID
	join #tmpContractTeamMemberReplacementsNew pd on cm.ContractTeamID = pd.ContractTeamID and cm.MedicalWorkerID = pd.MedicalWorkerId_zamjena
where pd.tip_zamijenjeni = 'S'  and 
exists ( select 1 from MedicalWorker.MedicalWorkers m where pd.MedicalWorkerId_zamjena = m.PersonID )

 -- ****** Contract.ContractAbsenceMemberReplacements
insert into Contract.ContractAbsenceReplacements ( ContractTeamOwnerID, ReplacementMedicalWorkerID, ReplacementTypeID, DateFrom, DateTo, ValidUntil )
select distinct cm.ContractTeamOwnerID, pd.MedicalWorkerId_zamjena, ReplacementTypeID, pd.clan_datOd, pd.clan_datDo, pd.ValidUntil  
from Contract.ContractTeamOwners cm 
	join #tmpContractTeamMemberReplacementsNew pd on cm.ContractTeamID = pd.ContractTeamID and cm.MedicalWorkerID = pd.MedicalWorkerId_zamijenjeni
where pd.tip_zamijenjeni = 'D' 
and exists ( select 1 from MedicalWorker.MedicalWorkers m where pd.MedicalWorkerId_zamjena = m.PersonID )


commit transaction scope
end try
begin catch

	rollback transaction scope
	declare @errorMsg nvarchar(1000) = error_message()
	declare @msg nvarchar(1500) =  'ERROR: ContractTeamsSync_TransactionScope: ' + @errorMsg
	raiserror(@msg, 16, 0)

end catch

end

go


/*
=====================================
PROCEDURA ZA AdditionalServices_ContractTeamRelatedDoctors
=====================================
*/
create or alter procedure dbo.AdditionalServices_ContractTeamRelatedDoctors
as
begin
if not exists(select '' from sys.columns where Name = N'Description' AND Object_ID = Object_ID(N'Contract.ContractTeamAdditionalServices'))
	alter TABLE [Contract].[ContractTeamAdditionalServices] add [Description] [nvarchar](1500) NULL

---- 
-- select * from stage.zoroh.sifdodmog
-- migrira se u AdditionalServiceGroups, AdditionalServices i RelatedDoctorTypes
--1	provoðenje preventivnih programa - AdditionalServices
--2	rad u skupnoj praksi - RelatedDoctorTypes i AdditionalServices
--3	savjetovalište za odreðene skupine bolesnika, 5* - AdditionalServices
--4	sudjelovanje u eZdravstvu, 5* - AdditionalServices
--5	naruèivanja pacijenta u odreðenom dijelu radnog vremena, 5* - AdditionalServices
--6	uzimanje uzoraka za primarnu laboratorijsku dijagnostiku, 5* - AdditionalServices
--7	uzimanje i dostava uzoraka za mikrobiološku dijagnostiku, 5* - AdditionalServices
--8	osigurano vrijeme za telefonsku konzultaciju, 5* AdditionalServices
--9	dostupnost u sluèaju hitnosti na telefon/mobitel i/ili e-mail, 5* - AdditionalServices
--10	postojanje Knjige utisaka, QI ??????
--11	rad s osobama s posebnim potrebama, 5* - AdditionalServices
--15	dodatna sestra,dr.dentalne medicine u skupnoj praksi  - RelatedDoctorTypes
--13	savjetovalište u domu zdravlja - AdditionalServices i RelatedDoctorTypes
--14	peer grupa (grupa istovrsnih struènjaka)  - RelatedDoctorTypes
--16	posebno dežurstvo -- 
--17	dodatna med. sestra/tehnièar u DZ na 5 ugovorenih timova (40 h/tj)
--18	dodatna med. sestra/tehnièar u DZ na 3 ugovorena tima (40 h/tj)
--19	dodatna med. sestra/tehnièar u ZU i privatni zdr.radnici na 1 ugovoreni tim (20 h/tj)
------------------------------------------------------------------------------------------------------------
/*
select * from contract.AdditionalServiceGroups  -- fix
select * from contract.AdditionalServices -- fix 
select * from Contract.RelatedDoctorTypes  -- fix 
*/

begin try
begin transaction trnScope

if exists ( select '' from contract.ContractTeamRelatedDoctors)
begin
	delete from contract.ContractTeamRelatedDoctors
	dbcc checkident('Contract.ContractTeamRelatedDoctors', RESEED, 0); 
end 

if exists ( select '' from contract.ContractTeamAdditionalServices)
begin
	delete from contract.ContractTeamAdditionalServices
	dbcc checkident('Contract.ContractTeamAdditionalServices', RESEED, 0); 
end 

--- Mapping tabela za AdditionalServiceId, VAZNO !!!!!, da nema nekoja promena u contract.AdditionalServices, za postoeckive id-a
if object_id('tempdb..#AdditionalServiceIdMapping') is not null
	drop table #AdditionalServiceIdMapping

-------------
create table #AdditionalServiceIdMapping(AdditionalServiceId int, djelzz int, SifDodMogZorohId int )

insert into #AdditionalServiceIdMapping
values 
	(1, null, 1), (2, null, 2), (4, null, 4), (5, null, 5), (6, null, 6), (7, null, 7), (8, null, 8),
	(9, null, 9), (10, null, 11), (11, null, 13), (12, 132, 3), (13, 131, 3), (13, 129, 3), (14, 128, 4),
	(15, 128, 5), (16, 128, 9), (15, 128, 5), (17, 128, 3) 


-- ********************************************************************************************************
-- *						Contract.ContractTeamAdditionalServices										  *
-- ********************************************************************************************************

--;with petZ as
--( 
--	select m.*, s.*
--	from stage.zoroh.mogdjel m
--		join stage.zoroh.sifdodmog s on m.sifdodmog_id = s.id
--	where
--	s.id not in ( 1, 2 ) and podvrsta ='Y' and m.datdo is null
----)

-- ************* NE UKLJUCUEM ANUGO - ANEKSI NIGDE. DA SE PROVERI DALI KJE E U RED VAKA!!!!! ***********
--- spoj stage.zoroh.Saddodmog
if object_id('tempdb..#SadDodMog') is not null
	drop table #SadDodMog

/* 
	tabelava saddodmog sodrzi opis, ima i vrednost za aneksi i valjda toa e nekakov opis podeleno za sekoj aneks. Ja zemam distinct gledano po dogovor, spajam
	oddeleni so ;, zatoa sto gledamo po tim, sto ustvari e dogovor, HcareinstitutionUnitId, zakoja dodatna mogucnost se raboti i datumot. 
	PROVERi!!!!!
*/
select ugdzu_broj, ugdzu_flid, ugdzu_brdod, sifdodmog_id, davzu_sif, dodmogp_potpis, string_agg(opis,'; ') opis into #SadDodMog
from (	select distinct ugdzu_broj, ugdzu_flid, ugdzu_brdod, sifdodmog_id, davzu_sif, dodmogp_potpis, opis 
		from stage.zoroh.saddodmog
		where sifdodmog_id not in (2,5,7, 8,9 ) 
			-- Podatke iz tablice saddodmog gdje je sifdodmog_id in (2,5,7, 8,9 ) ne treba migrirati ( besmisleni su) 
			) q
group by ugdzu_broj, ugdzu_flid, ugdzu_brdod, sifdodmog_id, davzu_sif, dodmogp_potpis
 

if object_id('tempdb..#tmpWorkingTable') is not null
	drop table #tmpWorkingTable

select 
ct.ContractTeamID,
0 AdditionalServiceID,
dm.potpis,
dm.datdo,
null as  validUntil,
getdate() as CreatedOn,
N'MIGRACIJA' as CreatedBy, 
getdate() as ModifiedOn,
N'MIGRCIJA' as ModifiedBy,
isnull(sadr.opis,'') descr,
dm.sifdodmog_id,
ma.MigrationID djelzz,
dm.ugdzu_broj, dm.ugdzu_flid
into #tmpWorkingTable
from stage.zoroh.dodmogp dm
	left join #SadDodMog sadr on dm.ugdzu_broj = sadr.ugdzu_broj and dm.ugdzu_flid = sadr.ugdzu_flid and 
								 dm.sifdodmog_id = sadr.sifdodmog_id and dm.davzu_sif = sadr.davzu_sif and 
								 dm.potpis = sadr.dodmogp_potpis
 	join MedicalWorker.healthcareInstitutionUnits hu on dm.davzu_sif = hu.UnitCode
	join Contract.Contracts c on dm.ugdzu_broj = c.broj and dm.ugdzu_flid = c.flid
	join Contract.ContractTeams ct on hu.HealthcareInstitutionUnitID = ct.HealthcareInstitutionUnitID and c.ContractID = ct.ContractID
 	join MedicalActivities ma on ct.MedicalActivityID = ma.MedicalActivityID
	

-- update na AdditionalServiceId za djellzz
update a set 
	a.AdditionalServiceID = b.AdditionalServiceId
from #tmpWorkingTable a 
	join #AdditionalServiceIdMapping b on a.djelzz = b.djelzz and a.sifdodmog_id = b.SifDodMogZorohId

-- update na AdditionalServiceId bez mapping povrzan so djelZZ
update a set 
	a.AdditionalServiceID = b.AdditionalServiceId
from #tmpWorkingTable a 
	join #AdditionalServiceIdMapping b on a.sifdodmog_id = b.SifDodMogZorohId
where b.djelzz is null

-- zapis 
 insert into Contract.ContractTeamAdditionalServices(ContractTeamID, AdditionalServiceID, DateFrom, DateTo, ValidUntil, [Description] )
 select ContractTeamID, AdditionalServiceID, potpis, datdo, validUntil, descr from #tmpWorkingTable
 where  AdditionalServiceID in ( select AdditionalServiceID From Contract.AdditionalServices )
 
 /*
	 ****8 ima i takvi za koi sifdodmog_id = 10, a toa ne e preneseno u nasa baza
 select ContractTeamID, AdditionalServiceID, potpis, datdo, validUntil from #tmpWorkingTable
 where  AdditionalServiceID in ( select AdditionalServiceID From Contract.AdditionalServices )
 */
 
----------------

------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------- SKUPNA PRAKSA --------------------------------------------------------------------------------------------

-- ********************************************************************************************************
-- *****					Contract.ContractTeamRelatedDoctors										  *****
-- ********************************************************************************************************

if exists ( select '' from Contract.ContractTeamRelatedDoctors )
begin
	delete from Contract.ContractTeamRelatedDoctors
	dbcc checkident('Contract.ContractTeamRelatedDoctors',reseed,0)
end

-------
;with pom as (	
	select 
	s.id as skupraId, 
	sifdodmog_id,
	c.datod as skupraDatOd,
	c.datDo as skupraDatdo,
	--cto.ContractTeamID,
	cto.MedicalWorkerID/*,
	cto.DateFrom,
	cto.DateTo*/
	,max(cto.dateTo) as MaxTeamDateTo
	from stage.zoroh.skupra s
	join stage.zoroh.clskupra c		
		on s.id = c.skupra_id
	join stage.zoroh.davzu d
		on c.davzu_sif = d.sif
	join MedicalWorker.MedicalWorkers mw
		on c.zdrdje_id = mw.MedicalWorkerZorohID
	join  Contract.ContractTeamOwners cto
		on mw.PersonID = cto.MedicalWorkerID 
	where
	(case 
	when coalesce (c.datdo, getdate()) <= coalesce(cto.DateTo, getdate()) and COALESCE(c.datOd, cast ( '1973-01-01' as datetime)) >= COALESCE(cto.DateFrom, cast ( '1973-01-01' as datetime))
		and coalesce (c.datdo, getdate()) > COALESCE(c.datOd, cast ( '1973-01-01' as datetime))
		then  datediff (day, COALESCE(c.datOd, cast ( '1973-01-01' as datetime)), coalesce (c.datdo, getdate()))
	when coalesce (c.datdo, getdate()) <= coalesce(cto.DateTo, getdate()) and COALESCE(c.datOd, cast ( '1973-01-01' as datetime)) <= COALESCE(cto.DateFrom, cast ( '1973-01-01' as datetime))
		and coalesce (c.datdo, getdate()) > COALESCE(cto.DateFrom, cast ( '1973-01-01' as datetime))
		then datediff (day, COALESCE(cto.DateFrom, cast ( '1973-01-01' as datetime)), coalesce (c.datdo, getdate()))
	when coalesce (c.datdo, getdate()) >= coalesce(cto.DateTo, getdate()) and COALESCE(c.datOd, cast ( '1973-01-01' as datetime)) <= COALESCE(cto.DateFrom, cast ( '1973-01-01' as datetime))
		and coalesce (cto.DateTo, getdate()) > COALESCE(cto.DateFrom, cast ( '1973-01-01' as datetime))
		then datediff (day, COALESCE(cto.DateFrom, cast ( '1973-01-01' as datetime)), coalesce (cto.DateTo, getdate()))
	when coalesce (c.datdo, getdate()) >= coalesce(cto.DateTo, getdate()) and COALESCE(c.datOd, cast ( '1973-01-01' as datetime)) >= COALESCE(cto.DateFrom, cast ( '1973-01-01' as datetime))
		and coalesce (cto.DateTo, getdate()) > COALESCE(c.datOd, cast ( '1973-01-01' as datetime))
		then datediff (day, COALESCE(c.datOd, cast ( '1973-01-01' as datetime)), coalesce (cto.DateTo, getdate()))
else -1 end ) >0
and sifdodmog_id in ( 13, 2, 14 )
group by
s.id , 	sifdodmog_id,
	c.datod ,
	c.datDo ,
	--cto.ContractTeamID,
	cto.MedicalWorkerID
) 
, pom1 as
(select pom.MedicalWorkerID, pom.skupraId, pom.skupraDatOd, pom.sifdodmog_id, pom.skupraDatdo, cto.ContractTeamID from pom
join contract.ContractTeamOwners cto
	on pom.MedicalWorkerID = cto.MedicalWorkerID and pom.MaxTeamDateTo = cto.DateTo
join Contract.contractTeams ct
	on cto.ContractTeamID = ct.ContractTeamID
	where ct.TeamVirtualOwnerFacsimil is null)



insert into contract.ContractTeamRelatedDoctors 
(contractTeamId, medicalWorkerId, RelatedDoctorTypeID, dateFrom, dateTo, validUntil , skupraId)
select 
pomtim.ContractTeamID,pomDoktor.MedicalWorkerID, rdt.relatedDoctorTypeId, --	pomTim.sifdodmog_id,
case when pomTim.skupraDatOd < pomDoktor.skupraDatOd then pomDoktor.skupraDatOd
		else pomTim.skupraDatOd
		end as skupraDatOd,
	case when pomTim.skupraDatdo < pomDoktor.skupraDatdo then pomTim.skupraDatdo
		when pomTim.skupraDatdo is null then pomDoktor.skupraDatdo
		else pomDoktor.skupraDatdo
		end as skupraDatdo,
null as ValidUntil
, pomTim.skupraid
from pom1 pomTim 
cross apply pom1 pomDoktor 
join contract.RelatedDoctorTypes rdt
	on pomtim.sifdodmog_id = rdt.MigrationID
where pomTim.MedicalWorkerID <> pomDoktor.MedicalWorkerID
	and pomTim.skupraId = pomDoktor.skupraId 
	and
	(case 
	when coalesce (pomDoktor.skupraDatdo, getdate()) <= coalesce(pomTim.skupraDatDo, getdate()) and COALESCE(pomDoktor.skupraDatOd, cast ( '1973-01-01' as datetime)) >= COALESCE(pomTim.skupraDatOd, cast ( '1973-01-01' as datetime))
		and coalesce (pomDoktor.skupraDatdo, getdate()) > COALESCE(pomDoktor.skupraDatOd, cast ( '1973-01-01' as datetime))
		then  datediff (day, COALESCE(pomDoktor.skupraDatOd, cast ( '1973-01-01' as datetime)), coalesce (pomDoktor.skupraDatdo, getdate()))
	when coalesce (pomDoktor.skupraDatdo, getdate()) <= coalesce(pomTim.skupraDatDo, getdate()) and COALESCE(pomDoktor.skupraDatOd, cast ( '1973-01-01' as datetime)) <= COALESCE(pomTim.skupraDatOd, cast ( '1973-01-01' as datetime))
		and coalesce (pomDoktor.skupraDatdo, getdate()) > COALESCE(pomTim.skupraDatOd, cast ( '1973-01-01' as datetime))
		then datediff (day, COALESCE(pomTim.skupraDatOd, cast ( '1973-01-01' as datetime)), coalesce (pomDoktor.skupraDatdo, getdate()))
	when coalesce (pomDoktor.skupraDatdo, getdate()) >= coalesce(pomTim.skupraDatDo, getdate()) and COALESCE(pomDoktor.skupraDatOd, cast ( '1973-01-01' as datetime)) <= COALESCE(pomTim.skupraDatOd, cast ( '1973-01-01' as datetime))
		and coalesce (pomTim.skupraDatDo, getdate()) > COALESCE(pomTim.skupraDatOd, cast ( '1973-01-01' as datetime))
		then datediff (day, COALESCE(pomTim.skupraDatOd, cast ( '1973-01-01' as datetime)), coalesce (pomTim.skupraDatDo, getdate()))
	when coalesce (pomDoktor.skupraDatdo, getdate()) >= coalesce(pomTim.skupraDatDo, getdate()) and COALESCE(pomDoktor.skupraDatOd, cast ( '1973-01-01' as datetime)) >= COALESCE(pomTim.skupraDatOd, cast ( '1973-01-01' as datetime))
		and coalesce (pomTim.skupraDatDo, getdate()) > COALESCE(pomDoktor.skupraDatOd, cast ( '1973-01-01' as datetime))
		then datediff (day, COALESCE(pomDoktor.skupraDatOd, cast ( '1973-01-01' as datetime)), coalesce (pomTim.skupraDatDo, getdate()))
else -1 end ) >0

commit transaction trnScope

end try
begin catch
	rollback transaction trnScope
	declare @msg nvarchaR(2000) = error_message(), @msgComplete nvarchar(2000) 
	set @msgComplete  = 'ERROR: AdditionalServices+SkupnaPraksa _ '+ @msg 
	raiserror(@msgComplete, 16,2)
end catch

end
go
---------------------
/*
=====================================
PROCEDURA ZA SYNC
=====================================
*/

-- Stored Procedure

CREATE or alter PROCEDURE [dbo].[RunSync]
AS

BEGIN

	DECLARE @SUCCESS BIT = 1;

    BEGIN TRY
        EXECUTE dbo.CompaniesSync;
        PRINT N'Companies Synced';
    END TRY
    BEGIN CATCH
        INSERT INTO errorTbls.SyncErrors (ErrorMessage, ErrorTimestamp)
        VALUES ('Error in dbo.CompaniesSync - ' + ERROR_MESSAGE(), GETDATE());
		set  @SUCCESS = 0;
    END CATCH;

    BEGIN TRY
        EXECUTE dbo.PersonsSync;
        PRINT N'Persons Synced';
    END TRY
    BEGIN CATCH
        INSERT INTO errorTbls.SyncErrors (ErrorMessage, ErrorTimestamp)
        VALUES ('Error in dbo.PersonsSync - ' + ERROR_MESSAGE(), GETDATE());
		set  @SUCCESS = 0;
    END CATCH;

    BEGIN TRY
        EXECUTE dbo.TaxPayersSync;
        PRINT N'TaxPayers Synced';
    END TRY
    BEGIN CATCH
        INSERT INTO errorTbls.SyncErrors (ErrorMessage, ErrorTimestamp)
        VALUES ('Error in dbo.TaxPayersSync - ' + ERROR_MESSAGE(), GETDATE());
		set  @SUCCESS = 0;
    END CATCH;

    BEGIN TRY
        EXECUTE dbo.HealtcareInstitutionSync;
        PRINT N'HI Synced';
    END TRY
    BEGIN CATCH
        INSERT INTO errorTbls.SyncErrors (ErrorMessage, ErrorTimestamp)
        VALUES ('Error in dbo.HealtcareInstitutionSync - ' + ERROR_MESSAGE(), GETDATE());
		set  @SUCCESS = 0;
    END CATCH;

    BEGIN TRY
        EXECUTE dbo.MedicalWorkerSync;
        PRINT N'MedicalWorkers Synced';
    END TRY
    BEGIN CATCH
        INSERT INTO errorTbls.SyncErrors (ErrorMessage, ErrorTimestamp)
        VALUES ('Error in dbo.MedicalWorkerSync - ' + ERROR_MESSAGE(), GETDATE());
		set  @SUCCESS = 0;
    END CATCH;

    BEGIN TRY
        EXECUTE dbo.InsurancesSync;
        PRINT N'Insurance Synced';
    END TRY
    BEGIN CATCH
        INSERT INTO errorTbls.SyncErrors (ErrorMessage, ErrorTimestamp)
        VALUES ('Error in dbo.InsurancesSync - ' + ERROR_MESSAGE(), GETDATE());
		set  @SUCCESS = 0;
    END CATCH;

	BEGIN TRY
        EXECUTE dbo.ConcratsSync;
        PRINT N'Concrats Synced';
    END TRY
    BEGIN CATCH
        INSERT INTO errorTbls.SyncErrors (ErrorMessage, ErrorTimestamp)
        VALUES ('Error in dbo.ConcratsSync - ' + ERROR_MESSAGE(), GETDATE());
		set  @SUCCESS = 0;
    END CATCH;

	BEGIN TRY
        EXECUTE dbo.ContractTeams_OwnersMembersReplacement_Sync;
        PRINT N'Concrats(Teams/Owner/Replacement) Synced';
    END TRY
    BEGIN CATCH
        INSERT INTO errorTbls.SyncErrors (ErrorMessage, ErrorTimestamp)
        VALUES ('Error in dbo.ContractTeams_OwnersMembersReplacement_Sync - ' + ERROR_MESSAGE(), GETDATE());
		set  @SUCCESS = 0;
    END CATCH;

	BEGIN TRY
        EXECUTE dbo.AdditionalServices_ContractTeamRelatedDoctors;
        PRINT N'AdditionalServices_ContractTeamRelatedDoctors Synced';
    END TRY
    BEGIN CATCH
        INSERT INTO errorTbls.SyncErrors (ErrorMessage, ErrorTimestamp)
        VALUES ('Error in dbo.AdditionalServices_ContractTeamRelatedDoctors - ' + ERROR_MESSAGE(), GETDATE());
		set  @SUCCESS = 0;
    END CATCH;	

	IF @SUCCESS = 0 raiserror ('Error in sync, check log file', 16, 2);

END;

GO

create or alter procedure OibPersonsSync 
as 
	
	/* *** 1. insert dio *** */

	insert into ImportOib.OibPersons(
		PersonID,
		ParentName,
		MigrationID,
		PersonalIdentificationNumber,
		PINDate,
		FirstName,
		LastName,
		UniqueIdentificationNumber,
		BirthLastName,
		BirthDate,
		BirthPlaceName,
		BirthCountryCode,
		BirthCountryName,
		AddressStreetCode,
		AddressStreetName,
		AddressStreetNumber,
		AddressComplements,
		AddressPostalCode,
		AddressPlaceCode,
		AddressPlaceName,
		AddressMunicipalityCode,
		AddressMunicipalityName,
		AddressCountryName,
		AddressCountryCode,
		AddressStatusDate,
		IDNumber,
		IDDateTo,
		IDCountryCode,
		IDCountryName,
		CitizenshipDateFrom,
		DeactivationDate,
		AnnulmentDate,
		NewPIN,
		DateFrom,
		DateTo,
		OibStatusID,
		Gender,
		AddressStatusID,
		CitizenshipTypeID,
		IdentificationDocumentTypeID,
		DeactivationReasonID,
		CreatedOn,
		CreatedBy,
		ModifiedOn,
		ModifiedBy
	)
	select
		P.PersonID
		,P.ParentName
		,o.id
		,oib
		,dvdoib
		,ime
		,prezime
		,jmbg
		,prezrod
		,datrod
		,mjrod
		,sifdrzrod
		,drzrod
		,sifulice
		,ulica
		,kucbr
		,kucbrd
		,hptbroj
		,sifnas
		,naselje
		,sifopc
		,opcina
		,drzava
		,sifdrz
		,dpromsta
		,brdok
		,datvdok
		,sifdridok
		,drzidok
		,datsthrd
		,datde
		,datpon
		,vazoib
		,datodhzzo
		,datdohzzo
		,oibstat_id
		,spol_sifra
		,adrstat_id
		,drzavljan_id
		,oibvrdok_id
		,razldeak_id
		,created_at
		,'MIGRACIJA'
		,GETDATE()
		,'MIGRACIJA'
	from stage.zoroh.oibfiz o
	join stage.zoroh.elog_oibfiz eo on o.id = eo.id
	join dbo.Persons P on o.oib = P.PersonalIdentificationNumber
	where eo.al_a = 'I'


	/* *** 2. update dio *** */

	update ob
		set 
			MigrationID = eo.id,
			PersonalIdentificationNumber = o.oib,
			PINDate = dvdoib,
			FirstName = ime,
			LastName = prezime,
			UniqueIdentificationNumber = oib,
			BirthLastName = prezrod,
			BirthDate = datrod,
			BirthPlaceName = mjrod,
			BirthCountryCode = sifdrzrod,
			BirthCountryName = drzrod,
			AddressStreetCode = sifulice,
			AddressStreetName = ulica,
			AddressStreetNumber = kucbr,
			AddressComplements = kucbrd,
			AddressPostalCode = hptbroj,
			AddressPlaceCode = sifnas,
			AddressPlaceName = naselje,
			AddressMunicipalityCode = sifopc,
			AddressMunicipalityName = opcina,
			AddressCountryName = drzava,
			AddressCountryCode = sifdrz,
			AddressStatusDate = dpromsta,
			IDNumber = brdok,
			IDDateTo = datvdok,
			IDCountryCode = sifdridok,
			IDCountryName = drzidok,
			CitizenshipDateFrom = datsthrd,
			DeactivationDate = datde,
			AnnulmentDate = datpon,
			NewPIN = vazoib,
			DateFrom = datodhzzo,
			DateTo = datdohzzo,
			OibStatusID = oibstat_id,
			Gender = spol_sifra,
			AddressStatusID = adrstat_id,
			CitizenshipTypeID = drzavljan_id,
			IdentificationDocumentTypeID = oibvrdok_id,
			DeactivationReasonID = razldeak_id,
			ModifiedBy = GETDATE()
	from ImportOib.OibPersons ob
	join stage.zoroh.elog_oibfiz eo on ob.MigrationID = eo.id
	join stage.zoroh.oibfiz o on eo.id = o.id
	where eo.al_a = 'U'

GO


ALTER TRIGGER [TaxPayer].[AfterUpdate_TaxPayers]
ON [TaxPayer].[TaxPayers]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO TaxPayer.TaxPayersHistory
    (
        TaxPayerID,
        ContributionPayerTypeID,
        LinkID,
        CompanyID,
        RegionalUnitID,
        DateFrom,
        ModifiedBy,
				MigrationID
    )
    SELECT D.TaxPayerID,
           D.ContributionPayerTypeID,
           D.LinkID,
           D.CompanyID,
           D.RegionalUnitID,
           D.ModifiedOn,
           D.ModifiedBy,
					 D.MigrationID
    FROM Deleted D
        INNER JOIN Inserted I
            ON D.TaxPayerID = I.TaxPayerID
    WHERE I.ContributionPayerTypeID <> D.ContributionPayerTypeID
          OR I.LinkID <> D.LinkID
          OR I.CompanyID <> D.CompanyID
					OR I.MigrationID <> D.MigrationID
          OR
          (
              I.CompanyID IS NULL
              AND D.CompanyID IS NOT NULL
          )
          OR
          (
              I.CompanyID IS NOT NULL
              AND D.CompanyID IS NULL
          )
          OR I.RegionalUnitID <> D.RegionalUnitID
          OR
          (
              I.RegionalUnitID IS NULL
              AND D.RegionalUnitID IS NOT NULL
          )
          OR
          (
              I.RegionalUnitID IS NOT NULL
              AND D.RegionalUnitID IS NULL
          )
					OR
          (
              I.MigrationID IS NOT NULL
              AND D.MigrationID IS NULL
          );
END;
GO
