SUB DocumentOpen
  ActiveDocument.Sheets("Intro").Activate
  ActiveDocument.ClearAll (true)
  ActiveDocument.Fields("YearMonth").Select ActiveDocument.Evaluate("Date(MonthStart(Today(), 0),'MMM-YYYY')")
END SUB