select PersonFullName fio, Cshort_name_fac ins,[Cname_spec] spec,
CType_kat
,Cname_form_ed,
       Cname_lang lang
	    from 
	dbo.Person p inner join dbo.Student s on s.nCode=p.nCode
	inner join dbo.ABIT_postup ap on ap.nCode=p.nCode
	inner join dbo.ABIT_sost_zach sz on ap.ik_zach=sz.ik_zach
	LEFT join dbo.Lang_stud ls on ls.nCode=p.nCode
	left join dbo.Lang l on l.Ik_lang=ls.Ik_lang 
	inner join dbo.ABIT_Diapazon_spec_fac adsf on adsf.NNrecord=ap.NNrecord
	inner join dbo.Relation_spec_fac rsf on rsf.ik_spec_fac=adsf.ik_spec_fac
	inner join Form_ed on Form_ed.Ik_form_ed=rsf.Ik_form_ed
	inner join dbo.Fac f on f.Ik_fac=rsf.ik_fac
	inner join dbo.Spec_stud ss on ss.ik_spec=rsf.ik_spec
	inner join Kat_zach on Kat_zach.Ik_kat_zach = ap.ik_kat_zach
	inner join TypeKatZach on Kat_zach.ik_type_kat = TypeKatZach.ik_type_kat
	where adsf.NNyear=2017
	 --and  p.Ik_grazd=2 
	 --and Form_ed.Ik_form_ed in (2)
	 -- and rsf.Ik_form_ed 
	  and ap.ik_zach in (select ik_zach from ABIT_sost_zach where ik_type_zach=2)
	  and f.Ik_fac <> 31
	order by  ins,spec,fio,CType_kat