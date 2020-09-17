*Edward Chen Do File

*Clean the Income by Race Data*

*Source: https://www.census.gov/data/tables/2020/demo/income-poverty/p60-270.html*

import excel "/Users/edchen/Downloads/IncomebyRace.xlsx", sheet("tableA2") clear

destring ALL RACES, replace
destring WHITE ALONE 24, replace
destring WHITE ALONE, NOT HISPANIC 24, replace
destring BLACK ALONE OR IN COMBINATION, replace
destring BLACK ALONE 26, replace
destring ASIAN ALONE OR IN COMBINATION, replace
destring ASIAN ALONE 27, replace
destring HISPANIC (ANY RACE) 28, replace

drop 2018
drop 2017
drop 2016
drop 2015

keep if Percent distribution !=0

tempfile IncomebyRace
save `IncomebyRace'

*Clean the Covid Cases by Race and State*

*Source:   https://www.kff.org/other/state-indicator/covid-19-cases-by-race-ethnicity/?currentTimeframe=0&sortModel=%7B%22colId%22:%22Location%22,%22sort%22:%22asc%22%7D*

import delimited "/Users/edchen/Downloads/CovidCasesbyRaceandState.csv" clear

rename location state
recast str state
tempfile CovidCasesbyRaceandState
save `CovidCasesbyRaceandState'

*Merge Income by Race and Covid Cases by Race and State*

use `IncomebyRace'
merge m:1 state using `CovidCasesbyRaceandState', nogen keep(3)
destring whiteofcases, replace
destring blackofcases, replace
destring hispanicofcases, replace
destring asianofcases, replace

*Generate Cases Per Race*

gen numberofWhitecases = whiteofcases * totalcases
gen numberofBlackcases = blackofcases * totalcases
gen numberofHispaniccases = hispanicofcases * totalcases
gen numberofAsiancases = asianofcases * totalcases

*Graph of Mean Income by Race 2019*

*Stata kept crashing when I tried to make a bar graph, so I made one with Excel instead*







