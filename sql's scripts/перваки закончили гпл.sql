select distinct 
PersonFullName as [���], 
iif(lSex = 0,'�','�') as [���], 
YEAR(FORMAT(cast(Dd_birth as DATE), 'd', 'de-de' )) as [��� ��������],
'1' as [����], 
gr.grupName as [������], 
Fac.Cshort_name_fac as [��������], 
[Prikaz].[Nn_prikaz] as [� �������], 
FORMAT(cast([Prikaz].Dd_prikaz as DATE), 'd', 'de-de' ) as [���� �������], 
--TZ.ctyp_zaved as [������� �����������],
[Zaved_stud].cName_zaved as [���������],  
Sh_spec as [���� �������������], 
Cname_spec as [�������������], 
c_grazd as [�����������], 
Cname_form_ed as [����� ��������]

from dbo.Person 
inner join dbo.Strana on dbo.Strana.Ik_strana=dbo.Person.Ik_grazd 
inner join ABIT_postup on ABIT_postup.nCode = dbo.Person.nCode 
inner join [Prikaz] ON ABIT_postup.[ik_prikaz_zach]=[Prikaz].[Ik_prikaz] 
inner join Student on ABIT_postup.nCode = dbo.Student.nCode 
inner join [Zaved_stud] on [Zaved_stud].[ik_zaved] = dbo.Student.[Ik_zaved] 
inner join [dbo].[typ_zaved] TZ on [Zaved_stud].ik_typ_zaved = TZ.ik_typ_zaved 
inner join Kat_zach on ABIT_postup.ik_kat_zach = Kat_zach.Ik_kat_zach 
inner join ABIT_Diapazon_spec_fac on ABIT_Diapazon_spec_fac.NNrecord = ABIT_postup.NNrecord 
inner join Relation_spec_fac on ABIT_Diapazon_spec_fac.ik_spec_fac = Relation_spec_fac.ik_spec_fac 
inner join EducationBranch on Relation_spec_fac.ik_spec = EducationBranch.ik_spec 
inner join Fac on fac.Ik_fac = Relation_spec_fac.ik_fac 
inner join Form_ed on Form_ed.Ik_form_ed=Relation_spec_fac.Ik_form_ed 
inner join Direction on Direction.ik_direction = EducationBranch.ik_direction 
inner join TypeKatZach on Kat_zach.ik_type_kat = TypeKatZach.ik_type_kat 
left join ( 
SELECT DISTINCT 
Person.nCode as studId 
,Grup.Cname_grup as grupName 
FROM dbo.Fac INNER JOIN 
dbo.Relation_spec_fac ON dbo.Fac.Ik_fac = dbo.Relation_spec_fac.ik_fac INNER JOIN 
dbo.EducationBranch ON dbo.Relation_spec_fac.ik_spec = dbo.EducationBranch.ik_spec INNER JOIN 
dbo.Grup ON dbo.Relation_spec_fac.ik_spec_fac = dbo.Grup.ik_spec_fac INNER JOIN 
dbo.StudGrup ON dbo.Grup.Ik_grup = dbo.StudGrup.Ik_grup 
AND StudGrup.[Ik_prikazOtch] is null --AND StudGrup.[Ik_prikazZach] is not null 

INNER JOIN 
dbo.Zach ON dbo.StudGrup.Ik_zach = dbo.Zach.Ik_zach INNER JOIN 
dbo.Student ON dbo.Zach.nCode = dbo.Student.nCode INNER JOIN 
dbo.Person ON dbo.Student.nCode = dbo.Person.nCode INNER JOIN 
dbo.Form_ed ON dbo.Relation_spec_fac.Ik_form_ed = dbo.Form_ed.Ik_form_ed 
WHERE --Grup.Cname_grup like '%17%' 
YEAR(Grup.DateCreate) = 2017 
--and Form_ed.Ik_form_ed = 1 
) gr on dbo.Person.nCode = gr.studId 
where ik_zach in (select ik_zach from ABIT_sost_zach where ik_type_zach = 2) 
--and Relation_spec_fac.ik_fac = 31 
--and Person.Ik_grazd <> 2 
--and Form_ed.Ik_form_ed = 1 
and NNyear=year(GETDATE()) 
and [Zaved_stud].cName_zaved like '%���%' 
and [Zaved_stud].Ik_gorod = 17946
order by Cshort_name_fac, Cname_spec, PersonFullName