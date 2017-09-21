select 
  Clastname,
	   Cfirstname,
	   Cotch,
	   iif(lSex = 0,'ж','м') lSex,
	 	   c_grazd as StranaBirth,
	   	   FORMAT(cast(Dd_birth as DATE), 'd', 'de-de' ) Dd_birth ,
		   Fac.Cshort_name_fac,
		  Cname_spec,
		 [Prikaz].[Nn_prikaz],
		  	   FORMAT(cast([Prikaz].Dd_prikaz as DATE), 'd', 'de-de' ) Dd_prikaz ,
		  docs.cvid_doc,
		 cast(Cd_seria as varchar(10)) Cd_seria,
	   cast(Np_number as varchar(20)) Np_number,
	   	   FORMAT(cast(Dd_vidan as DATE), 'd', 'de-de' ) Dd_vidan, 
	   Cd_kem_vidan,
	   		   null as srok,
ctelefon,
cSotTel,
cEmail,
		Cname_form_ed
		
	from dbo.Person
	inner join dbo.Strana on dbo.Strana.Ik_strana=dbo.Person.Ik_grazd
	inner join ABIT_postup on ABIT_postup.nCode = dbo.Person.nCode
    inner join [Prikaz] ON ABIT_postup.[ik_prikaz_zach]=[Prikaz].[Ik_prikaz]
	inner join Student on ABIT_postup.nCode = dbo.Student.nCode
	inner join [Zaved_stud] on [Zaved_stud].[ik_zaved] = dbo.Student.[Ik_zaved]
	inner join Kat_zach on ABIT_postup.ik_kat_zach = Kat_zach.Ik_kat_zach
	inner join ABIT_Diapazon_spec_fac on ABIT_Diapazon_spec_fac.NNrecord = ABIT_postup.NNrecord
	inner join Relation_spec_fac on ABIT_Diapazon_spec_fac.ik_spec_fac = Relation_spec_fac.ik_spec_fac
	inner join EducationBranch on Relation_spec_fac.ik_spec = EducationBranch.ik_spec
	inner join Fac on fac.Ik_fac = Relation_spec_fac.ik_fac
	inner join Form_ed on Form_ed.Ik_form_ed=Relation_spec_fac.Ik_form_ed
	inner join Direction on Direction.ik_direction = EducationBranch.ik_direction
	inner join TypeKatZach on Kat_zach.ik_type_kat = TypeKatZach.ik_type_kat
	left join (select Doc_stud.*,documents.cvid_doc from Doc_stud, documents where documents.Ik_vid_doc = Doc_stud.Ik_vid_doc and IsIdentity = 1) docs
on Student.nCode = docs.nCode
left join (select nCode,fIndex,FlatNumber,StructNumber,BuildingNumber,CStreet,Cgorod,Cregion,Craion,Cstrana,Strana.Ik_strana,
		   PATINDEX('%[À-ÿ]%',BuildingNumber) b_i, PATINDEX('%[À-ÿ]%',StructNumber) s_i
		   from dbo.PersonAddress,dbo.Address,dbo.Street,dbo.Gorod,dbo.Raion,dbo.Region,dbo.Strana
		   where ik_AddressType=2
		   and dbo.Address.ik_address = dbo.PersonAddress.ik_address
		   and dbo.Address.Ik_street = dbo.Street.Ik_street
		   and dbo.Street.ik_gorod = dbo.Gorod.Ik_gorod
		   and dbo.Gorod.Ik_raion = dbo.Raion.Ik_raion
		   and dbo.Raion.Ik_region = dbo.Region.Ik_region
		   and dbo.Region.Ik_strana = dbo.Strana.Ik_strana) pr
on Student.nCode = pr.nCode
	where ik_zach in (select ik_zach from ABIT_sost_zach where ik_type_zach = 2) 																
	--and Relation_spec_fac.ik_fac = 31										
	and Person.Ik_grazd<>2							
	and dbo.Student.nCode = ABIT_postup.nCode
--	and dbo.[Zaved_stud].[ik_zaved] = dbo.Student.[Ik_zaved]
	and NNyear=year(GETDATE())

	order by Cshort_name_fac,Cname_spec,Clastname




