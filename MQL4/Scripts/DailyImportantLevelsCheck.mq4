//+------------------------------------------------------------------+
//|                                    DailyImportantLevelsCheck.mq4 |
//|                                                     Robert Majer |
//+------------------------------------------------------------------+

#property copyright "Copyright 2022, Robert Majer"
#property version   "1.00"
#property strict

#include <DailyTimeframeFunctions.mqh>

//+------------------------------------------------------------------+
void OnStart()
  {
   SetHorizontalLinesOnChart();
   int isInsideBar = YesterdayDailyCandleInsideBarVerification(false);

   if(isInsideBar > 0)
     {
      Alert("Mother candle high: " + DoubleToString(dailyImportantLevels[0]));
      Alert("Mother candle low: " + DoubleToString(dailyImportantLevels[1]));
     }

   Alert("One day ago candle high: " + DoubleToString(dailyImportantLevels[2]));
   Alert("One day ago candle low: " + DoubleToString(dailyImportantLevels[3]));

   Alert("Two day ago candle high: " + DoubleToString(dailyImportantLevels[4]));
   Alert("Two day ago candle low: " + DoubleToString(dailyImportantLevels[5]));

   Alert("Three day ago candle high: " + DoubleToString(dailyImportantLevels[6]));
   Alert("Three day ago candle low: " + DoubleToString(dailyImportantLevels[7]));
  }
  
//+------------------------------------------------------------------+
