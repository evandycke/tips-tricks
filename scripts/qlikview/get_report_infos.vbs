function countReports
	set ri = ActiveDocument.GetDocReportInfo
	countReports = ri.Count
end function

function getReportInfo (i)
	set ri = ActiveDocument.GetDocReportInfo
    set r = ri.Item(i)
    getReportInfo = r.Id & "," & r.Name & "," & r.PageCount & CHR(10)
end function