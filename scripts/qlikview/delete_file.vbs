FUNCTION DeleteFile(rFile)
	set oFile = createObject("Scripting.FileSystemObject")

	currentStatus = oFile.FileExists(rFile)

	if currentStatus = true then
		oFile.DeleteFile(rFile)
	end if
	set oFile = Nothing
END FUNCTION

SUB CallExample
    DeleteFile ("C:\MyFile.PDF") 
END SUB