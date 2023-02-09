//+------------------------------------------------------------------+
//|                                              PriceLevelCheck.mq4 |
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
input double _priceLevel = 0.0; // Price level to check
input double _marginSRInPercent = 5.0; // Price level margin of error [%]

//+------------------------------------------------------------------+
void OnStart()
  {
   bool candleIsInPriceLevel = PriceLevelVerification(_priceLevel,_marginSRInPercent,High[_candleNumber],Low[_candleNumber]);

   if(candleIsInPriceLevel == true)
     {
      Alert(Symbol() + "Signal is at a proven price level");
      CreateBoldHorizontalLine(_priceLevel,Time[_candleNumber],Blue);
     }
  }

//+------------------------------------------------------------------+
