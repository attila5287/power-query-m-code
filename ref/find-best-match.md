# FIND BEST MATCH

```JS
let
  // #region PQ SDK test env
  testInputTable = Table.FromRows(
    {
      {"Address","City","Zip"},
      {"PO Bo", "Breckenridge","81217"}, 
      {"PO Box", "Denver",  "80203-10000"},
      {"P O B", "Denver",  "80203"},
      {"P. O ", "Co Spgs", "80204"},
      {"P.O. ", "Lakewood","80205"},
      {"PO Bo", "Thornton","80206"},
      {"P. O.", "Canon City","81215-10100" },
      {"3 fail","Denver",  "80203" },
      {"3 SUCS","Denver",  "80203" },
      {"3 SUCS","Denver",  "80203-10000" },
      {"4 fail","Co Sprg", "80204" },
      {"4 SUCS","Colo Spg","80204-10000" },
      {"4 SUCS","Co Spgs", "80204" },
      {"5 fail","Lakewood","80205" },
      {"5 SUCS","Lakewood","80205" },
      {"5 SUCS","Lakewood","80205-10000" },
      {"6 fail","Thornton","80206" },
      {"6 SUCS","Thornton","80206" },
      {"6 SUCS","Thornton","80206-10000" },
      {"7 fail","Canon City","81218" },
      {"7 SCCS","Canon City","81216-10000" },
      {"7 SCCS","Canon City","81216" }
    },
    {"Column1","Column2","Column3"}
  ),
  helperBestMatch = (inputTable as table, inputCity as text) =>
  let
    src = inputTable,
    filtered = Table.SelectRows(
      src, 
      each Text.Upper([City]) = Text.Upper(inputCity) and not [isPOBox]
    ),
    excluded = Table.SelectRows(
      src, 
      each Text.Upper([City]) = Text.Upper(inputCity) and [isPOBox]
    ),
    
    addCompKey = Table.AddColumn(
      excluded, 
      "Key", 
      each [Address] & [City] & [Zip]
    ),
    
    recordsListPOBox = List.Transform(
      Table.ToRecords(addCompKey),
      each [
        key = [Key],
        details = [
          Address = [Address],
          City = [City],
          Zip = [Zip]
        ]
      ]
    ),
    
    grouped = Table.Group(
      filtered, {"City", "Address", "Zip"}, 
      {{"Count", each Table.RowCount(_), type number}}
    ),

    sorted = Table.Sort(
      grouped, {{"Count", Order.Descending }}
    ),

    outputRec = [
        Address=sorted{0}[Address],
        City   =sorted{0}[City],
        Zip    =sorted{0}[Zip]
    ],

    nullRec = [
        Address= null ,
        City   = null ,
        Zip    = null
    ],
  
    res = recordsListPOBox{0}[details]
    // res = sorted
    // res= if Table.IsEmpty(filtered) then  nullRec else  outputRec
  in
    res
  ,
  // #endregion

  // -------- M A I N  ----------
  changedType  = Table.TransformColumnTypes(
    Table.PromoteHeaders(testInputTable), 
    {
      {"Address", type text},
      {"City", type text}, 
      {"Zip", type text}
    }
  ),
  upperCaseAll = Table.TransformColumns(
    changedType,
  {    
    {"Address", Text.Upper},
    {"City",    Text.Upper},
    {"Zip",     Text.Upper}
  }),
  
  // targetListPOBox = listUniquePOBox(upperCaseAll),
  targetListPOBox = {
    "P. O ",
    "P.O. ",
    "P.O.B",
    "P. O.",
    "P O B",
    "PO BO"
  },
  addFlagPOBox = Table.AddColumn(
    upperCaseAll , "isPOBox", 
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
    addBestMatchZip, 
    {
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
  // res = listUniquePOBox(testPOBoxTable)
  // res = helperBestMatch(addFlagPOBox, "denver")
in
    res
```