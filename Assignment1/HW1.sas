*2B;
TITLE "Census Records Selected Counties in the U.S. Who Voted in 1992 Elections";
PROC IMPORT datafile = "C:\Users\XLIU115\Desktop\Assignment1\voting_1992.txt" out = county replace;
delimiter = '09'x;
getnames = yes;
datarow = 2;
RUN;


*2C;
PROC print;
RUN;


*2D;
TITLE "Descriptives";
PROC MEANS data = county min max median p25 p75;
VAR Pct_Voted MedianAge;
RUN;


*2E;
TITLE "Histogram";
PROC UNIVARIATE normal;
VAR Pct_Voted;
histogram / normal (mu=est sigma=est);
inset median mean range kurtosis skewness;
RUN;


*2F;
DATA county;
set county;
length Majority_gender $10;
if gender='M' then Majority_gender='Male';
else Majority_gender='Female';
RUN;

TITLE "Boxplot - Percentage of People Voted by Gender";
PROC SORT;
by Majority_gender;
RUN;

PROC boxplot;
plot Pct_Voted*Majority_gender;
RUN;


*2G;
TITLE "Gender Breakdown";
proc freq;
tables Majority_gender;;
RUN;

