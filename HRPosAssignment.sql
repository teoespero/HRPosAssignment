/*
	
	HRPosAssignment
	The HRPosAssignment table tracks the details of a position assignment.

*/

select 
	DistrictID,
	rtrim(DistrictAbbrev) as DistrictAbbrev,
	DistrictTitle
from tblDistrict

select 
	(select DistrictId from tblDistrict) as OrgId,
	pcd.PositionControlID as PosID,
	null as PrimaryPos,
	pcd.EmployeeID as EmpId,
	2018 as FiscalYear,
	CONVERT(VARCHAR(10), pcd.EffectiveDate, 110) as DateFrom,
	CONVERT(VARCHAR(10), pcd.InactiveDate, 110) as DateThru,
	null as AssignmentTypeCode,
	null as FTEPTW,
	pcd.FTE as FTEUsed,
	null as SalarySchedId,
	null as SalaryRowId,
	null as SalaryColId,
	pcd.pcSlotCalendarID as  CalendarId,
	null as AllowMiscContrib,
	pcd.Comments as Comment,
	null as OASDIEnabled
from tblPositionControlDetails pcd
inner join
	tblEmployee te
	on te.EmployeeID = pcd.EmployeeID
	and te.TerminateDate is null
	and pcd.InactiveDate is null
order by
	te.EmployeeID asc, 
	pcd.PositionControlID asc


