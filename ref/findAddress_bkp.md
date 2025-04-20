### backup before implement FIND_UNIQUE_CITIES

`this query works with our raw input qry03 from access db`
`with the new imp we need to transform our raw input to get`
`rid of repetiting city names so we would be able to`
`find more matches (ex:Grnd Jct doesn't match Grand Junction)`

```JS
let
  // #region only for PQ-SDK test env
  targetListPOBox = {
    "P. O ",
    "P.O. ",
    "P. O.",
    "P O B",
    "PO BO"
  },

  helperBestMatch = 
    (inputTable as table, inputCity as text) as record =>
    let
      source = inputTable,
      filtered = Table.SelectRows(
        source, 
        each [City] = inputCity and not [isPOBox]
      ),

      addTruncZip = Table.AddColumn(
        filtered,
        "truncZip",
        each Text.Start([Zip],5)
      ),
      
      grouped = Table.Group(
        addTruncZip, {"City", "Address", "truncZip"}, 
        {{"Count", each Table.RowCount(_), type number}}
      ),

      sorted = Table.Sort(
        grouped, {{"Count", Order.Descending }}
      ),

      outputRec = [
          Address=sorted{0}[Address],
          City   =sorted{0}[City],
          Zip    =sorted{0}[truncZip]
      ],

      nullRec = [
          Address= null ,
          City   = null ,
          Zip    = null
      ],
      
      res= if Table.IsEmpty(filtered) 
        then  nullRec
        else  outputRec
    in
      res
  ,
  testInputTable = Table.FromRecords(
  {
    [Address="PO Bo", City="Breckenridge",Zip="81217"],  
    [Address="P O B", City="Denver",  Zip="80203"],
    [Address="P. O ", City="Co Spgs", Zip="80204"],
    [Address="P.O. ", City="Lakewood",Zip="80205"],
    [Address="PO Bo", City="Thornton",Zip="80206"],
    [Address="P. O.", City="Canon City",Zip="81215-1010"],
    [Address="3 fail",City="Denver",  Zip="80203"],
    [Address="3 SUCS",City="Denver",  Zip="80203"],
    [Address="3 SUCS",City="Denver",  Zip="80203-10000"],
    [Address="4 fail",City="Co Sprg", Zip="80204"],
    [Address="4 SUCS",City="Colo Spg",Zip="80204-10000"],
    [Address="4 SUCS",City="Co Spgs", Zip="80204"],
    [Address="5 fail",City="Lakewood",Zip="80205"],
    [Address="5 SUCS",City="Lakewood",Zip="80205"],
    [Address="5 SUCS",City="Lakewood",Zip="80205-10000"],
    [Address="6 fail",City="Thornton",Zip="80206"],
    [Address="6 SUCS",City="Thornton",Zip="80206"],
    [Address="6 SUCS",City="Thornton",Zip="80206-10000"],
    [Address="7 fail",City="Canon City",Zip="81218"],
    [Address="7 SCCS",City="Canon City",Zip="81216-10000"],
    [Address="7 SCCS",City="Canon City",Zip="81216"]
  }),
  // #endregion


  changedType  = Table.TransformColumnTypes(
    testInputTable, 
    {
      {"Address", type text},
      {"City", type text}, 
      {"Zip", type text}
    }
  ),
  

  addFlag = Table.AddColumn(
    changedType, "isPOBox", 
    each List.Contains( targetListPOBox, 
      Text.Upper(Text.Start([Address],5))
    ) 
  ) ,
  
  addFlagPOBox = Table.AddColumn(
    changedType, "isPOBox", 
    each List.Contains( targetListPOBox, 
      Text.Upper(Text.Start([Address],5))
    ) 
  ),
  
  addBestMatchAddress = Table.AddColumn(
    addFlagPOBox, "BestMatchAddress", 
    each if [isPOBox] and helperBestMatch(addFlagPOBox,[City])[Address] <> null
    then helperBestMatch(addFlagPOBox,[City])[Address]
    else [Address]
  ),
 
  addBestMatchCity = Table.AddColumn(
    addBestMatchAddress, 
    "BestMatchCity", 
    each if [isPOBox] and helperBestMatch(addFlagPOBox,[City])[City] <> null
    then helperBestMatch(addFlagPOBox,[City])[City]
    else [City]
  ),

  addBestMatchZip = Table.AddColumn(
    addBestMatchCity, 
    "BestMatchZip", 
    each if [isPOBox] and helperBestMatch(addFlagPOBox,[City])[Zip] <> null
    then helperBestMatch(addFlagPOBox,[City])[Zip]
    else [Zip]
  ),

  reOrderedCols = Table.ReorderColumns(
    addBestMatchZip, { 
      "BestMatchAddress",  
      "BestMatchCity",  
      "BestMatchZip",  
      "Address", 
      "City", 
      "Zip", 
      "isPOBox"
      }
  ),

  sortedByFlag = Table.Sort(
    reOrderedCols, {{"isPOBox", Order.Descending}}
  ),
  
  res = sortedByFlag
in
    res
 ```