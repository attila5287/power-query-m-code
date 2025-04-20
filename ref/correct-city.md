# Correct city with m-code

pulled random address from `random-user-API`

```JS
let
correctCities = (inputCity as text) as text =>
    let
        correctCityPairs = {
            {"co springs", "COLORADO SPRINGS"},
            {"COLO SPGS", "COLORADO SPRINGS"},
            {"COLO SPRINGS", "COLORADO SPRINGS"},
            {"COLORAD SPGS", "COLORADO SPRINGS"},
            {"COLORADO SPG", "COLORADO SPRINGS"},
            {"COLORADO SPGS", "COLORADO SPRINGS"},
            {"COLORADO SPRG", "COLORADO SPRINGS"},
            {"COLORADO SPRI", "COLORADO SPRINGS"},
            {"ELDORADO SPGS", "ELDORADO SPRINGS"},
            {"FT COLLINS", "FORT COLLINS"},
            {"FT MORGAN", "FORT MORGAN"},
            {"GLENWOOD SPGS", "GLENWOOD SPRINGS"},
            {"GLENWOOD SPRG", "GLENWOOD SPRINGS"},
            {"GR JUNCTION", "GRAND JUNCTION"},
            {"GRAND JCT", "GRAND JUNCTION"},
            {"GRAND JCTION", "GRAND JUNCTION"},
            {"GRAND JUNCT", "GRAND JUNCTION"},
            {"GRAND JUNCTIO", "GRAND JUNCTION"},
            {"GRANDJUNCTION", "GRAND JUNCTION"},
            {"GRD JCT", "GRAND JUNCTION"},
            {"GRND JUNCTION", "GRAND JUNCTION"},
            {"HOT SULPH SPG", "HOT SULPHUR SPRINGS"},
            {"OLNEY SPRING", "OLNEY SPRINGS"},
            {"PAGOSA SPRING", "PAGOSA SPRINGS"},
            {"PUEBO", "PUEBLO"},
            {"SENVER", "DENVER"},
            {"STAMBOAT SPG", "STEAMBOAT SPRINGS"},
            {"STEAMBOAT SPG", "STEAMBOAT SPRINGS"},
            {"WHEATRIDGE", "WHEAT RIDGE"}
        },
        fixList = List.Transform(correctCityPairs, each Text.Upper( _{0})),
        correctList = List.Transform(correctCityPairs, each Text.Upper( _{1})),
        
        isCityCorrect = not List.Contains(fixList, inputCity), 
        
        recordsCityPairs = Record.FromList(
        correctList,
        fixList
        ),
        res = Record.FieldOrDefault(recordsCityPairs, Text.Upper(inputCity), inputCity)
    in
        res
    ,
    testInputTable= Table.FromRecords({
        [ City="CO SPRINGS",  Address="975 Bandstand Promenade" ] , 
        [ City="COLO SPGS",  Address="7501 De Greune" ] , 
        [ City="COLO SPRINGS",  Address="5740 Royal Ln" ] , 
        [ City="COLORAD SPGS",  Address="3472 Stanley Road" ] , 
        [ City="COLORADO SPG",  Address="6882 Rua Santa Luzia " ] , 
        [ City="COLORADO SPGS",  Address="6259 Rookery Road" ] , 
        [ City="COLORADO SPRG",  Address="2281 Victoria Avenue" ] , 
        [ City="COLORADO SPRI",  Address="3371 Church Street" ] , 
        [ City="ELDORADO SPGS",  Address="502 Porodice Rankovic" ] , 
        [ City="FT COLLINS",  Address="2005 Milovana Niciforovica" ] , 
        [ City="FT MORGAN",  Address="308 Calle de La Almudena" ] , 
        [ City="GLENWOOD SPGS",  Address="3757 Kvitneva" ] , 
        [ City="GLENWOOD SPRG",  Address="7648 Porsevej" ] , 
        [ City="GR JUNCTION",  Address="415 Brattbakken" ] , 
        [ City="GRAND JCT",  Address="9781 Victoria Street" ] , 
        [ City="GRAND JCTION",  Address="3789 Alfred St" ] , 
        [ City="GRAND JUNCT",  Address="3274 Calle de Téllez" ] , 
        [ City="GRAND JUNCTIO",  Address="7899 Avenue de L'Abbé-Roussel" ] , 
        [ City="GRANDJUNCTION",  Address="4358 Railroad St" ] , 
        [ City="GRD JCT",  Address="5876 Woodland St" ] , 
        [ City="GRND JUNCTION",  Address="4793 Heibloemstraat" ] , 
        [ City="HOT SULPH SPG",  Address="5067 Avenue de L'Abbé-Roussel" ] , 
        [ City="OLNEY SPRING",  Address="7666 Rovenskiy provulok" ] , 
        [ City="PAGOSA SPRING",  Address="7750 Svyatoshinskiy provulok" ] , 
        [ City="PUEBO",  Address="9110 Ensjøsvingen" ] , 
        [ City="SENVER",  Address="3286 Rue du Cardinal-Gerlier" ] , 
        [ City="STAMBOAT SPG",  Address="3407 Green Rd" ] , 
        [ City="STEAMBOAT SPG",  Address="1684 Lunden" ] , 
        [ City="WHEATRIDGE",  Address="6226 York Road" ] 
    }), 

addCityColumn = Table.AddColumn(testInputTable, "newCity", each correctCities([City])),


res = addCityColumn
// res = correctCities("senver")
in
    res
```
# output 

| City | Address | newCity| 
| -- | -- |  -- | 
|CO SPRINGS|975 Bandstand Promenade|COLORADO SPRINGS|
|COLO SPGS|7501 De Greune|COLORADO SPRINGS|
|COLO SPRINGS|5740 Royal Ln|COLORADO SPRINGS|
|COLORAD SPGS|3472 Stanley Road|COLORADO SPRINGS|
|COLORADO SPG|6882 Rua Santa Luzia|COLORADO SPRINGS|
|COLORADO SPGS|6259 Rookery Road|COLORADO SPRINGS|
|COLORADO SPRG|2281 Victoria Avenue|COLORADO SPRINGS|
|COLORADO SPRI|3371 Church Street|COLORADO SPRINGS|
|ELDORADO SPGS|502 Porodice Rankovic|ELDORADO SPRINGS|
|FT COLLINS|2005 Milovana Niciforovica|FORT COLLINS|
|FT MORGAN|308 Calle de La Almudena|FORT MORGAN|
|GLENWOOD SPGS|3757 Kvitneva|GLENWOOD SPRINGS|
|GLENWOOD SPRG|7648 Porsevej|GLENWOOD SPRINGS|
|GR JUNCTION|415 Brattbakken|GRAND JUNCTION|
|GRAND JCT|9781 Victoria Street|GRAND JUNCTION|
|GRAND JCTION|3789 Alfred St|GRAND JUNCTION|
|GRAND JUNCT|3274 Calle de Téllez|GRAND JUNCTION|
|GRAND JUNCTIO|7899 Avenue de L'Abbé-Roussel|GRAND JUNCTION|
|GRANDJUNCTION|4358 Railroad St|GRAND JUNCTION|
|GRD JCT|5876 Woodland St|GRAND JUNCTION|
|GRND JUNCTION|4793 Heibloemstraat|GRAND JUNCTION|
|HOT SULPH SPG|5067 Avenue de L'Abbé-Roussel|HOT SULPHUR SPRINGS|
|OLNEY SPRING|7666 Rovenskiy provulok|OLNEY SPRINGS|
|PAGOSA SPRING|7750 Svyatoshinskiy provulok|PAGOSA SPRINGS|
|PUEBO|9110 Ensjøsvingen|PUEBLO|
|SENVER|3286 Rue du Cardinal-Gerlier|DENVER|
|STAMBOAT SPG|3407 Green Rd|STEAMBOAT SPRINGS|
|STEAMBOAT SPG|1684 Lunden|STEAMBOAT SPRINGS|
