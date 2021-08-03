TITLE "Analysis of Bankingfull";

PROC IMPORT datafile="C:\Users\XLIU115\Desktop\Assignment4\Bankingfull.txt" out=Balance replace;
getnames=yes;
delimiter='09'x;
RUN;

PROC PRINT data=Balance;
RUN;

/*1A*/
PROC SGSCATTER;
  title "Scatterplot Matrix - Balance and Other Variables";
  matrix Balance Age Education Income HomeVal Wealth;
RUN;

/*1B*/
PROC CORR;
var Balance Age Education Income HomeVal Wealth;
RUN;


/*1C*/
PROC REG;
title "Regression Model - Balance and Other Variables";
model Balance= Age Education Income HomeVal Wealth /vif;
RUN;


/*1D*/
/*Drop Wealth*/
DATA Balance_1;
set Balance;
drop Wealth;
RUN;

PROC PRINT data= Balance_1;
RUN;

PROC REG;
title "Regression Model - Balance and Other Variables New 1";
model Balance= Age Education Income HomeVal /vif;
RUN;

/*Drop Income*/
DATA Balance_2;
set Balance;
drop Income;
RUN;

PROC PRINT data= Balance_2;
RUN;

PROC REG;
title "Residual Plots - Balance and Other Variables New 2";
model Balance= Age Education HomeVal Wealth /vif;
plot student.*(Age Education HomeVal Wealth predicted.);
plot npp.*student.;
RUN;


PROC REG;
title "Outliers - Balance and Other Variables New 2";
model Balance= Age Education HomeVal Wealth /influence r;
plot student.*(Age Education HomeVal Wealth predicted.);
plot npp.*student.;
RUN;


DATA Balance_3;
set Balance_3;
if _n_=58 then delete;
RUN;

PROC REG;
title "Regression Model - Balance and other variables New 2";
model Balance= Age Education HomeVal Wealth /stb;
RUN;
