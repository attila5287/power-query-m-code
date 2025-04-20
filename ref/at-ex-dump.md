```JS
// recursive_factorial
let
    factorial = (a) => if a > 0 then a + @factorial( a-1 ) else 0,
    res = factorial(22)
in
    res
```


```JS

// calcDiscountedPrice
(price_org, discount_perc) =>
let 
    perc_after = (down_perc) => (100-down_perc)/100,
    price_after = price_org * perc_after( discount_perc )
in
    price_after
```
```JS
// transformList
let
    my_list = { 30, 13, 12, 23 },
    my_function  = (val) => val*2,
    res = List.Transform(my_list, my_function)
in
    res
```
```JS
// findWorkingDays
// Use this file to write queries to test your data connector
(start as date, end as date) as number =>
let
    startDate = Date.From(start),
    endDate = Date.From(end),
    days = List.Dates(startDate, Duration.Days(endDate - startDate) + 1, #duration(1, 0, 0, 0)),
    workingDays = List.Select(days, each Date.DayOfWeek(_, Day.Monday) < 5),
    count = List.Count(workingDays)     
in
    count
```
```JS
// invFindWrk
let
    Source = findWorkingDays(#date(1988, 1, 1), #date(2022, 1, 1))
in
    Source
```
```JS
// countWorkingDays
(start as date, end as date ) as number =>
let
    days = if start < end 
    then { Number.From(start)..Number.From(end) } 
    else {Number.From(end)..Number.From(start)},
    transformed = List.Transform(days, each Number.Mod(_, 7)),
    removed = List.Select(transformed, each _>1 ),
    count = List.Count(removed)
in
    count
```
```JS
// invCountWrk
let
    Source = countWorkingDays(#date(1922, 1, 1), #date(1925, 1, 1))
in
    Source
```
```JS
// each_list
let
    list_function = (el) => el * el,
    each_function = each _*_,
    sample_list = { 0, 1, 2, 3, 11},
    use_each = List.Transform(sample_list, each_function),
    second_list = { 11, 12, 21},
    use_each_second = List.Transform(second_list, each_function)
in
    use_each_second

// concatText
(first_name, last_name, optional middle_name) => 
    Text.Combine(
        {
            first_name,
            middle_name,
            last_name
        },
        " "
        )
```
```JS
// concat_items
// Use this file to write queries to test your data connector
let
    courses = { "Course 1", "Course 2", "Course 3" },
    topics = { "Topic 1", "Topic 2", "Topic 3" },
    combined = List.Combine({courses, topics}),
    converted  = List.Transform(combined, Text.From),
    concatenated = Text.Combine(converted, " :: ")
in
    concatenated
```

```JS
// workdays_revised
let
    Source = ""
in
    Source
```
```JS
// wrk_days
let
    main = (start as date, end as date) as number =>
    let
        days = if start < end 
            then { Number.From(start)..Number.From(end) } 
            else { Number.From(end)..Number.From(start) },
        transformed = List.Transform(days, each Number.Mod(_, 7)),
        removed = List.Select(transformed, each _ > 1),
        count = List.Count(removed)
    in 
        count
in
    main(#date(1922, 1, 1), #date(1923, 1, 1))
```

```JS
// hello_world
let
    Source = "hello world"
in
    Source
```

```JS
// accumulate
// loop over list 
let
    src = { 123, 134, 144},
    double_item = (val)=> val*2,
    add_item = (val, idx)=>List.Combine({val,    {double_item(idx)}}),
    res  = List.Accumulate(src, 0, (add, val) => add + val)
in
    res
```

```JS

// iter_recursive
// loop over list
let
    iter_func = (i)=> if (i>0) then
    List.Combine({@iter_func(i-1), {i}}) else {},
    // res = iter_func(5)
    res = List.Accumulate(iter_func(5),{},(val, i)=>List.Combine({val, {i+10}}))
in
    res
```
```JS

// MyFunction
let
    NewFunc = (a,b) => a+b,
    UseFunc = NewFunc(1,2)  
in
    UseFunc

```

```JS

// OptionalArgFunction
let
    MultiplyFunc = (a as number, b as number, optional c as number) => a*b*(if c=null then 1 else c),
    Result  = MultiplyFunc(11,2,2)
in
    Result
```

```JS

// DivideFunction
let
    Divide = (a,b) => a/b

in
    Divide
```

```JS
// NestedFunction
let
    nested_function = (a,b) =>
    let 
        step1 = a+b,
        step2 = step1 + 100
    in  
        step2

in
    nested_function
```

```JS
// EachFunction
let
    each_function = each _  +1    
in
    each_function

// TransformTable
let
    my_table = Excel.CurrentWorkbook(){
        [Name = "CourseStudentTable"]
    }[Content],
    result = Table.TransformColumns(
        my_table, 
        {
            "Students",
            each _ +11
        }
    )
in
    result

```
```JS
// AddNumberToStu
let
    add_function = (row) => row+111
in
    add_function
```
```JS

// Query1
let
    Source = let
    Source = Excel.CurrentWorkbook(){
    [Name="CourseStudentTable"]
    }[Content],
    result = Table.AddColumn(
        Source,
        "CustomColumnResult",
        each AddNumberToStu([Students])  
    )
in
    Source
```

```JS

// NestedLet
let
    Source = let 
    sales = 100,
    numCourse = 12,
    result = sales/numCourse,
    profitCostRatio = 
        let 
            profit = 10,
            cost = 50
        in
            profit/cost
in
    result
in
    Source
```

```JS

// Capitalize (2)
let
    Source =Excel.CurrentWorkbook(){[Name="Courses"]}[Content],
    res = Table.TransformColumns(Source, {"Description", Text.Proper})
in
    res
```
```JS

// Record
let
    rec = [course="Excel", topiccost=11],
    nestRec = [
        rowKey=[name="PQ"],
        myKey=[name="PQ"]
    ],
    row = nestRec[rowKey],
    largeRec = [
        myList = {"el1", "el2"}
    ],
    myListFromRec = largeRec[myList]
in
    myListFromRec
```
```JS
// HelloCodingQry
let
    Source = Excel.CurrentWorkbook(){[Name="HelloCodingTable"]}[Content]
in
    Source
```
```JS
// HelloCodingSalesQry
let
    Source = Excel.CurrentWorkbook(){[Name="HelloCodingSalesTable"]}[Content]
in
    Source
```
```JS
// CombineHelloCoding
let     
    Source = Table.Combine({
        HelloCodingQry,
        HelloCodingSalesQry
    })
in
    Source
```
```JS
// JoinInnerHello
let
    Source = Table.Join(
        HelloCodingQry,
        {"Year", "Course"},
        HelloCodingSalesQry,
        {"Year", "Course"},
        JoinKind.Inner
    )
in
    Source
```
```JS
// EachFunction (2)
let
    each_function = each _  +1    
in
    each_function
```

```JS
// AddFunction
let
    add = (row) => row+1111
in
    add
```
```JS
// CustomColumnTable
let
    my_table = Excel.CurrentWorkbook(){
        [Name = "CourseStudentTable"]
    }[Content],
    res = Table.AddColumn(
        my_table,
        "CustomColumn",
        each #"AddFunction (2)"([Student])
    )  
in
    res
```
```JS
// AddFunction (2)
let
    add = (row) => row+1111
in
    add
```
```JS
// variables
let 
    sales = 100 + 90 +32 +40 +10,
    aff_rate  = 0.3,
    calc_affrev = (mySales, myAffRate)=>        mySales * myAffRate,
    result = calc_affrev(sales, aff_rate)
in
    result
```
```JS
// variablesFunction
let 
    calc_affrev = (mySales, myAffRate)=>        mySales * myAffRate
in
    calc_affrev
```
```JS
// generalized_id
let 
    Source = Excel.CurrentWorkbook(){[Name="CourseStudentTable"]}[Content]
in 
    Source
```
```JS
// regular_quoted_id
let
    regular_identifier = "[0-9a-zA-Z_]+",
    #"quoted _identifier" = "I am quoted",
    res = "safe"
in
    res
```
```JS
// scope_of_vars
let
    sales =100,
    new_sales = 
        let 
            res = sales +10
        in
            res,
    tax_rate = 1.2,

    res = "safe"
in
    sales + new_sales * tax_rate
```

```JS
// records
let         
    src = 10,
    src2 = rec,
    src3 = rec[sales], // not rec[source]
    rec = [sales = src], // rec[sales] same
    res =4
in
    src3
```
```JS
let
    Source = "m will only execute whats necessary, and will not exec the code up-down, please notice"
in
    Source
```

```JS

// row_count
let
    Source = Excel.CurrentWorkbook(){[Name="QuarterProfitsTable"]}[Content],
    result = Table.RowCount(
        Source
    )
in
    result
```
```JS

// group_multiple
// loop over list
let
    res = Table.Group(
    Table.FromRecords({
        [Q = 1, Mon="Jan", Profit = 20],
        [Q = 2, Mon="Apr", Profit = 10],
        [Q = 2, Mon="Apr", Profit = 20],
        [Q = 1, Mon="Jan", Profit = 10],
        [Q = 3, Mon="Sep", Profit = 20],
        [Q = 3, Mon="Sep", Profit =  5]
    }),
    {"Q"},
    {{"RowCount", each Table.RowCount(_), type number},
    {"ProfitTotal", each List.Sum([Profit]), type  number}}
)
in
    res
```

```JS
// group_rows
let
    Source = Excel.CurrentWorkbook(){[Name="QuarterProfitsTable"]}[Content],
    
    res = Table.Group(
        Source,
        {"Quarter"},
        {{
            "RowCount",
            each Table.RowCount(_),
            type number
        }}
   )

in
    res
```
```JS

// groupkind_global
// loop over list
let
    grouped = Table.Group(
    Table.FromRecords({
        [Dt = #date(2025,1,1),Course="Hello",Sales = 200],
        [Dt = #date(2025,1,1),Course="Excel",Sales = 100],
        [Dt = #date(2025,1,1),Course="Hello",Sales = 200],
        [Dt = #date(2025,1,1),Course="Excel",Sales = 300],
        [Dt = #date(2025,1,1),Course="Hello",Sales = 200]
    }),
    {"Course"},
        {"RowCount", each Table.RowCount(_), type nullable number},
    GroupKind.Global
    )
in
    grouped
```

```JS
// table_sort
let
	sorted = Table.Sort(
		Table.FromRecords({
			[Dt = #date(2025,1,1),Course="Hello",Sales = 200],
			[Dt = #date(2025,1,2),Course="Excel",Sales = 100],
			[Dt = #date(2025,1,3),Course="Hello",Sales = 200],
			[Dt = #date(2025,1,4),Course="Excel",Sales = 300],
			[Dt = #date(2025,1,1),Course="Hello",Sales = 200]
		}),
		{"Course", Order.Ascending}
    )
in
    sorted
```
```JS

// groupkind_local
// loop over list
let
    grouped = Table.Group(
    Table.FromRecords({
        [Dt = #date(2025,1,1),Course="Hello",Sales = 200],
        [Dt = #date(2025,1,1),Course="Excel",Sales = 100],
        [Dt = #date(2025,1,1),Course="Hello",Sales = 200],
        [Dt = #date(2025,1,1),Course="Excel",Sales = 300],
        [Dt = #date(2025,1,1),Course="Hello",Sales = 200]
    }),
    {"Course"},
        {"RowCount", each Table.RowCount(_), type nullable number},
    GroupKind.Local
    )
in
    grouped
```

```JS
// csv_remote
let 	
	url = "C:\Users\turkoza\Desktop\education\u-pq-alex\test\udemy\states.csv",
	Source = Csv.Document(Web.Contents(url),[Delimiter=",", Columns=2, Encoding=1252, QuoteStyle=QuoteStyle.None]),
	with_headers = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
	assigned_type = Table.TransformColumnTypes(with_headers,{{"state", type text}, {"Jan.", type nullable number}})
	
in
	with_headers

// build_table
// build tables with m

let 
		// Define the table structure
Source = #table( type table[
		Course =  text, 
		Sales =  number
	],
	{{"Couse Intro", "1645"},
	{"Couse Advcd", 2121}}
)

in 
Source
```

```JS
// table-row-index
(user_input_id) =>
    let 
        src =  Table.FromRecords({
            [Course="MCode",CourseID = 01],
            [Course="Excel",CourseID = 02],
            [Course="PQ"   ,CourseID = 03],
            [Course="PY"   ,CourseID = 04],
            [Course="JS"   ,CourseID = 05] 
        })
    in
        src{[CourseID = user_input_id ]}

// Invoked Function
let
    Source = #"table-row-index"(1)
in
    Source
```

```JS
// concat-strings
// We cannot apply operator + to types Text and Number.
// The operator + is not defined for these types. The operator + is only defined for Text and Text, Number and Number, and DateTime and DateTime.
// the operator ampersand & is used to concatenate strings in Power Query M language
let
    // res = "string" & Text.From(5)
    res = "string" & Number.ToText(5)

in
    res

```

```JS
// e60 function in a record
let
  rec = [
    calcRev = (x,y) => x * y,
    sales    = 12345 ,
    price    = 100 ,
    res    =  calcRev(sales, price)
  ]
  in
    rec
```

```JS
// e70-fill table with random vals
let
  Source = {1..10},
  genRandom = Number.RoundDown(Number.RandomBetween(1, 100)),
  genRandomF =()=> Number.RoundDown(Number.RandomBetween(1, 100)),

  listOfRecs = List.Transform(
    Source,
    each [
      x=_, 
      y1= genRandom,
      y2= () => Number.RoundDown(Number.RandomBetween(1, 100)),
      y3= genRandomF(),
      y4=Number.RoundDown(Number.RandomBetween(1, 100))
    ]
  ),
  tableRandom = Table.ExpandRecordColumn(
    Table.FromList(
      listOfRecs, 
      Splitter.SplitByNothing()
    ),
   "Column1",
    {"x", "y1", "y2", "y3", "y4"}
  ),

  res = tableRandom
in
  res
```
```JS
// e39-table-indexColumn
let
  Source = Table.FromRows(
  { 
    {"Hello"}, 
    {"World" },
    {null},
    {"lorem" },
    {"ipsum" },
    {"dolor"},
    {"sit"  },
    {"amet" }
  },
    {"Value"}
  ),
  indexed = Table.AddIndexColumn(
    Source, 
    "index" 
  ),
  addTextLength = Table.AddColumn(
    indexed, 
    "isTextShort", 
    each 
    if Text.Length([Value]) > 3  
    then "No" 
    else "Yes"
  ),
  addNewColumn = Table.AddColumn(
    addTextLength,
    "newColumn",
    each _[Value] ?? _[Value] & _[isTextShort],
    type text
  ),
  removeColumns = Table.RemoveColumns(
    addNewColumn, 
    "index"
  ),
  selectedRows = Table.SelectRows(
    removeColumns, 
    each _[Value] <> null and _[isTextShort] = "No"
  ),
  res = selectedRows
in
  res
```
```JS

// e40-table-recordToList
let
  source = Table.FromRows(
    {
      {"Arya","21 Main St","Vail","CO","80101"},
      {"Bran","51 High Rd","Vail","CO","80101"},
      {"Cate","81 East Rd","Vail","CO","80101"},
      {"Dany","81 West St","Vail","CO","80101"} 
    },
    {"Name", "Street", "City", "State", "Zip"}
  ),
  changedType = Table.TransformColumnTypes(
    source, 
    {{"Name", type text}, {"Street", type text}, {"City", type text}, {"State", type text}, {"Zip", type text }}
  ),

  addAddress = Table.AddColumn(
    changedType, 
    "Address", 
    each Text.Combine( Record.ToList(_), " "
    )       
  )

in
  addAddress

```
```JS
// e41-table-calcPerc
let
	source =	Table.FromRecords({
			[Course="Hello",Sales = 200],
			[Course="Excel",Sales = 100],
			[Course="World",Sales = 200] 
  }),
  grouped = Table.Group(
    source, 
    {}, 
    {
      {"Sum",  each List.Sum([Sales]), type nullable number}
    }
  ),
  sumSales = grouped{0}[Sum],
  sourceCopy = source, // avoid modifying original table
  addSalesCol = Table.AddColumn(sourceCopy, "Sum", each  sumSales),
  addSalesPerc = Table.AddColumn(addSalesCol, "SalesPerc", each [Sales] / sumSales * 100)
in
  addSalesPerc

// e42-table-rank
let
  // Create a table with records containing Course names and their corresponding Sales values
  source = Table.FromRecords({
    [Course="Mcode", Sales=2040],
    [Course="Power", Sales=2030],
    [Course="Query", Sales=2020]
  }),

  // Create a copy of the source table for further processing
  sourceCopy = source,

  // Define a function to count the number of rows in the table where Sales is greater than a given value
  compareRows = (row) => Table.RowCount(
    Table.SelectRows(
      sourceCopy, // Use the sourceCopy table
      each [Sales] > row[Sales] // Filter rows where the Sales value is greater than the input value
    )
  ),

  // Add a new column named "Rank" to the sourceCopy table
  // The value of the "Rank" column is calculated using the rankFunction for each row
  addCol = Table.AddColumn(
    sourceCopy, // The table to which the column will be added
    "Rank", // Name of the new column
    each compareRows(_) // Calculate the rank for each row based on the Sales value
  )
in
  // Return the final table with the added "Rank" column
  addCol
```

```JS
// e43-table-distinctCount
let  // s43 count distinct values 

  source = Table.FromRecords({
    [Course="Power", Date= #date(2025, 1,10)],
    [Course="Power", Date= #date(2025, 1,10)],
    [Course="Power", Date= #date(2025, 1,10)],
    [Course="Mcode", Date= #date(2025, 1,10)],
    [Course="Mcode", Date= #date(2025, 1,10)],
    [Course="Mcode", Date= #date(2025, 1,10)],
    [Course="Power", Date= #date(2025, 1,11)],
    [Course="Power", Date= #date(2025, 1,11)],
    [Course="Power", Date= #date(2025, 1,11)],
    [Course="Mcode", Date= #date(2025, 1,11)],
    [Course="Mcode", Date= #date(2025, 1,11)],
    [Course="Mcode", Date= #date(2025, 1,11)],
    [Course="Query", Date= #date(2025, 1,11)],
    [Course="Query", Date= #date(2025, 1,11)],
    [Course="Query", Date= #date(2025, 1,11)],
    [Course="Query", Date= #date(2025, 1,11)],
    [Course="Query", Date= #date(2025, 1,11)]
  }),
  dateType = Table.TransformColumnTypes(source,{{"Date", type date}}),
  // remove duplicates so the output is distinct values
  removeDups= Table.Distinct(
    dateType, 
    {"Course", "Date"}    
  ),

  groupedDate = Table.Group(
    removeDups, 
    {"Date"}, 
    {
      {
        "DistinctCourseCount",
        each Table.RowCount(_), type number
      }
      }
  ),
  res = groupedDate
in
  res
```
```JS

// e49-nested-expression
// s49 nested expressions
let
    retail = let priceRet = 19.99, qtySoldRet = 100 in priceRet * qtySoldRet,
    wholesale = let priceWh = 9.99, qtySoldWh = 500 in priceWh * qtySoldWh,
    totalSales = retail + wholesale
in
    totalSales // $6,994
```
```JS
// e50-list-sequence
// s50 build a list with sequene
let
    source = {
        1,2,3,
        4..20,
        21, 
        -2,
        10
    }
in
    source

// e51-unnamed-rec-underscore
// s51 unnamed record
let
    _  = [
      worksWithoutRec = "try without record name _, still works"
    ],
    recSample = [
      course = "Hello World",
      sales = 1234,
      onlyWorksWithRec = "try without record name, will not work"
    ]
in
    [worksWithoutRec] 
```
// [onlyWorksWithRec]  // this will not work
// recSample[onlyWorksWithRec]  // only with record name

// e52-each-with-records
// s52 each on record
```JS

let 
  // same functions, different syntax   
  eachFunction = each _[price]*_[qty],
  eachFunction2 = (_) => _[price]*_[qty],
  courseRec = [
    name = "Power Query",
    price = 100,
    qty = 1227
  ]
in
  eachFunction(courseRec)

```

```JS
// e53-list-generate
// s53 list generate
let
   // start, finish, increment as function
    listGenUp = List.Generate(
        () => 1, each _ < 100, each _ + 5
    ) as list,

    listGenDown = List.Generate(() => 15, each _ > 0, each _ *0.9-1) as list 
in
    // listGenDown 
    listGenUp
// List.Generate(
//   initial as function,
//   condition as function,
//   next as function,
//   optional selector as nullable function
// ) as list

// e54-find-recEntry
// s54 find an entry in a record
// Let's first build out a function to find a property and we're going to use the each keyword and search
let
    propsFinder = each [name],
    rec = [
        name="Mcode", 
        desc="advanced",
        duration="50 hrs"
    ]
in
    propsFinder(rec) // Mcode expected

// e55-list-select-records
// s55 select from list
let
  recordsList = {
    [Exp=123,Budget=123,Region="East"],
    [Exp=233,Budget=213,Region="West"],
    [Exp=100,Budget=120,Region="North"],
    [Exp=200,Budget=180,Region="South"]   
  },
  // List.Select(list as list, selection as function) as list

  overBudget = List.Select(
    recordsList, 
    each [Exp]  > [Budget]
  ) as list,

  overBudgetTable = Table.FromList(
    overBudget,
    Record.FieldValues,
    {"Exp","Budget","Region"}
  )

in  
    overBudgetTable

//   overBudget{0}[Region] // east

// e56-serialize-a-column
//  s56 List.InsertRange(list as list, index as number, values as list) as list
let
    serialFunc = (inputList as list) as text => 
        let 
            countItems = List.Count(inputList),
            convertToText = List.Transform(
                inputList, 
                each Text.From(_)
            ),
            // insert "and" before last item
            addAndKeyword = 
                if countItems > 1 // two or more items
                then List.InsertRange(
                    convertToText,  //input list to add "and"
                    countItems - 1, // index: last item 
                    {"and"} // values as list: 
                ) 
                else convertToText, // if one item, return as is
            serialized = 
                if countItems > 2 
                then List.Transform(
                    List.FirstN( addAndKeyword,  countItems - 1),
                    each _ & ","
                    ) & List.LastN( addAndKeyword, 2)
                else addAndKeyword,
            
            resultFunction = Text.Combine(
                serialized,
                " "                    
            )
        in
            resultFunction,

    testInput = {"arya", "bran", "cate", "dany" },
    res = serialFunc(testInput) 
in
    res

// e57-find best match
// s57 - find best match function counts the rows of a table which was already partitioned by Sample
let
  findBestMatch = (inputTable as table) =>
    let
      source = inputTable,
      grouped=Table.Group(
        source,
        {"Sample"},
        {
          {"Count", each Table.RowCount(_), Int64.Type}
        } 
      ),
      resultFunction = grouped
    in
      resultFunction,

  testInputTable = Table.FromRecords(
    {
      [ Sample = "A", Category = "Dog"  ],
      [ Sample = "A", Category = "Dog"  ],
      [ Sample = "A", Category = "Cat"  ],
      [ Sample = "B", Category = "Cat"  ],
      [ Sample = "B", Category = "Cat"  ],
      [ Sample = "B", Category = "Dog"  ],
      [ Sample = "C", Category = "Cat"  ],
      [ Sample = "A", Category = "Plant"],
      [ Sample = "C", Category = "Plant"],
      [ Sample = "C", Category = "Plant"]
    }
  ),
  Table = let 
      grouped = Table.Group(
        testInputTable,
        {"Category"},
        {
          {"All", each _, type table}
        } 
      ),
      bestMatch = Table.AddColumn(
        grouped,
        "BestMatch",
        each findBestMatch([All])
      ),
      resTable = bestMatch
    in
      resTable,


  res =findBestMatch(Table)
in
  res
```

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