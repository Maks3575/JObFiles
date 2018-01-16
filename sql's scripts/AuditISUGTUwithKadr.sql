DECLARE @audit TABLE(
    username varchar(max) NOT NULL,
    edit numeric NOT NULL,
	ins numeric NOT NULL,
	del numeric NOT NULL,
	scor numeric NOT NULL
);

DECLARE @kadr TABLE(
	idEmp numeric NULL,
	empname varchar(max) NOT NULL,
	emplogin varchar(max)  NULL,
	email varchar(max)  NULL
);
insert into @kadr 
SELECT E.id ,E.EmployeeName, E.EmployeeLogin, E.email  from [KadrRealTest].[dbo].[Employee] E
where E.email is not null or E.EmployeeLogin is not null

insert into @audit 
SELECT 
REPLACE(AE.UserName,'UGTU\','') as [������������]

,SUM(IIF(AOT.OperationName = '������'
	, 1, 0)) as [������]
,SUM(IIF(AOT.OperationName = '�������'
	, 1, 0)) as [�������]
,SUM(IIF(AOT.OperationName = '��������'
	, 1, 0)) as [��������]
--,SUM(IIF(AOT.OperationName = '�������'
--	, 1, 0)) as �������
--,SUM(IIF(AOT.OperationName = '����������'
--	, 1, 0)) as ����������

,Count(AE.AuditDateTime) as [�����]

  FROM [UGTU].[dbo].[Audit_Event] as AE inner join [UGTU].[dbo].[Audit_OperationType] as AOT
  on AE.OperationTypeID = AOT.OperationTypeID
 
  where AE.AuditDateTime between '01.06.2017' and  GETDATE() and AE.UserName like '%UGTU\%'
 
  group by  AE.UserName
  order by AE.UserName

  select distinct a.*, k.*, DepartmentName, DepartmentSmallName from @audit a left join @kadr k 
  on a.username = REPLACE(k.email,'@ugtu.net','') or a.username = REPLACE(k.emplogin,'@ugtu.net','')
  left join [KadrRealTest].[dbo].[FactStaff] as FS on k.idEmp = FS.idEmployee 
  and FS.idEndPrikaz is null and (FS.DateEnd is null or FS.DateEnd > GETDATE())
  left join [KadrRealTest].[dbo].[PlanStaff] as PS on FS.idPlanStaff = PS.id
  left join  [KadrRealTest].[dbo].[DepartmentHistory] as DepH on PS.idDepartment = DepH.idDepartment


