FUNCTION ExportObjectToJpg(SheetID, ObjID, fName)
  set s=ActiveDocument.GetSheetById(SheetID)
  set sp=s.GetProperties
  sp.Show.Always = true
  s.SetProperties sp
  s.Activate
  for i=0 to s.NoOfSheetObjects-1
      if s.SheetObjects(i).GetObjectId = ObjID then 
          ActiveDocument.GetApplication.WaitforIdle
          s.SheetObjects(i).ExportBitmapToFile fName
      end if    
  next
END FUNCTION

SUB setVariable(varName, varValue)
 set v = ActiveDocument.Variables(varName)
 v.SetContent varValue, true
END SUB

SUB CallExample
  ' "vShow" is the variable which controls the visibility of the sheet: Sheet properties -> Show Sheet -> Conditional: =vShow
  setVariable "vShow", 1 
  set ss= ActiveDocument.GetSheet(0)
  ExportObjectToJpg "Document\SH02", "Document\CH01", "D:\CH01Image.jpg" 
  ActiveDocument.GetSheetById(ss.GetProperties.SheetId).Activate
  setVariable "vShow", 0 ' replace 0 with your own condition to hide the sheet
END SUB