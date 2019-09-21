# Kanibalizace klíčových slov
Tento skript vám pomůže identifikovat, jestli máte na webu problém s kanibalizací klíčových slov. Vycházím z předpokladu, že jakmile v SERPu rankují dvě různé vstupní stránky na jedno klíčové slovo, tak jde o kanibalizaci. Výsledkem je tedy následující export:

![Output of script in OpenRefine](https://github.com/zatkoma/keyword-cannibalization/blob/master/output-keyword-cannibalization.png?raw=true)

## Co budete potřebovat?

- R and R studio
- package: googleAuthR
- package: searchConsoleR
- package: tidyverse

## Poděkování

Musím ještě vyslat jedno poděkování směrem k návodu: https://www.gokam.co.uk/seo-cannibalization-r/. Tento návod jsem vzal a rozšířil o pár mnou postrádaných funkcí, jako je například filtrace pouze na problematické stránky, srovnávání dle impresí, začištění výstupu a úprava pro lehčí použití / prohlížení v OR. 
