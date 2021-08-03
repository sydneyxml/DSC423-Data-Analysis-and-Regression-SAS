TITLE "Analysis - College";

PROC IMPORT datafile="C:\Users\XLIU115\Desktop\Assignment5\College.csv" out=grad replace;
delimiter=',';
getnames=yes;
RUN;

PROC PRINT;
RUN;


/*2A*/
TITLE "Histogram - Distribution of Graduation Rate";
PROC UNIVARIATE normal;
var Grad_Rate;
histogram / normal (mu=est sigma=est);
inset median mean min max range Q1 Q3 kurtosis skewness /pos = ne;
RUN;


/*2B*/
DATA grad_new;
set grad;
drop school Private;
dPrivate=(Private="Yes");
RUN;

PROC PRINT;
RUN;

PROC REG corr;
title "Correlation - All Variables";
model Grad_Rate = dPrivate Accept_pct Elite10 F_Undergrad P_Undergrad Outstate Room_Board Books Personal PhD Terminal S_F_Ratio perc_alumni Expend;
RUN;

TITLE "GPLOTS - Y and X-variables";
PROC GPLOT data=grad_new;
plot Grad_Rate*(dPrivate Accept_pct Elite10 F_Undergrad P_Undergrad Outstate Room_Board Books Personal PhD Terminal S_F_Ratio perc_alumni Expend);
RUN;


/*2C*/
TITLE "Boxplots - Graduation Rates and University Type";

PROC SORT;
by dPrivate;
RUN;

PROC BOXPLOT;
plot Grad_Rate*dPrivate;
RUN;

TITLE "Boxplots - Graduation Rates and Status";
PROC SORT;
by Elite10;
RUN;

PROC BOXPLOT;
plot Grad_Rate*Elite10;
RUN;


/*2D*/
PROC REG;
TITLE "Regression - All Variables";
model Grad_Rate = dPrivate Accept_pct Elite10 F_Undergrad P_Undergrad Outstate Room_Board Books Personal PhD Terminal S_F_Ratio perc_alumni Expend;
RUN;

PROC REG corr;
model Grad_Rate = dPrivate Accept_pct Elite10 F_Undergrad P_Undergrad Outstate Room_Board Books Personal PhD Terminal S_F_Ratio perc_alumni Expend;
RUN;


/*2E*/
PROC REG;
TITLE "Regression - All Variables";
model Grad_Rate = dPrivate Accept_pct Elite10 F_Undergrad P_Undergrad Outstate Room_Board Books Personal PhD Terminal S_F_Ratio perc_alumni Expend /vif;
RUN;


/*2F*/
TITLE "Selection 1: Forward Selection";
PROC REG;
model Grad_Rate = dPrivate Accept_pct Elite10 F_Undergrad P_Undergrad Outstate Room_Board Books Personal PhD Terminal S_F_Ratio perc_alumni Expend /selection=forward;
RUN;

TITLE "Selection 2: Adj-R2 Selection";
PROC REG;
model Grad_Rate = dPrivate Accept_pct Elite10 F_Undergrad P_Undergrad Outstate Room_Board Books Personal PhD Terminal S_F_Ratio perc_alumni Expend /selection=adjrsq;
RUN;


/*2G*/
PROC REG;
TITLE "Regression - Removed Books, S_F_ratio and Terminal";
model Grad_Rate = dPrivate Accept_pct Elite10 F_Undergrad P_Undergrad Outstate Room_Board Personal PhD perc_alumni Expend;
RUN;


/*2HI*/
PROC REGg corr;
model Grad_Rate = dPrivate Accept_pct Elite10 F_Undergrad P_Undergrad Outstate Room_Board Personal PhD perc_alumni Expend;
RUN;

PROC REG;
TITLE "Residual Plots - Grad_Rate and Other Variables";
model Grad_Rate = dPrivate Accept_pct Elite10 F_Undergrad P_Undergrad Outstate Room_Board Personal PhD perc_alumni Expend;
plot student.*(dPrivate Accept_pct Elite10 F_Undergrad P_Undergrad Outstate Room_Board Personal PhD perc_alumni Expend predicted.);
plot npp.*student.;
RUN;


/*2JKL*/
TITLE "Final Model";
PROC REG;
model Grad_Rate = dPrivate Accept_pct Elite10 F_Undergrad P_Undergrad Outstate Room_Board Personal PhD perc_alumni Expend /vif r influence stb;
RUN;

DATA grad_new1;
set grad_new1;
if _n_ in (112) then delete;
RUN;

TITLE "Final Model - Removed Obs";
PROC REG;
model Grad_Rate = dPrivate Accept_pct Elite10 F_Undergrad P_Undergrad Outstate Room_Board Personal PhD perc_alumni Expend /vif r influence stb;
RUN;
