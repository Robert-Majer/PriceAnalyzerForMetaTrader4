//+------------------------------------------------------------------+
//|                                               InsideBarCheck.mq4 |
//|                                                     Robert Majer |
//+------------------------------------------------------------------+

#property copyright "Robert Majer"
#property version   "1.00"
#property strict
#property show_inputs

#include <CandlesVerification.mqh>
#include <DrawOnTheChart.mqh>

input int _candleNumberToCheck = 3; //Candle number to check
input int _numberOfCandlesToCheck = 5; //Number of candles to check

//+------------------------------------------------------------------+
void OnStart()
  {
   int checkCandleNumber = InsideBarVerification(_candleNumberToCheck, _numberOfCandlesToCheck);
   bool checkCandleNumberBool = InsideBarVerificationBool(_candleNumberToCheck, _numberOfCandlesToCheck);
   
   if(checkCandleNumberBool == true)
     {
      Alert("Candle number " + IntegerToString(_candleNumberToCheck) + " is inside bar. Mother candle have number " + IntegerToString(checkCandleNumber));
      CreateRectangle(High[checkCandleNumber],Low[checkCandleNumber],Time[checkCandleNumber],Time[_candleNumberToCheck]);
     }
  }
  
//+------------------------------------------------------------------+
