//+------------------------------------------------------------------+
//|                                      DailyTimeframeFunctions.mqh |
//|                                                     Robert Majer |
//+------------------------------------------------------------------+

#property copyright "Copyright 2022, Robert Majer"
#property version   "1.00"
#property strict

#include <PrimaryFunctions.mqh>
#include <DrawOnTheChart.mqh>
#include <CandlesVerification.mqh>

//global variable
int dailyMotherBarNumber = 0;

datetime dailyMotherBarTime;
double dailyMotherBarHigh;
double dailyMotherBarLow;

datetime oneDayAgoCandleTime;
double oneDayAgoCandleHigh;
double oneDayAgoCandleLow;

datetime twoDayAgoCandleTime;
double twoDayAgoCandleHigh;
double twoDayAgoCandleLow;

datetime threeDayAgoCandleTime;
double threeDayAgoCandleHigh;
double threeDayAgoCandleLow;

double dailyImportantLevels[8];

bool areDailyHorizontalLinesOnChart = false;

//+------------------------------------------------------------------+
void SetHorizontalLinesOnChart()
  {
   string today = TimeToStr(Time[0],TIME_DATE);
   string todayPeriodD1Confirmation = TimeToStr(iTime(NULL,PERIOD_D1,0),TIME_DATE);

   if(today == todayPeriodD1Confirmation)
     {
      oneDayAgoCandleHigh = iHigh(NULL,PERIOD_D1,1);
      dailyImportantLevels[2] = oneDayAgoCandleHigh;
      oneDayAgoCandleLow = iLow(NULL,PERIOD_D1,1);
      dailyImportantLevels[3] = oneDayAgoCandleLow;
      oneDayAgoCandleTime = iTime(NULL,PERIOD_D1,1);

      CreateBoldHorizontalLine(oneDayAgoCandleHigh,oneDayAgoCandleTime,Red);
      CreateBoldHorizontalLine(oneDayAgoCandleLow,oneDayAgoCandleTime,Red);

      twoDayAgoCandleHigh = iHigh(NULL,PERIOD_D1,2);
      dailyImportantLevels[4] = twoDayAgoCandleHigh;
      twoDayAgoCandleLow = iLow(NULL,PERIOD_D1,2);
      dailyImportantLevels[5] = twoDayAgoCandleLow;
      twoDayAgoCandleTime = iTime(NULL,PERIOD_D1,2);

      CreateBoldHorizontalLine(twoDayAgoCandleHigh,twoDayAgoCandleTime,DarkOrange);
      CreateBoldHorizontalLine(twoDayAgoCandleLow,twoDayAgoCandleTime,DarkOrange);

      threeDayAgoCandleHigh = iHigh(NULL,PERIOD_D1,3);
      dailyImportantLevels[6] = threeDayAgoCandleHigh;
      threeDayAgoCandleLow = iLow(NULL,PERIOD_D1,3);
      dailyImportantLevels[7] = threeDayAgoCandleLow; 
      threeDayAgoCandleTime = iTime(NULL,PERIOD_D1,3);

      CreateBoldHorizontalLine(threeDayAgoCandleHigh,threeDayAgoCandleTime,Gold);
      CreateBoldHorizontalLine(threeDayAgoCandleLow,threeDayAgoCandleTime,Gold);

      areDailyHorizontalLinesOnChart = true;
     }
  }

//+------------------------------------------------------------------+
int YesterdayDailyCandleInsideBarVerification(bool markOnTheChart = true)
  {
   string today = TimeToStr(Time[0],TIME_DATE);
   string todayPeriodD1Confirmation = TimeToStr(iTime(NULL,PERIOD_D1,0),TIME_DATE);

   int motherNumberBar = 0;

   if(today == todayPeriodD1Confirmation)
     {
      motherNumberBar = InsideBarVerification(1,20,PERIOD_D1);
     }

   if(motherNumberBar > 0)
     {
      dailyMotherBarNumber = motherNumberBar;
      if(markOnTheChart == true)
        {
         dailyMotherBarHigh = iHigh(NULL,PERIOD_D1,dailyMotherBarNumber);
         dailyImportantLevels[0] = dailyMotherBarHigh;
         dailyMotherBarLow = iLow(NULL,PERIOD_D1,dailyMotherBarNumber);
         dailyImportantLevels[1] = dailyMotherBarLow;
         dailyMotherBarTime = iTime(NULL,PERIOD_D1,dailyMotherBarNumber);

         CreateBoldHorizontalLine(dailyMotherBarHigh,dailyMotherBarTime,Gray);
         CreateBoldHorizontalLine(dailyMotherBarLow,dailyMotherBarTime,Gray);
         CreateRectangle(dailyMotherBarHigh,dailyMotherBarLow,dailyMotherBarTime,TimeCurrent());
        }
      return dailyMotherBarNumber;
     }
   else
     {
      dailyMotherBarNumber = 0;
      return 0;
     }
  }

//+------------------------------------------------------------------+
string YesterdayDailyCandleVerification()
  {
   string result;

   if(BullishPinbarVerification(1,0.65,0.35,1440) == true)
     {
      result += "Bullish Pin Bar ";
     }
   else
      if(BullishEngulfingBarVerification(1,1440) == true)
        {
         result += "Bullish Engulfing Bar ";
        }
   if(BearishPinbarVerification(1,0.65,0.35,1440) == true)
     {
      result += "Bearish Pin Bar ";
     }
   else
      if(BearishEngulfingBarVerification(1,1440) == true)
        {
         result += "Bearish Engulfing Bar ";
        }

   return result;
  }

//+------------------------------------------------------------------+
