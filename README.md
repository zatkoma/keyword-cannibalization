# keyword-canibalization
This script will help you find if you have a problem with keyword cannibalization. 

It's R script which downloads data from performance report (keyword + URL) from GSC and tries to find the same keyword with distinct URL, which is called keyword cannibalization. 

After running this script you will see this report:


| Keyword       | URL          | Clicks | CTR | Position | Percent |
| ------------- |:-------------:| -----:| -----:| -----:| -----:|
| A | example.com/a | 261 | 2,7 | 1,047 | 72,3% |
| A | example.com/ab | 43 | 0,6 | 2,124 | 11,9% |
| A | example.com/ac | 27 | 0,3 | 3,181 | 7,48% |
|...|...|...|...|...|...|



## What do I need?

- R and R studio
- package: searchConsoleR
- package: tidyverse
- package: googleAuthR
