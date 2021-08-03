PROC IMPORT datafile="C:\Users\XLIU115\Desktop\Assignment3\banking.txt" out=salary replace;
getnames=yes;
RUN;


PROC CORR;
var Balance Age Income;
RUN;


PROC REG CORR;
title "Regression Model - Remove Education";
model Balance = Age Income;
RUN;


PROC REG;
title "Residual Plots - Balance, Age and Income";
model Balance = Age Income;
plot student.*predicted.;
plot student.*(Age Income);
plot npp.*student.;
RUN;

