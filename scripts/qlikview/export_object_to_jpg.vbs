FUNCTION ExportObjectToJpg( ObjID, fName)
   ActiveDocument.GetSheetObject(ObjID).ExportBitmapToFile fName
END FUNCTION

SUB CallExample
   ExportObjectToJpg "CH01", "C:\CH01Image.jpg" 
END SUB