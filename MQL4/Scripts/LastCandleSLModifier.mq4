//+------------------------------------------------------------------+
//|                                         LastCandleSLModifier.mq4 |
//|                                                     Robert Majer |
//+------------------------------------------------------------------+

#property copyright "Copyright 2022, Robert Majer"
#property version   "1.00"
#property strict

#include <OrderFunctions.mqh>

double _priceMarginTralingStop = 2.0;

//+------------------------------------------------------------------+
void OnStart()
  {
   StopLossModifier(_priceMarginTralingStop);
  }
  
//+------------------------------------------------------------------+

