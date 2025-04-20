```JS
let
// #region PQ SDK test env
    Source = Table.FromRows(
        {
            {"Address", "City", "Zip"},
            {"PO Bo", "Breckenridge", "81217-SUCCS"},
            {"P.O.B", "Denver", "80203_10000"},
            {"PO Box", "Denver", "80234-10000"},
            {"P O B", "Denver", "80235"},
            {"P. O ", "Co Spgs", "80204"},
            {"P.O. ", "Lakewood", "80205"},
            {"PO Bo", "Thornton", "80206"},
            {"P. O.", "Canon City", "81215-10100"},
            {"1 fail", "Denver", "80203"},
            {"1 SUCS", "Denver", "80001-SUCCS"},
            {"1 SUCS", "Denver", "80001-SUCCS"},
            {"2 fail", "Co Sprg", "80204"},
            {"2 SUCS", "Colo Spg", "80204-10000"},
            {"2 SUCS", "Co Spgs", "80204"},
            {"3 fail", "Lakewood", "80205"},
            {"3 SUCS", "Lakewood", "80205"},
            {"3 SUCS", "Lakewood", "80205-10000"},
            {"4 fail", "Thornton", "80206"},
            {"4 SUCS", "Thornton", "80206"},
            {"4 SUCS", "Thornton", "80206-10000"},
            {"5 fail", "Canon City", "81218"},
            {"5 SCCS", "Canon City", "81216-10000"},
            {"5 SCCS", "Canon City", "81216"}
        },
        {"Column1", "Column2", "Column3"}
    ),
    targetListPOBox = {"P. O ", "P.O. ", "P.O.B", "P. O.", "P O B", "PO BO"},
// #endregion

// #region MAIN
    // -------- M A I N  ----------
    changedType = Table.TransformColumnTypes(
        Table.PromoteHeaders(Source), {{"Address", type text}, {"City", type text}, {"Zip", type text}}
    ),
    upperCaseAll = Table.TransformColumns(
        changedType, {{"Address", Text.Upper}, {"City", Text.Upper}, {"Zip", Text.Upper}}
    ),
    addFlagPOBox = Table.AddColumn(
        upperCaseAll, "isPOBox", each List.Contains(targetListPOBox, Text.Upper(Text.Start([Address], 5)))
    ),
    excluded = Table.SelectRows(addFlagPOBox, each [isPOBox]),
    addCompKey = Table.AddColumn(excluded, "Key", each [Address] & [City] & [Zip]),
    recsPOBox = Record.FromList(
        List.Transform(Table.ToRecords(addCompKey), each [
            Address = [Address],
            City = [City],
            Zip = [Zip]
        ]),
        List.Transform(Table.ToRecords(addCompKey), each [Key])
    ),
    addBestMatchAddress = Table.AddColumn(
        addCompKey,
        "BestMatchAddress",
        each
            if [isPOBox] and helperBestMatch(addFlagPOBox, [City])[Address] <> null then
                helperBestMatch(addFlagPOBox, [City])[Address]
            else
                [Address]
    ),
    addBestMatchCity = Table.AddColumn(
        addBestMatchAddress,
        "BestMatchCity",
        each
            if [isPOBox] and helperBestMatch(addFlagPOBox, [City])[City] <> null then
                helperBestMatch(addFlagPOBox, [City])[City]
            else
                [City]
    ),
    addBestMatchZip = Table.AddColumn(
        addBestMatchCity,
        "BestMatchZip",
        each
            if [isPOBox] and helperBestMatch(addFlagPOBox, [City])[Zip] <> null then
                helperBestMatch(addFlagPOBox, [City])[Zip]
            else
                [Zip]
    ),
    reOrderedCols = Table.ReorderColumns(
        addBestMatchZip, {"isPOBox", "BestMatchAddress", "BestMatchCity", "BestMatchZip", "Address", "City", "Zip"}
    ),
    sortedByFlag = Table.Sort(reOrderedCols, {{"isPOBox", Order.Descending}}),
// #endregion

// #region helperBestMatch
    helperBestMatch = (inputTable as table, inputCity as text) =>
        let
            src = inputTable,
            filtered = Table.SelectRows(src, each Text.Upper([City]) = Text.Upper(inputCity) and not [isPOBox]),
            addTruncZip = Table.AddColumn(filtered, "truncZip", each Text.Start([Zip], 5)),
            grouped = Table.Group(
                addTruncZip, {"City", "Address", "truncZip"}, {{"Count", each Table.RowCount(_), type number}}
            ),
            sorted = Table.Sort(grouped, {{"Count", Order.Descending}}),
            outputRec = [
                Address = sorted{0}[Address],
                City = sorted{0}[City],
                Zip = sorted{0}[truncZip]
            ],
            nullRec = [
                Address = null,
                City = null,
                Zip = null
            ],
            // res = sorted
            res = if Table.IsEmpty(filtered) then nullRec else outputRec
        in
            res,
// #endregion



    reGrouped = Table.Group(sortedByFlag, {"BestMatchAddress", "BestMatchCity", "BestMatchZip"}, {
    {"Count", each Table.RowCount(_), type number}}),
  
    res = reGrouped
in
    res

```
