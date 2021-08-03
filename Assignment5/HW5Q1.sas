TITLE "Analysis - Bankingfull";

PROC IMPORT datafile="C:\Users\XLIU115\Desktop\Assignment5\Bankingfull.txt" out=Balance replace;
getnames=yes;
delimiter='09'x;
RUN;

DATA Balance_new2;
set Balance;
drop Income;
RUN;

DATA Balance_new3;
set Balance_new3;
if _n_=58 then delete;
RUN;

DATA Balance_pred;
input Balance Age Education HomeVal Wealth;
datalines;
. 34 13 160000 140000
;

DATA Balance_new3;
set Balance_pred Balance;

PROC PRINT;
RUN;

PROC REG;
title "Regression Model - Balance and Other Variables (Update Income)";
model Balance= Age Education HomeVal Wealth /p clm cli alpha=0.05;
RUN;
