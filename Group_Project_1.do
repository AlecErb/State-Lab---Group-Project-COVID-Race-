import excel "C:\Users\Alex\Documents\Stata Folder\Race Data Entry - CRDT.xlsx", sheet("Race Data Entry - CRDT") firstrow
generate Hispanic_percentage = Cases_LatinX/Cases_Total
generate Black_Percentage = Cases_Black/Cases_Total
generate Asian_percentage = Cases_Asian/Cases_Total
generate White_Percentage = Cases_White/Cases_Total
summarize Hispanic_percentage
summarize Black_Percentage
summarize Asian_percentage
summarize White_Percentage
preserve
collapse (mean) Mean_HP=Hispanic_percentage (mean) Mean_BP=Black_Percentage (mean) Mean_AP=Asian_percentage (mean)Mean_WP=White_Percentage, by(State)
tempfile percentage
save `percentage'
restore



import excel "C:\Users\Alex\OneDrive\Documents\StataFolder\raw_data.xlsx", sheet("raw_data") firstrow clear
encode Black, gen(Black1)
merge m:1 State using `percentage'
generate Weighted_HP=Hispanic/Mean_HP
generate Weighted_BP=Black1/Mean_BP
generate Weighted_WP=White/Mean_WP
generate Weighted_AP=Asian/Mean_AP


gen WhiteCases = White_Percentage*totalcases
gen BlackCases = Black_Percentage*Cases_Total
gen HispanicCases = Hispanic_percentage*Cases_Total
gen AsianCases = Asian_percentageC*Cases_Total
