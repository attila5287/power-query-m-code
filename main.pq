// This file contains your Data Connector logic
[Version = "1.0.0"]
section main;

[DataSource.Kind="main", Publish="main.Publish"]
shared main.Contents = (optional message as text) =>
    let
        _message = if (message <> null) then message else "(no message)",
        a = "Hello from main: " & _message
    in
        a;

// Data Source Kind description
main = [
    Authentication = [
        // Key = [],
        // UsernamePassword = [],
        // Windows = [],
        Anonymous = []
    ]
];

// Data Source UI publishing description
main.Publish = [
    Beta = true,
    Category = "Other",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    LearnMoreUrl = "https://powerbi.microsoft.com/",
    SourceImage = main.Icons,
    SourceTypeImage = main.Icons
];

main.Icons = [
    Icon16 = { Extension.Contents("main16.png"), Extension.Contents("main20.png"), Extension.Contents("main24.png"), Extension.Contents("main32.png") },
    Icon32 = { Extension.Contents("main32.png"), Extension.Contents("main40.png"), Extension.Contents("main48.png"), Extension.Contents("main64.png") }
];
