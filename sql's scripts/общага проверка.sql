SELECT  id, DateBegin, DateEnd, idApproverType, idDepartment, idEmployee
FROM       [ShemaTabel].[Approver]
WHERE      (DateEnd is  null) and  (idDepartment in (95, 96, 97, 98, 99, 303, 304, 394, 395, 396, 497, 498, 499 )) and idApproverType=3