# m-code (mash-up) in excel or in power-bi or in vs-code

| *[AT Codes][at00]* | *These below codes are all stand-alone m-code files that will run by themselves with no external data source, copy paste this to *Advanced Editor* or to the *.query.pq* file when working with the [PQ-Software Development Kit][info0] at [VS-code extension][info1].* |
|--|--|
|[Find best match][at01] | wrote this query for work, the purpose was to re-fill all the PO Box addresses with a physical address from the same table using the city |
|[Cool record][at02]|Record is a primitive data type in M is very similar to a javascript object or a python dictionary. However I would say it's more like JS-objects with cool features, in this code I assigned functions to record properties.  |
 |[Udemy course exercises][at03] |about 70 exercises from alex kropf's course mammoth interactive in udemy, all my code  |
|[Correct city name][at04] | Correcting a city name in a dataset with records and lists | |


[at00]:/ref/
[at01]:/ref/find-best-match.md
[at02]:/ref/cool-rec.md
[at03]:/ref/at-ex-dump.md
[at04]:/ref/correct-city.md

[info0]:https://learn.microsoft.com/en-us/power-query/power-query-sdk-vs-code
[info1]:https://marketplace.visualstudio.com/items?itemName=PowerQuery.vscode-powerquery-sdk
[info2]:https://learn.microsoft.com/en-us/power-query/



# [What is m-code or Power Query? ][info2]|
|--|[official microsoft documentation][info2]|
|--|--|
|<image src="./public/power-bi.png" width="240" height="40"> |Microsoft Power Query provides a powerful "get data" experience that encompasses many features. A core capability of Power Query is to filter and combine, that is, to "mash-up" data from one or more of a rich collection of supported data sources. Any such data mashup is expressed using the Power Query formula language (informally known as "M"). Power Query embeds M documents in a wide range of Microsoft products, including Excel, Power BI, Analysis Services, and Dataverse, to enable repeatable mashup of data.|
|<image src="./public/power-query.png" width="340" height="100">| In any data transformation scenario, there are some transformations that can't be done in the best way by using the graphical editor. Some of these transformations might require special configurations and settings that the graphical interface doesn't currently support. The Power Query engine uses a scripting language behind the scenes for all Power Query transformations: the Power Query M formula language, also known as M.|
|<image src="./public/m-code.png" width="340" height="100">| The M language is the data transformation language of Power Query. Anything that happens in the query is ultimately written in M. If you want to do advanced transformations using the Power Query engine, you can use the advanced editor to access the script of the query and modify it as you want. If you find that the user interface functions and transformations can't perform the exact changes you need, use the advanced editor and the M language to fine-tune your functions and transformations.|

<img src="./public/what-is-pq.png"      width="300" height="200">

![adv editor](/public/pq-excel.png)
![adv editor](/public/advanced-editor.png)


<br>

| ![dev]( https://raw.githubusercontent.com/attila5287/img_readme/main/all/dev.jpg "dev-icon") | About Developer: Attila Turkoz | 
| -------------   | -------------: |
| Repos | [github.com/attila5287 ](https://github.com/attila5287/) |
| Profile | [ attila5287.github.io ](https:///attila5287.github.io/) |
| Email    |  atiturkoz@gmail.com | 


[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) 

