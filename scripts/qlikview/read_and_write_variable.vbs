FUNCTION getVariable(varName)
 set v = ActiveDocument.Variables(varName)
 getVariable = v.GetContent.String
END FUNCTION

SUB setVariable(varName, varValue)
 set v = ActiveDocument.Variables(varName)
 v.SetContent varValue, true
END SUB