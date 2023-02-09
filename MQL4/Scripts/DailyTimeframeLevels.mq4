//+------------------------------------------------------------------+
//|                                         DailyTimeframeLevels.mq4 |
//|                                                     Robert Majer |
//+------------------------------------------------------------------+

#property copyright "Copyright 2022, Robert Majer"
#property version   "1.00"
#property strict

#include <DailyTimeframeFunctions.mqh>

//+------------------------------------------------------------------+
void OnStart()
  {
   YesterdayDailyCandleInsideBarVerification();
   SetHorizontalLinesOnChart();
  }

//+------------------------------------------------------------------+
