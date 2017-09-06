SELECT distinct 
dbo.PlanStaff.idDepartment, 
dbo.Post.PostName,
dbo.Post.ManagerBit, 
dbo.Employee.EmployeeName,
dbo.DepartmentHistory.DepartmentName,
dbo.Employee.EmployeeLogin,
dbo.Employee.email

                        
FROM            dbo.PlanStaff INNER JOIN
						 dbo.Dep AS D1 ON dbo.PlanStaff.idDepartment = D1.id LEFT OUTER JOIN
                         dbo.DepartmentHistory ON D1.id = dbo.DepartmentHistory.idDepartment INNER JOIN
                         dbo.Post ON dbo.PlanStaff.idPost = dbo.Post.id INNER JOIN
                         dbo.FactStaff ON dbo.PlanStaff.id = dbo.FactStaff.idPlanStaff INNER JOIN
                         dbo.Employee ON dbo.FactStaff.idEmployee = dbo.Employee.id LEFT OUTER JOIN
                         dbo.DepContacts ON dbo.FactStaff.ContactsIDFK = dbo.DepContacts.ID Left OUTER JOIN
						 dbo.CategoryZP ON dbo.Post.idCategoryZP = dbo.CategoryZP.id
WHERE        (dbo.FactStaff.DateEnd > GETDATE() OR
                         dbo.FactStaff.DateEnd IS NULL) 
						 and dbo.Post.ManagerBit =1 
						 --and dbo.Post.PostName like '%заместитель%'
						 and 
						 (dbo.DepartmentHistory.DateBegin =
                             (SELECT        MAX(DateBegin) AS Expr1
                               FROM            dbo.DepartmentHistory AS DepartmentHistory_1
                               WHERE        (idDepartment = D1.id)))
order by dbo.DepartmentHistory.DepartmentName,dbo.Post.PostName,dbo.Employee.EmployeeName

go

SELECT distinct 
dbo.PlanStaff.idDepartment, 
dbo.Post.PostName,
dbo.Post.ManagerBit, 
dbo.Employee.EmployeeName,
dbo.DepartmentHistory.DepartmentName,
dbo.Employee.EmployeeLogin,
dbo.Employee.email

                        
FROM            dbo.PlanStaff INNER JOIN
						 dbo.Dep AS D1 ON dbo.PlanStaff.idDepartment = D1.id LEFT OUTER JOIN
                         dbo.DepartmentHistory ON D1.id = dbo.DepartmentHistory.idDepartment INNER JOIN
                         dbo.Post ON dbo.PlanStaff.idPost = dbo.Post.id INNER JOIN
                         dbo.FactStaff ON dbo.PlanStaff.id = dbo.FactStaff.idPlanStaff INNER JOIN
                         dbo.Employee ON dbo.FactStaff.idEmployee = dbo.Employee.id LEFT OUTER JOIN
                         dbo.DepContacts ON dbo.FactStaff.ContactsIDFK = dbo.DepContacts.ID Left OUTER JOIN
						 dbo.CategoryZP ON dbo.Post.idCategoryZP = dbo.CategoryZP.id
WHERE        (dbo.FactStaff.DateEnd > GETDATE() OR
                         dbo.FactStaff.DateEnd IS NULL) 
						 and dbo.Post.PostName like '%заместитель%'
						 and 
						 (dbo.DepartmentHistory.DateBegin =
                             (SELECT        MAX(DateBegin) AS Expr1
                               FROM            dbo.DepartmentHistory AS DepartmentHistory_1
                               WHERE        (idDepartment = D1.id)))
order by dbo.DepartmentHistory.DepartmentName,dbo.Post.PostName,dbo.Employee.EmployeeName