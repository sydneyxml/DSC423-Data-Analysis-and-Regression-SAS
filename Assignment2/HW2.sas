*1A;
PROC IMPORT datafile="C:\Users\XLIU115\Desktop\Assignment2\banking.txt" out=salary replace;
getnames=yes;
RUN;

TITLE "Histogram for Distribution of Average Account Balance";
PROC UNIVARIATE normal;
var Balance;
histogram / normal (mu=est sigma=est);
inset median mean mode min max range Q1 Q3 kurtosis skewness;
RUN;


*1B;
PROC SGSCATTER;
  title "Scatterplot Matrix for Bank Balance and the Other Variables";
  matrix Balance Age Education Income;
RUN;

PROC CORR;
  var Balance Age Education Income;
RUN;


*1CDE;
PROC REG CORR;
TITLE "Regression for All the Variables";
model Balance = Age Education Income;
RUN;


*1F;
PROC REG CORR;
TITLE "Regression for Removing Education Variable";
model Balance = Age Income;
RUN;
