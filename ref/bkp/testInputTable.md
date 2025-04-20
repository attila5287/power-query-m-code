```js
let
  // #region PQ SDK test env
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


```
