DECLARE @temp TABLE(
    nCode numeric NOT NULL,
	FirstName varchar(max) NOT NULL,
    LastName varchar(max) NOT NULL,
	ser varchar(max) NOT NULL,
	nom varchar(max) NOT NULL
);

insert into @temp 
select distinct 
nc,
	   Cfirstname,
	   Clastname,
	   iif(Cd_seria='', '0000', Cd_seria) as Cd_seria,
	   cast(Np_number as varchar(20)) Np_number   
from
(
	select distinct 

cast(dd_pod_zayav as Date) dd_pod_zayav,
		   ltrim(rtrim(Clastname)) Clastname, 
		   ltrim(rtrim(Cfirstname)) Cfirstname, 
		   ltrim(rtrim(Cotch)) Cotch,
		   lSex, 
		   FORMAT(cast(Dd_birth as DATE), 'd', 'de-de' ) Dd_birth, 
		   Cplacebirth, 
		   ctelefon, 
		   REPLACE(REPLACE(REPLACE(REPLACE(cSotTel,' ',''),'-',''),'(',''),')','') cSotTel,
		   cSotTel SotTel,
		   PATINDEX('%[0-9]%',cSotTel) tel_i,
		   cEmail,
		   Fac.Cshort_name_fac,
		   Spec_stud.Cname_spec,
		   Direction.cName_direction,
		   Person.nCode nc,
		   Person.Ik_grazd,
		   Strana.Cstrana c_grazd,
		   Strana.ik_type_grazd resident,
		   NNyear,
		   Form_ed.Ik_form_ed,
		   Cname_form_ed,
		   CType_kat,
		  [Prikaz].[Nn_prikaz],
		  FORMAT(cast([Dd_prikaz] as DATE), 'd', 'de-de' ) Dd_prikaz, 
		 --[Prikaz].[Dd_prikaz] isnull(cast([Dd_prikaz] as DATE),
		   Person.[PersonFullName]
	from dbo.Person,ABIT_postup,[Prikaz],ABIT_Diapazon_spec_fac,dbo.Student,Relation_spec_fac,Spec_stud,Fac,
		 Strana,Form_ed,Kat_zach,TypeKatZach,Direction
	where ABIT_postup.nCode = dbo.Person.nCode and ABIT_Diapazon_spec_fac.NNrecord = ABIT_postup.NNrecord
	and ABIT_Diapazon_spec_fac.ik_spec_fac = Relation_spec_fac.ik_spec_fac
	and ABIT_postup.ik_kat_zach = Kat_zach.Ik_kat_zach
	and ABIT_postup.[ik_prikaz_zach]=[Prikaz].[Ik_prikaz]
	and Kat_zach.ik_type_kat = TypeKatZach.ik_type_kat
	and Person.Ik_grazd = Strana.Ik_strana
	and Form_ed.Ik_form_ed=Relation_spec_fac.Ik_form_ed
	and Relation_spec_fac.ik_fac = Fac.Ik_fac and Relation_spec_fac.ik_spec = Spec_stud.ik_spec
	and Spec_stud.ik_direction = Direction.ik_direction
	and ik_zach in (select ik_zach from ABIT_sost_zach where ik_type_zach = 2) --çà÷èñëåííûå
	--and ABIT_postup.dd_zachisl is null																--âîò òóò ðåãóëèðóþòñÿ âîëíû ïîñòóïëåíèÿ!
	and Relation_spec_fac.Ik_form_ed = 1									--î÷íèêè
	and TypeKatZach.ik_type_kat in (1,2)									--íå êîíòðàêò
	and Relation_spec_fac.ik_fac <> 31										--íå êîëëåäæè
	--and direction.ik_direction	= 3											--ìàãèñòðû
	and dbo.Student.nCode = ABIT_postup.nCode
	and NNyear=year(GETDATE())
	--and Person.Ik_grazd=2
	and Person.Photo is not null
) stud
left join (select Doc_stud.*,documents.cvid_doc from Doc_stud, documents where documents.Ik_vid_doc = Doc_stud.Ik_vid_doc and documents.ik_vid_doc not in (2) -- не свидетельство о рождении
  and  IsIdentity = 1) docs
on stud.nc = docs.nCode

select * from @temp
 

DECLARE CURSOR_PersonIds CURSOR FOR (SELECT nCode FROM @temp)

--DECLARE @PhotoId numeric;
DECLARE @PersonId numeric;

OPEN CURSOR_PersonIds

FETCH NEXT FROM CURSOR_PersonIds INTO @PersonId
WHILE (@@FETCH_STATUS <> -1)
BEGIN
  DECLARE @ImageData varbinary(max);
  SELECT @ImageData = (SELECT convert(varbinary(max), Photo, 1) FROM [dbo].[Person] where nCode = @PersonId);

  DECLARE @Path nvarchar(1024);
  SELECT @Path = 'C:\SqlExport';

  DECLARE @Filename VARCHAR(max);
  SELECT @Filename = (SELECT 'FI_'+ser+'_'+nom+'_001000'  FROM @temp where nCode = @PersonId);

  DECLARE @FullPathToOutputFile NVARCHAR(2048);
  SELECT @FullPathToOutputFile = @Path + '\' + @Filename+'.jpg';

  DECLARE @ObjectToken INT
  EXEC sp_OACreate 'ADODB.Stream', @ObjectToken OUTPUT;
  EXEC sp_OASetProperty @ObjectToken, 'Type', 1;
  EXEC sp_OAMethod @ObjectToken, 'Open';
  EXEC sp_OAMethod @ObjectToken, 'Write', NULL, @ImageData;
  EXEC sp_OAMethod @ObjectToken, 'SaveToFile', NULL, @FullPathToOutputFile, 2;
  EXEC sp_OAMethod @ObjectToken, 'Close';
  EXEC sp_OADestroy @ObjectToken;

  FETCH NEXT FROM CURSOR_PersonIds INTO @PersonId
END
CLOSE CURSOR_PersonIds
DEALLOCATE CURSOR_PersonIds