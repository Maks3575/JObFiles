/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [UGTU_TEST].[dbo].[Region] as RR inner join [UGTU].[dbo].[Region] as R
  on RR.Ik_region = R.Ik_region
  where RR.GUID in (
'DE459E9C-2933-4923-83D1-9C64CFD7A817',
'B6BA5716-EB48-401B-8443-B197C9578734',
'DF3D7359-AFA9-4AAA-8FF9-197E73906B1C',
'C2DEB16A-0330-4F05-821F-1D09C93331E6',
'88CD27E2-6A8A-4421-9718-719A28A0A088',
'61B95807-388A-4CB1-9BEE-889F7CF811C8',
'52618B9C-BCBB-47E7-8957-95C63F0B17CC'
  ) --and RR.Ik_strana =2
order by RR.GUID