*Source: https://www.kff.org/other/state-indicator/covid-19-cases-by-race-ethnicity/?currentTimeframe=0&sortModel=%7B%22colId%22:%22Location%22,%22sort%22:%22asc%22%7D

* Prep COVID by race and state data
import delimited "/Users/alec/Desktop/School/University of Utah/Fall 2020/Econemetrics - ECON 4651/Group Project 1/CovidbyRaceandState.csv", delimiter(comma) varnames(3) encoding(UTF-8) colrange(:11) clear 
drop in 53/62
rename location state
recast str state
tempfile COVIDRaceState
save `COVIDRaceState'

* Source: https://data.ers.usda.gov/reports.aspx?ID=17827
* Prep State Population Data
import excel "/Users/alec/Desktop/School/University of Utah/Fall 2020/Econemetrics - ECON 4651/Group Project 1/PopulationReport.xlsx", sheet("PopulationReport") cellrange(A4:E59) firstrow clear
drop in 1
drop Pop1990
drop Pop2000
drop Pop2010
rename Name state
tempfile statepop
save `statepop'

* Source: 
* Prep COVID total covid infections by state
import delimited "/Users/alec/Desktop/School/University of Utah/Fall 2020/Econemetrics - ECON 4651/Group Project 1/COVIDCasesByState.csv", delimiter(comma) varnames(4) colrange(:11) clear
drop v3
drop v4
drop v5
drop v6
drop v7
drop v8
drop v9
drop v10
rename stateterritory state
tempfile totalcovidbystate
save `totalcovidbystate'


* Merge COVID by race and state data with state population data
use `COVIDRaceState', clear
merge m:1 state using `statepop', nogen keep(3)
merge m:1 state using `totalcovidbystate', nogen keep(3)


*Post merge cleaning
drop americanin
replace blackoftotalpopulation = ".01" in 50
replace blackoftotalpopulation = ".01" in 27
replace asianofcases = ".01" in 1
replace asianofcases = ".01" in 27
replace asianofcases = ".01" in 25
destring blackofcases, replace
destring blackoftotalpop, replace
replace hispanicofcases = "0" if hispanicofcases == "NR"
destring hispanicofcases, replace
replace asianofcases = "0" if asianofcases == "NR"
destring asianofcases, replace
destring whiteofcases, replace



* Generate number of cases per race
gen numOfWhiteCases = whiteofcases*totalcases
gen numOfBlackCases = blackofcases * totalcases
gen numOfHispanicCases = hispanicofcases * totalcases
gen numOfAsianCases = asianofcases * totalcases 


* Generate number of race in each state
gen numOfWhite = whiteoftotalpopulation*Pop2019
gen numOfBlack = blackoftotalpopulation*Pop2019
gen numOfHispanic = hispanicoftotalpopulation*Pop2019
gen numOfAsian = asianoftotalpopulation*Pop2019



* Generate percentage of race that has been/is infected: Read as 'of the white population, how many had/have COVID' This is the number we are concerned about
gen whitePercentage = numOfWhiteCases/numOfWhite
gen blackPercentage = numOfBlackCases / numOfBlack
gen hispanicPercentage = numOfHispanicCases / numOfHispanic
gen asianPercentage = numOfAsianCases / numOfAsian

graph bar (mean) whitePercentage (mean) blackPercentage (mean) hispanicPercentage (mean) asianPercentage

