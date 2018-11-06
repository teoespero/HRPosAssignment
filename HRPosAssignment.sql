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
	pcd.SlotNum as PosID,
	null as PrimaryPos,
	pcd.EmployeeID as EmpId,
	2018 as FiscalYear,
	CONVERT(VARCHAR(10), pcd.EffectiveDate, 110) as DateFrom,
	CONVERT(VARCHAR(10), pcd.InactiveDate, 110) as DateThru,
	null as AssignmentTypeCode,
	null as FTEPTW,
	pcd.FTE as FTEUsed,
	ct.CompType,
	smg.SalaryMatrixGroupID as SalarySchedId,
	smg.GroupName,
	sm.RowNumber as SalaryRowId,
	sm.ColNumber as SalaryColId,
	sm.StepColumn,
	sm.[Value],
	pcd.pcSlotCalendarID as  CalendarId,
	cal.CalendarName,
	null as AllowMiscContrib,
	pcd.Comments as Comment,
	null as OASDIEnabled
from tblPositionControlDetails pcd
inner join
	tblEmployee te
	on te.EmployeeID = pcd.EmployeeID
	and te.TerminateDate is null
	and pcd.InactiveDate is null
left join 
	tblSlotCalendarByYear cal
	on cal.SlotCalendarID = pcd.pcSlotCalendarID
	and cal.FiscalYear = 2018
left join
	tblCompDetails cd
	on cd.cdPositionControlID = pcd.PositionControlID
	and cd.FiscalYear = 2018
	and cd.InactiveDate is null
left join
	tblSalaryMatrix sm
	on sm.SalaryMatrixID = cd.SalaryMatrixID
left join
	tblSalaryMatrixGroup smg
	on smg.SalaryMatrixGroupID = sm.mxGroup
left join
	tblSalaryMatrixSeries ser
	on ser.mxSeriesID = sm.SeriesID
left join
	tblCompType ct
	on cd.CompTypeID = ct.CompTypeID
order by
	pcd.SlotNum asc