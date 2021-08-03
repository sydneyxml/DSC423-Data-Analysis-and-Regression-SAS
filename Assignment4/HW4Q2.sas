TITLE "Analysis of pgatour2006";

PROC IMPORT datafile="C:\Users\XLIU115\Desktop\Assignment4\pgatour2006.csv" out=PGATour replace;
delimiter=',';
getnames=yes;
RUN;

PROC PRINT data=PGATour;
RUN;

/*2A*/
PROC SGSCATTER;
title "Scatterplot Matrix - PrizeMoney and Other Variables";
matrix PrizeMoney DrivingAccuracy GIR PuttingAverage BirdieConversion PuttsPerRound;
RUN;

/*2B*/
TITLE "Histogram - Distribution of PrizeMoney";

PROC UNIVARIATE normal;
var PrizeMoney;
histogram / normal (mu=est sigma=est);
inset median mean min max range Q1 Q3 kurtosis skewness /pos = ne;
RUN;

/*2C*/
DATA PGATour;
set PGATour;
ln_Prize = log(PrizeMoney);

PROC PRINT;
RUN;

TITLE "Histogram - Distribution of ln_Prize = log(PrizeMoney)";
PROC UNIVARIATE normal;
var ln_Prize;
histogram / normal (mu=est sigma=est);
inset median mean min max range Q1 Q3 kurtosis skewness /pos = ne;
RUN;

/*2D*/
/*Regression Model - All Variables*/
PROC REG;
title "Regression Model - All Variables";
model ln_Prize = DrivingAccuracy GIR PuttingAverage BirdieConversion PuttsPerRound;
RUN;

PROC REG corr;
model ln_Prize = DrivingAccuracy GIR PuttingAverage BirdieConversion PuttsPerRound;
RUN;


/*Regression Model - Remove DrivingAccuracy*/
PROC REG;
title "Regression Model - Remove DrivingAccuracy";
model ln_Prize = GIR PuttingAverage BirdieConversion PuttsPerRound;
RUN;

PROC REG corr;
model ln_Prize = GIR PuttingAverage BirdieConversion PuttsPerRound;
RUN;


/*Regression Model - Remove DrivingAccuracy & PuttingAverage*/
PROC REG;
title "Regression Model - Remove DrivingAccuracy & PuttingAverage";
model ln_Prize = GIR BirdieConversion PuttsPerRound /influence r;
plot student.*(GIR BirdieConversion PuttsPerRound predicted.);
plot npp.*student.;
RUN;

PROC REG corr;
model ln_Prize = GIR BirdieConversion PuttsPerRound;
RUN;


DATA PGATour2;
set PGATour2;
if _n_ in (138) then delete;
RUN;

PROC REG;
title "Regression Model - Remove DrivingAccuracy & PuttingAverage New";
model ln_Prize = GIR BirdieConversion PuttsPerRound /influence r;
plot student.*(GIR BirdieConversion PuttsPerRound predicted.);
plot npp.*student.;
RUN;
