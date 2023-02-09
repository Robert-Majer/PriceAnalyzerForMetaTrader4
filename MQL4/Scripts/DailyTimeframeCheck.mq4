//+------------------------------------------------------------------+
//|                                          DailyTimeframeCheck.mq4 |
//|                                                     Robert Majer |
//+------------------------------------------------------------------+

#property copyright "Copyright 2022, Robert Majer"
#property version   "1.00"
#property strict

#include <DailyTimeframeFunctions.mqh>

//+------------------------------------------------------------------+
void OnStart()
  {
   string result = "Yesterday candle is: ";

   int isInsideBar = YesterdayDailyCandleInsideBarVerification(false);
   string yesderdayCandleCheck = YesterdayDailyCandleVerification();

   if(isInsideBar > 0)
     {
      result += "Inside Bar[" + IntegerToString(isInsideBar) + "]on D1, " ;
     }

   result += yesderdayCandleCheck;

   if(isInsideBar > 0 || yesderdayCandleCheck != NULL)
     {
      Alert(result);
     }
     else
       {
        Alert("Yesterday's candle was checked");
       }
  }

//+------------------------------------------------------------------+
