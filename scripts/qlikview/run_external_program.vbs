FUNCTION RunExe(cmd)   
   CreateObject("WScript.Shell").Exec(cmd)
END FUNCTION

SUB CallExample
   RunExe("c:\Program Files\Internet Explorer\iexplore.exe")
END SUB