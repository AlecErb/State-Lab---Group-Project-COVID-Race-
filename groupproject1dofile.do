* Importing data and creating graphs with it

 import excel "C:\Users\bobby\Documents\educationbyracedata.
> xlsx", sheet("Sheet1") firstrow
(6 vars, 3 obs)

 ren AllRaces PercentAllWithCollegeDeg

 ren WhiteAlone PercentWhiteWithCollegeDeg

 ren BlackAlone PercentBlackWithCollegeDeg

 ren HispanicAlone PercentHispWithCollegeDeg

 ren AsianAlone PercentAsianWithCollegeDeg




ren PercentAllWithCollegeDeg All

ren PercentWhiteWithCollegeDeg White

ren PercentBlackWithCollegeDeg Black

ren PercentHispWithCollegeDeg Hispanic

ren PercentAsianWithCollegeDeg Asian



. graph bar (last) All (last) White (last) Black (last) Hispa
> nic (last) Asian, ytitle(Percentage With College Degree)
