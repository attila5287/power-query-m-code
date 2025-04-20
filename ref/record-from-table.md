```JS
recsPOBox = Record.FromList(
  List.Transform(
    Table.ToRecords(addCompKey),
      each [
        Address = [Address],
        City = [City],
        Zip = [Zip]
      ]
      ),      
      List.Transform(
      Table.ToRecords(Source
      each [Address]&[City]&[Zip]
  )
),

Source = Table.FromRows(
    {
      {"PO Bo", "Breckenridge","81217-SUCCS"}, 
      {"P.O.B", "Denver",  "80203_10000"},
      {"PO Box", "Denver",  "80234-10000"},
      {"P O B", "Denver",  "80235"},
      {"P. O ", "Co Spgs", "80204"},
      {"P.O. ", "Lakewood","80205"},
      {"PO Bo", "Thornton","80206"},
      {"P. O.", "Canon City","81215-10100" },
      {"1 fail","Denver",  "80203" },
      {"1 SUCS","Denver",  "80001-SUCCS"},
      {"1 SUCS","Denver",  "80001-SUCCS" },
      {"2 fail","Co Sprg", "80204" },
      {"2 SUCS","Colo Spg","80204-10000" },
      {"2 SUCS","Co Spgs", "80204" },
      {"3 fail","Lakewood","80205" },
      {"3 SUCS","Lakewood","80205" },
      {"3 SUCS","Lakewood","80205-10000" },
      {"4 fail","Thornton","80206" },
      {"4 SUCS","Thornton","80206" },
      {"4 SUCS","Thornton","80206-10000" },
      {"5 fail","Canon City","81218" },
      {"5 SCCS","Canon City","81216-10000" },
      {"5 SCCS","Canon City","81216" }
    },
    {"Address","City","Zip"}
  ),
  res = recsPOBox[P.O.BDenver80203_10000]
in 
  res 

```