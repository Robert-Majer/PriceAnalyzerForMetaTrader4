//+------------------------------------------------------------------+
//|                                          LastCandleOrderSell.mq4 |
//|                                                     Robert Majer |
//+------------------------------------------------------------------+

#property copyright "Copyright 2022, Robert Majer"
#property version   "1.00"
#property strict

#include <OrderFunctions.mqh>

double _riskInPercent = 10.0;
double _entryMargin = 2.0;
double _stopLossMargin = 2.0;
int _takeProfit = 3.0;

double _risk = 0.0;
double _entry = 0.0;
double _stopLoss = 0.0;

//+------------------------------------------------------------------+
void OnStart()
  {
   _risk = AccountBalance() * (_riskInPercent / 100);
   _entry = Low[1] - _entryMargin * PipValue();
   _stopLoss = High[1] + _stopLossMargin * PipValue() + SpreadValue();

   OrderSet(_entry,_stopLoss,_risk,_takeProfit);
  }

//+------------------------------------------------------------------+
