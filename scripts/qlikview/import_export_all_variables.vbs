Sub ImportVariablesFromExcel

' Imports all variable definitions from the Excel file specified in the variable 'v.Filename.Variables', 
' The path to the Excel file needs to be in a relative format.
'
' Variable definitions need to be placed on a worksheet named 'Variables' and containing the following columns:
'
'	1: Variable, name of the variable.
'
'	2: Expression, expression or value of the variable. Prefix with ' when starting with =, otherwise Excel tries
'	   to interpret the expression as an Excel formula.
'
'	3: Comment, comments for the variable.

	Set doc = ActiveDocument
	Set wbFilename = ActiveDocument.GetVariable("v.Filename.Variables")

	If wbFilename is Nothing then

		' The variable that stores the location of the variables Excel file does not exist
		MsgBox "The required variable 'v.Filename.Variables' does not exists!", 16, "Error"

	Else

		If Instr(Lcase(wbFilename.GetRawContent), "xls") = 0 then

			' The variable exists, but does not contain a valid Excel filename (based on looking for the 'xls' part)
			MsgBox "No valid Excel filename specified in variable 'v.Filename.Variables'", 16, "Error"

		Else

			'Get the path of the current QVW       		
       		QvwPath = Left(ActiveDocument.GetProperties.Filename, InStrRev(ActiveDocument.GetProperties.Filename, "\"))

       		' Initialize Excel, open the file and get a reference to the Variables worksheet
       		Set objExcel = CreateObject("Excel.Application")
       		Set objWorkbook = objExcel.Workbooks.Open(QvwPath & wbFilename.GetRawContent)
       		Set objSheet = objWorkbook.Sheets("Variables")

       		' Ignore the header by starting on the second row
       		i = 2

       		' Create a new variable (or overwrite if it already exists) for each row in the worksheet
       		Do while not IsEmpty(objSheet.Cells(i, 1))

            	doc.CreateVariable(objSheet.Cells(i, 1).Value)

              	Set v = doc.Variables(objSheet.Cells(i, 1).Value)

              	v.SetContent objSheet.Cells(i, 2).Value, true
              	v.SetComment objSheet.Cells(i, 3).Value

              	i = i + 1

       		Loop

			' Close Excel, otherwise we'll be left with running instances in the background
			objWorkbook.Saved = True
			objWorkbook.Close
			objExcel.Quit

			Set objSheet = Nothing
			Set objWorkbook = Nothing
          	Set objExcel = Nothing

		End If

	End If

End Sub  

Sub ExportVariablesToExcel

' Exports all variables, with the exception of QlikView specific variables, to a new
' Excel workbook in a worksheet called 'Variables', this sheet contains 3 columns:
'
'	1: Variable, name of the variable.
'
'	2: Expression, expression or value of the variable. Prefix with ' when starting with =, otherwise Excel tries
'	   to interpret the expression as an Excel formula.
'
'	3: Comment, comments for the variable.

	Set doc = ActiveDocument

	Set objExcel = CreateObject("Excel.Application")
	Set objWorkbook = objExcel.Workbooks.Add
    Set objSheet = objWorkbook.Sheets.Add

    objSheet.Name = "Variables"   
	objSheet.Cells(1, 1).Value = "Variable"
 	objSheet.Cells(1, 2).Value = "Expression"
 	objSheet.Cells(1, 3).Value = "Comment"

	Set vars = ActiveDocument.GetVariableDescriptions

	r = 2

	For i = 0 to vars.Count - 1

		Set v = vars.Item(i)

            ' Exclude all QlikView specific variables
			If not v.IsConfig and not v.IsReserved then

				objSheet.Cells(r, 1).Value = v.Name

                ' Excel treats expressions starting with = as an Excel formula, 
                ' so prefix with ' to indicate that it should be treated as text
                if Left(v.RawValue, 1) = "=" then			
					objSheet.Cells(r, 2).Value = "'" & v.RawValue
				else
					objSheet.Cells(r, 2).Value = v.RawValue
				end if

				objSheet.Cells(r, 3).Value = ActiveDocument.Variables(v.Name).GetComment

			r = r + 1
			end if

       next

	' Show Excel so the exported variables can be inspected before saving
	objExcel.Visible = True

End Sub