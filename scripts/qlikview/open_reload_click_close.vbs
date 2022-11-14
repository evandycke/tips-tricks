Set MyApp = CreateObject("QlikTech.QlikView")
Set MyDoc = MyApp.OpenDoc ("C:\QlikViewApps\Demo.qvw","","")
Set ActiveDocument = MyDoc
ActiveDocument.Reload
Set Button1 = ActiveDocument.GetSheetObject("BU01")
Button1.Press
MyDoc.GetApplication.Quit
Set MyDoc = Nothing
Set MyApp = Nothing