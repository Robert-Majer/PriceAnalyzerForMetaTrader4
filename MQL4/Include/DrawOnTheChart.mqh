//+------------------------------------------------------------------+
//|                                               DrawOnTheChart.mqh |
//|                                                     Robert Majer |
//+------------------------------------------------------------------+

#property copyright "Copyright 2022, Robert Majer"
#property version   "1.00"
#property strict

#include <PrimaryFunctions.mqh>

//+------------------------------------------------------------------+
void CreateFiboLevels(double openPrice, double stopLossPrice, datetime timeSignalPeriod, int numberOfTakeProfitLevels)
  {
   datetime timePeriodShift = timeSignalPeriod + D'1970.00.00 01:00:00';

   if(numberOfTakeProfitLevels < 1)
     {
      numberOfTakeProfitLevels = 1;
     }

   if(openPrice > stopLossPrice)
     {
      string objectFibo = "FIBO Levels Buy " +  Symbol() + " " + TimeToStr(timeSignalPeriod);
      ObjectCreate(objectFibo, OBJ_FIBO,0,timeSignalPeriod,openPrice,timePeriodShift,stopLossPrice);
      ObjectSet(objectFibo, OBJPROP_COLOR, Red);
      ObjectSet(objectFibo,OBJPROP_LEVELCOLOR, Gray);
      ObjectSet(objectFibo,OBJPROP_LEVELS,10);
      ObjectSet(objectFibo,OBJPROP_FIBOLEVELS,(numberOfTakeProfitLevels+2));

      for(int i=0; i<=(numberOfTakeProfitLevels+1); i++)
        {
         int levelText = i - 1;

         ObjectSetString(0,objectFibo,OBJPROP_LEVELTEXT,i,IntegerToString(levelText));
         ObjectSetDouble(0,objectFibo,OBJPROP_LEVELVALUE,i,i);
        }
     }
   else
      if(openPrice < stopLossPrice)
        {
         string objectFibo = "FIBO Levels Sell " + Symbol() + " " + TimeToStr(timeSignalPeriod);
         ObjectCreate(objectFibo, OBJ_FIBO,0,timePeriodShift,openPrice,timeSignalPeriod,stopLossPrice);
         ObjectSet(objectFibo, OBJPROP_COLOR, Red);
         ObjectSet(objectFibo,OBJPROP_LEVELCOLOR, Gray);
         ObjectSet(objectFibo,OBJPROP_LEVELS,5);
         ObjectSet(objectFibo,OBJPROP_FIBOLEVELS,(numberOfTakeProfitLevels+2));

         for(int i=0; i<=(numberOfTakeProfitLevels+1); i++)
           {
            int levelText = i - 1;

            ObjectSetString(0,objectFibo,OBJPROP_LEVELTEXT,i,IntegerToString(levelText));
            ObjectSetDouble(0,objectFibo,OBJPROP_LEVELVALUE,i,i);
           }
        }
  }

//+------------------------------------------------------------------+
void CreateArrow(bool isBuy, int candleNumber, int gapInPips = 5)
  {
   double _gapInPips = gapInPips*PipValue();

   if(isBuy == true)
     {
      string objectArrow = "BuyArrow " + Symbol() + " " + TimeToStr(TimeCurrent());
      ObjectCreate(objectArrow,OBJ_ARROW,0,Time[candleNumber],(Low[candleNumber] - _gapInPips));
      ObjectSet(objectArrow,OBJPROP_COLOR,Green);
      ObjectSet(objectArrow,OBJPROP_ARROWCODE,SYMBOL_ARROWUP);
     }
   else
     {
      string objectArrow = "SellArrow " + Symbol() + " " + TimeToStr(TimeCurrent());
      ObjectCreate(objectArrow,OBJ_ARROW,0,Time[candleNumber],(High[candleNumber] + (_gapInPips+5*PipValue())));
      ObjectSet(objectArrow,OBJPROP_COLOR,Red);
      ObjectSet(objectArrow,OBJPROP_ARROWCODE,SYMBOL_ARROWDOWN);
     }
  }

//+------------------------------------------------------------------+
void CreateRectangle(double highRectangle, double lowRectangle, datetime startRectangle, datetime finishRectangle)
  {
   string objectRectangle = "Object rectangle " + Symbol() + " " + TimeToStr(startRectangle);
   ObjectCreate(objectRectangle, OBJ_RECTANGLE,0,startRectangle,highRectangle,finishRectangle,lowRectangle);
   ObjectSet(objectRectangle, OBJPROP_COLOR, LightGray);
  }

//+------------------------------------------------------------------+
void CreateBoldHorizontalLine(double linePrice, datetime lineTime, color lineColor)
  {
   string objectBoldHorizontalLine = "BoldHorizontalLine" + " " + TimeToStr(TimeCurrent())+ " " + DoubleToStr(linePrice);
   ObjectCreate(objectBoldHorizontalLine, OBJ_HLINE, 0, lineTime, linePrice);
   ObjectSet(objectBoldHorizontalLine, OBJPROP_COLOR,lineColor);
   ObjectSet(objectBoldHorizontalLine,8,5);
  }

//+------------------------------------------------------------------+
