//+------------------------------------------------------------------+
//|                                               DrawFiboLevels.mq4 |
//|                                                     Robert Majer |
//+------------------------------------------------------------------+

#property copyright "Copyright 2022, Robert Majer"
#property version   "1.00"
#property strict
#property show_inputs

#include <DrawOnTheChart.mqh>
#include <PrimaryFunctions.mqh>

input int _highCandleNumber = 1; // Higher price - Candle number
input int _lowCandleNumber = 1; // Lower price - Candle number
input bool _isBuy = true; //Is buy order?
input double _orderGap = 1.0; // Order margin of error [pips]
input double _stopLossGap = 1.0; // StopLoss margin of error [pips]
input int _numberOfTakeProfitLevels = 5; //Number of TP levels

//+------------------------------------------------------------------+
void OnStart()
  {
   datetime timeSignalPeriod;

   if(_highCandleNumber >= _lowCandleNumber)
     {
      timeSignalPeriod = Time[_highCandleNumber];
     }
   else
     {
      timeSignalPeriod = Time[_lowCandleNumber];
     }

   if(_isBuy == true)
     {
      double openPrice = High[_highCandleNumber] + (_orderGap*PipValue()) + SpreadValue();
      double stopLossPrice = Low[_lowCandleNumber] - (_stopLossGap*PipValue());

      CreateFiboLevels(openPrice,stopLossPrice,timeSignalPeriod,_numberOfTakeProfitLevels);
     }
   else
     {
      double openPrice = Low[_lowCandleNumber]  - (_orderGap*PipValue());
      double stopLossPrice = High[_highCandleNumber] + (_stopLossGap*PipValue()) + SpreadValue();

      CreateFiboLevels(openPrice,stopLossPrice,timeSignalPeriod,_numberOfTakeProfitLevels);
     }
  }

//+------------------------------------------------------------------+
