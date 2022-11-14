SUB BlockObjects

for s = 0 to ActiveDocument.NoOfSheets - 1
    set vSheet = ActiveDocument.GetSheet(s)
	Objects = vSheet.GetSheetObjects
	For i = lBound(Objects) To uBound(Objects)
		set vObject = Objects(i)
		set vObjectFrame = vObject.GetFrameDef
		vObjectFrame.AllowMoveSize = false
		vObject.SetFrameDef vObjectFrame
	Next
next

END SUB