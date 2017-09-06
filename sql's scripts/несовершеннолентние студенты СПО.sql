select a.[���������]
, a.[�������������]
, a.[������]
, a.[����� ��������]
,Count(a.������) as [��������� ������������������]
from 
(SELECT DISTINCT 
			--Fac.Ik_fac as Ik_fac
			--,
			Fac.Cname_fac as [���������]
			,EducationBranch.Cname_spec as [�������������]
			,Grup.[Cname_grup] as [������]
			--,Form_ed.Ik_form_ed  as  Ik_form_ed
			,Form_ed.Cname_form_ed  as  [����� ��������]
			--,Zach.Ik_zach as Ik_zach
			,Zach.Nn_zach as [�������]
			--,Zach.nCode as nCode
			,Person.[PersonFullName] as [���]
			,CONVERT(VARCHAR(24),Person.[Dd_birth],104) as [���� ��������]
			--,EducationBranch.ik_spec  as ik_spec
		FROM             dbo.Fac INNER JOIN
                         dbo.Relation_spec_fac ON dbo.Fac.Ik_fac = dbo.Relation_spec_fac.ik_fac INNER JOIN
                         dbo.EducationBranch ON dbo.Relation_spec_fac.ik_spec = dbo.EducationBranch.ik_spec INNER JOIN
                         dbo.Grup ON dbo.Relation_spec_fac.ik_spec_fac = dbo.Grup.ik_spec_fac INNER JOIN
                         dbo.StudGrup ON dbo.Grup.Ik_grup = dbo.StudGrup.Ik_grup 
							AND StudGrup.[Ik_prikazOtch] is null AND StudGrup.[Ik_prikazZach] is not null
						 
						 INNER JOIN
                         dbo.Zach ON dbo.StudGrup.Ik_zach = dbo.Zach.Ik_zach INNER JOIN
                         dbo.Student ON dbo.Zach.nCode = dbo.Student.nCode INNER JOIN
                         dbo.Person ON dbo.Student.nCode = dbo.Person.nCode INNER JOIN
                        dbo.Form_ed ON dbo.Relation_spec_fac.Ik_form_ed = dbo.Form_ed.Ik_form_ed 
			WHERE  Grup.[DateExit] > GETDATE() and Fac.[Ik_fac] = 31 -- �� ���
			and DATEDIFF(year, Person.[Dd_birth] ,GETDATE())<18) as a
group by a.[���������]
, a.[�������������]
, a.[������]
, a.[����� ��������]