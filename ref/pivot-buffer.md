```js
let
  Source = Table.FromRecords({   
    [Topic="Dev" ,Course="THREE.JS" ],
    [Topic="Data",Course="M-Code" ],
    [Topic="Dev" ,Course="REACT.JS" ],
    [Topic="Data",Course="SQL" ],
    [Topic="Dev" ,Course="NEXT.JS" ],
    [Topic="Data",Course="Tableau" ]
  }),

  pivotColNames = List.Buffer( 
    List.Distinct(
      Table.Column(
        Source,
        "Topic"
      )
    )
  ),
  pivotedColumns = Table.Pivot(
    Source,
    pivotColNames,
    "Topic",
    "Course",
    each _
  ),


  res=pivotedColumns
in
  res


```