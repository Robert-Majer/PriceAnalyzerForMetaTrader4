//+------------------------------------------------------------------+
//|                                                  PinBarCheck.mq4 |
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
input double _candleBodySize = 0.65; //Candle body size in pinbar
input double _candleBodyPosition = 0.35; //Candle body position in pinbar
input int _timeframe = PERIOD_CURRENT; // Timeframe - 1 is 1 minute (1440 = 24h / 0 = current)

//+------------------------------------------------------------------+
void OnStart()
  {
   if(BullishPinbarVerification(_candleNumber,_candleBodySize,_candleBodyPosition,_timeframe) == true)
     {
      CreateArrow(true,_candleNumber,5);
      Alert("");
      Alert("BUY Bullish Pin Bar - Candle number: " + IntegerToString(_candleNumber));
     }

   if(BearishPinbarVerification(_candleNumber,_candleBodySize,_candleBodyPosition,_timeframe) == true)
     {
      CreateArrow(false,_candleNumber,8);
      Alert("");
      Alert("SELL Bearish Pin Bar - Candle number: " + IntegerToString(_candleNumber));
     }
  }

//+------------------------------------------------------------------+
