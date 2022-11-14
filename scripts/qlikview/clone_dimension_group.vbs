SUB DuplicateGroups 
    SourceGroup = InputBox("Enter Source Group Name") 
    CopiesNo = InputBox("How many copies?") 
    SourceGroupProperties = ActiveDocument.GetGroup(SourceGroup).GetProperties 
    FOR i = 1 TO CopiesNo 
      SET DestinationGroup = ActiveDocument.CreateGroup(SourceGroupProperties.Name & "_" & i) 
      SET DestinationGroupProperties = DestinationGroup.GetProperties 

      IF SourceGroupProperties.IsCyclic THEN 
        DestinationGroupProperties.IsCyclic = true 
      ELSE
        DestinationGroupProperties.IsCyclic = false
      END IF
      DestinationGroup.SetProperties DestinationGroupProperties

      SET Fields = SourceGroupProperties.FieldDefs 
      FOR c = 0 TO Fields.Count-1 
        SET fld = Fields(c) 
        DestinationGroup.AddField fld.name 
      NEXT
      Application.waitforidle 
    NEXT 
END SUB