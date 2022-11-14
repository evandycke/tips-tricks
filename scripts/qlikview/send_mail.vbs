SUB SendMail
	Dim objEmail

	Const cdoSendUsingPort = 2 	' Send the message using SMTP
	Const cdoBasicAuth = 1     	' Clear-text authentication
	Const cdoTimeout = 60      	' Timeout for SMTP in seconds

     mailServer = "smtp.gmail.com"
     SMTPport = 465
     mailusername = "MyAccount@gmail.com"
     mailpassword = "MyPassword"

     mailto = "destination@company.com" 
     mailSubject = "Subject line" 
     mailBody = "This is the email body" 

	Set objEmail = CreateObject("CDO.Message")
	Set objConf = objEmail.Configuration
	Set objFlds = objConf.Fields

	With objFlds
    	.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = cdoSendUsingPort
    	.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = mailServer
	.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = SMTPport
	.Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = True
    	.Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = cdoTimeout
	.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = cdoBasicAuth
	.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = mailusername
	.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = mailpassword
    	.Update
	End With

	objEmail.To = mailto
	objEmail.From = mailusername
	objEmail.Subject = mailSubject
	objEmail.TextBody = mailBody
	objEmail.AddAttachment "C:\report.pdf"
	objEmail.Send

	Set objFlds = Nothing
	Set objConf = Nothing
	Set objEmail = Nothing
END SUB