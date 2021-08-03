TITLE "Analysis & Prediction - churn_train";

PROC IMPORT datafile = "C:\Users\XLIU115\Desktop\Assignment6\churn_train.csv" out = phone replace;
getnames=yes;
delimiter=',';
RUN;

DATA phone_new;
set phone;
dGEN=(GENDER='M');
dEDU1=(EDUCATION=2);
dEDU2=(EDUCATION=3);
dEDU3=(EDUCATION=4);
dEDU4=(EDUCATION=5);
dEDU5=(EDUCATION=6);
dLPPC=(LAST_PRICE_PLAN_CHNG_DAY_CNT=1);
dCOMP=(COMPLAINT=1);
RUN;

PROC PRINT;
RUN;


/*1a*/
TITLE "Boxplot - Age and Churn";
PROC SORT;
by Churn;
RUN;
PROC BOXPLOT;
plot Age*Churn;
RUN;
TITLE "Boxplot - PCT_CHNG_BILL_AMT and Churn";
PROC SORT;
by Churn;
RUN;
PROC BOXPLOT;
plot PCT_CHNG_BILL_AMT*Churn;
RUN;


/*1b*/
TITLE "Logistic Regression - Full Model";
PROC LOGISTIC;
model Churn (event='1') = PCT_CHNG_IB_SMS_CNT PCT_CHNG_BILL_AMT TOT_ACTV_SRV_CNT dGEN dEDU1 dEDU2 dEDU3 dEDU4 dEDU5 dLPPC dCOMP;
RUN;
/*Remove unimportant variables*/
PROC LOGISTIC;
model Churn (event='1') = PCT_CHNG_IB_SMS_CNT PCT_CHNG_BILL_AMT TOT_ACTV_SRV_CNT dCOMP
							/selection=stepwise rsquare;
RUN;
PROC LOGISTIC;
model Churn (event='1') = PCT_CHNG_IB_SMS_CNT PCT_CHNG_BILL_AMT TOT_ACTV_SRV_CNT dCOMP
							/selection=backward rsquare;
RUN;
TITLE "Logistic regression - Final Model";
PROC LOGISTIC;
model Churn (event='1') = PCT_CHNG_IB_SMS_CNT PCT_CHNG_BILL_AMT TOT_ACTV_SRV_CNT dCOMP;
RUN;

/*1c*/
TITLE "Prediction - Final Model";
DATA phone_pred;
input PCT_CHNG_IB_SMS_CNT PCT_CHNG_BILL_AMT TOT_ACTV_SRV_CNT dCOMP;
datalines;
1.04 1.19 4 1
;
DATA phone_comb;
set phone_pred phone_new;
RUN;
PROC PRINT;
RUN;
PROC LOGISTIC data=phone_comb;
model Churn (event='1') = PCT_CHNG_IB_SMS_CNT PCT_CHNG_BILL_AMT TOT_ACTV_SRV_CNT dCOMP;
output out=finalPrediction p=phat upper=ucl lower=lcl;
RUN;
PROC PRINT data=finalPrediction;
RUN;

