TITLE "Analysis - HouseSales";


PROC IMPORT datafile="C:\Users\XLIU115\Desktop\Assignment3\HouseSales.txt" out=Price replace;
getnames=yes;
delimiter='09'x;
RUN;


DATA Price;
set Price;
H1=(Type="T");
R1=(Region="M");
RUN;


PROC PRINT data=Price;
RUN;


PROC SGSCATTER;
  title "Scatterplot Matrix - Selling Price and Other Individual Attributes";
  matrix Price Cost H1 R1;
RUN;


PROC REG CORR;
title "Residual Plots - Selling Price, Cost, Home and Region";
model Price= Cost H1 R1;
RUN;


PROC REG;
model Price= Cost H1 R1;
RUN;


PROC REG;
model Price= Cost H1;
RUN;


PROC SGSCATTER;
  title "Scatterplot Matrix - Selling Price, Cost and Home";
  matrix Price Cost H1;
RUN;


PROC REG corr;
title "Residual Plots - Selling Price, Cost and Home";
model Price= Cost H1;
plot student.*predicted.;
plot student.*(Cost H1);
plot npp.*student.;
RUN;

