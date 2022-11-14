FUNCTION ExcelExport(objID)
  set obj = ActiveDocument.GetSheetObject( objID )
  w = obj.GetColumnCount
  if obj.GetRowCount>1001 then
    h=1000 
  else h=obj.GetRowCount
  end if
  Set objExcel = CreateObject("Excel.Application")
  objExcel.Workbooks.Add
  objExcel.Worksheets(1).select()
  objExcel.Visible = True
  set CellMatrix = obj.GetCells2(0,0,w,h)
  column = 1
  for cc=0 to w-1
   objExcel.Cells(1,column).Value = CellMatrix(0)(cc).Text
   objExcel.Cells(1,column).EntireRow.Font.Bold = True
   column = column +1
  next
  c = 1
  r =2
  for RowIter=1 to h-1 
    for ColIter=0 to w-1 
      objExcel.Cells(r,c).Value = CellMatrix(RowIter)(ColIter).Text
      c = c +1
    next
   r = r+1
   c = 1
 next
END FUNCTION

SUB CallExample
   ExcelExport( "CH01" )
END SUB