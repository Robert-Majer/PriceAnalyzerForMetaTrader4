//+------------------------------------------------------------------+
//|                                            EngulfingBarCheck.mq4 |
//|                                                     Robert Majer |
//+------------------------------------------------------------------+

#property copyright "Copyright 2022, Robert Majer"
#property version   "1.00"
#property strict
#property show_inputs

#include <DrawOnTheChart.mqh>
#include <PrimaryFunctions.mqh>
#include <CandlesVerification.mqh>

input int _candleNumber = 1; // Candle number to check

//+------------------------------------------------------------------+
void OnStart()
  {
   if(BullishEngulfingBarVerification(_candleNumber) == true)
     {
      CreateArrow(true,_candleNumber,5);
      Alert("");
      Alert("BUY Bullish Engulfing Bar - Candle number: " + IntegerToString(_candleNumber));
     }

   if(BearishEngulfingBarVerification(_candleNumber) == true)
     {
      CreateArrow(false,_candleNumber,8);
      Alert("");
      Alert("SELL Bearish Engulfing Bar - Candle number: " + IntegerToString(_candleNumber));
     }
  }

//+------------------------------------------------------------------+
