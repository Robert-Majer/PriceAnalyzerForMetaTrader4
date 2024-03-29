//+------------------------------------------------------------------+
//|                                                 OpenTheOrder.mq4 |
//|                                                     Robert Majer |
//+------------------------------------------------------------------+

#property copyright "Copyright 2022, Robert Majer"
#property version   "1.00"
#property strict
#property show_inputs

#include <OrderFunctions.mqh>

input int _candleNumberHigh = 1; // Candle number high to order
input int _candleNumberLow = 1; // Candle number low to order
input bool _isBuy = true; //Is buy order?

input double _riskInPercent = 10.0; //Order risk in percent
input double _entryMargin = 2.0; // Order margin of error [pips]
input double _stopLossMargin = 2.0; // StopLoss margin of error [pips]
input int _takeProfit = 3.0; //Multiple of profit

double _risk = 0.0;
double _entry = 0.0;
double _stopLoss = 0.0;

//+------------------------------------------------------------------+
void OnStart()
  {
   _risk = AccountBalance() * (_riskInPercent / 100);

   if(_isBuy == true)
     {
      _entry = High[_candleNumberHigh] + _entryMargin * PipValue() + SpreadValue();
      _stopLoss = Low[_candleNumberLow] - _stopLossMargin * PipValue();

      OrderSet(_entry,_stopLoss,_risk,_takeProfit);
     }
   else
     {
      _entry = Low[_candleNumberLow] - _entryMargin * PipValue();
      _stopLoss = High[_candleNumberHigh] + _stopLossMargin * PipValue() + SpreadValue();

      OrderSet(_entry,_stopLoss,_risk,_takeProfit);
     }
  }

//+------------------------------------------------------------------+
