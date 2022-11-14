SUB AddConditionalExpressionToExistingChart

set chart = ActiveDocument.GetSheetObject("CH01")
    ExpNo = chart.AddExpression( "sum( Expression1 )")

set cp = chart.GetProperties
set ExpVis = cp.Expressions.Item(ExpNo).Item(0).Data.ExpressionVisual

ExpVis.Label.v = "Sales"
ExpVis.NumAdjust = 1      'center
ExpVis.LabelAdjust = 1    'center

set ExpCond= cp.Expressions.Item(ExpNo).Item(0).Data.EnableCondition

ExpCond.Type = 2
ExpCond.Expression = "sum( Expression1 ) > 0"

chart.SetProperties cp

END SUB