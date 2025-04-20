```JS
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
// recursive_factorial

```