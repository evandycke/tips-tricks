SUB InsertValues

 cust = getVariable("vCustomer")
 val = getVariable("vSales")

 SET Result = ActiveDocument.DynamicUpdateCommand ("INSERT INTO * (Customer, Sales) VALUES ('" & cust & "', " & val & ");")
	
 if Result = false then
    MsgBox Result.ErrorMessage
 end if  

END SUB

SUB UpdateValues

 cust = getVariable("vCustomer")
 val = getVariable("vSales")

 SET Result = ActiveDocument.DynamicUpdateCommand ("UPDATE * SET Sales = " & val & " WHERE Customer = '" & cust & "'")
	
 if Result = false then
    MsgBox Result.ErrorMessage
 end if  

END SUB

SUB DeleteValues

 cust = getVariable("vCustomer")
 val = getVariable("vSales")

 SET Result = ActiveDocument.DynamicUpdateCommand ("DELETE FROM SALES_TABLE WHERE Customer = '" & cust & "' and Sales = " & val)
	
 if Result = false then
    MsgBox Result.ErrorMessage
 end if  

END SUB