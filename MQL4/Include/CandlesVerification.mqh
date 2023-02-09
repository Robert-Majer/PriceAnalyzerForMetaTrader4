//+------------------------------------------------------------------+
//|                                          CandlesVerification.mqh |
//|                                                     Robert Majer |
//+------------------------------------------------------------------+

#property copyright "Copyright 2022, Robert Majer"
#property version   "1.00"
#property strict

//+------------------------------------------------------------------+
bool BullishPinbarVerification(int candleNumber, double candleBodySize = 0.65, double candleBodyPosition = 0.35, int timeframe = PERIOD_CURRENT)
  {
   double highCandle = iHigh(NULL,timeframe,candleNumber);
   double lowCandle = iLow(NULL,timeframe,candleNumber);
   double openCandle = iOpen(NULL,timeframe,candleNumber);
   double closeCandle = iClose(NULL,timeframe,candleNumber);

   if((closeCandle >= openCandle) &&
      (((highCandle - lowCandle)*candleBodySize) >= (closeCandle - openCandle)) &&
      ((lowCandle + (highCandle - lowCandle)*candleBodyPosition) <=  openCandle) &&
      (lowCandle + (highCandle - lowCandle)*candleBodyPosition) <= closeCandle)
     {
      return true;
     }
   else
      if((closeCandle <= openCandle) && (((highCandle - lowCandle)*candleBodySize) >= (openCandle - closeCandle)) &&
         ((lowCandle + (highCandle - lowCandle)*candleBodyPosition) <=  closeCandle) &&
         (lowCandle + (highCandle - lowCandle)*candleBodyPosition) <= openCandle)
        {
         return true;
        }
      else
        {
         return false;
        }
  }

//+------------------------------------------------------------------+
bool BearishPinbarVerification(int candleNumber, double candleBodySize = 0.65, double candleBodyPosition = 0.35, int timeframe = PERIOD_CURRENT)
  {
   double highCandle = iHigh(NULL,timeframe,candleNumber);
   double lowCandle = iLow(NULL,timeframe,candleNumber);
   double openCandle = iOpen(NULL,timeframe,candleNumber);
   double closeCandle = iClose(NULL,timeframe,candleNumber);

   if((closeCandle >= openCandle) &&
      (((highCandle - lowCandle)*candleBodySize) >= (closeCandle - openCandle)) &&
      ((highCandle - (highCandle - lowCandle)*candleBodyPosition) >=  closeCandle) &&
      (highCandle - (highCandle - lowCandle)*candleBodyPosition) >= openCandle)
     {
      return true;
     }
   else
      if((closeCandle <= openCandle) &&
         (((highCandle - lowCandle)*candleBodySize) >= (openCandle - closeCandle)) &&
         ((highCandle - (highCandle - lowCandle)*candleBodyPosition) >=  openCandle) &&
         (highCandle - (highCandle - lowCandle)*candleBodyPosition) >= closeCandle)
        {
         return true;
        }
      else
        {
         return false;
        }
  }

//+------------------------------------------------------------------+
int InsideBarVerification(int candleNumberToCheck, int numberOfCandlesToCheck, int timeframe = PERIOD_CURRENT)
  {
   int numberOfFirstCandleToCheck = candleNumberToCheck + numberOfCandlesToCheck;

   bool isInsideBar = false;
   double highMotherBar = 0.0;
   double lowMotherBar = 0.0;
   int motherNumberBar = 0;

   for(int i=numberOfFirstCandleToCheck; i>=candleNumberToCheck; i--)
     {
      double highPreviousCandle = iHigh(NULL,timeframe,(i + 1));
      double lowPreviousCandle = iLow(NULL,timeframe,(i + 1));

      double highCheckCandle = iHigh(NULL,timeframe,i);
      double lowCheckCandle = iLow(NULL,timeframe,i);

      if(isInsideBar == false)
        {
         if(highPreviousCandle >= highCheckCandle && lowPreviousCandle <= lowCheckCandle)
           {
            isInsideBar = true;
            motherNumberBar = i + 1;
            lowMotherBar = lowPreviousCandle;
            highMotherBar = highPreviousCandle;
           }
        }

      if(isInsideBar == true)
        {
         if(highMotherBar < highCheckCandle || lowMotherBar > lowCheckCandle)
           {
            isInsideBar = false;
            highMotherBar = 0.0;
            lowMotherBar = 0.0;
            motherNumberBar = 0;
           }
        }
     }
   if(isInsideBar == true && motherNumberBar > 0)
     {
      return motherNumberBar;
     }
   else
     {
      return 0;
     }
  }

//+------------------------------------------------------------------+
bool InsideBarVerificationBool(int candleNumberToCheck, int numberOfCandlesToCheck, int timeframe = PERIOD_CURRENT)
  {
   int numberOfFirstCandleToCheck = candleNumberToCheck + numberOfCandlesToCheck;

   bool isInsideBar = false;
   double highMotherBar = 0.0;
   double lowMotherBar = 0.0;
   int motherNumberBar = 0;

   for(int i=numberOfFirstCandleToCheck; i>=candleNumberToCheck; i--)
     {
      double highPreviousCandle = iHigh(NULL,timeframe,(i + 1));
      double lowPreviousCandle = iLow(NULL,timeframe,(i + 1));

      double highCheckCandle = iHigh(NULL,timeframe,i);
      double lowCheckCandle = iLow(NULL,timeframe,i);

      if(isInsideBar == false)
        {
         if(highPreviousCandle >= highCheckCandle && lowPreviousCandle <= lowCheckCandle)
           {
            isInsideBar = true;
            motherNumberBar = i + 1;
            lowMotherBar = lowPreviousCandle;
            highMotherBar = highPreviousCandle;
           }
        }

      if(isInsideBar == true)
        {
         if(highMotherBar < highCheckCandle || lowMotherBar > lowCheckCandle)
           {
            isInsideBar = false;
            highMotherBar = 0.0;
            lowMotherBar = 0.0;
            motherNumberBar = 0;
           }
        }
     }
   if(isInsideBar == true && motherNumberBar > 0)
     {
      return true;
     }
   else
     {
      return false;
     }
  }

//+------------------------------------------------------------------+
bool BullishEngulfingBarVerification(int candleNumber, int timeframe = PERIOD_CURRENT)
  {
   double openCandle = iOpen(NULL,timeframe,candleNumber);
   double closeCandle = iClose(NULL,timeframe,candleNumber);

   double openPreviousCandle = iOpen(NULL,timeframe,(candleNumber +1));
   double closePreviousCandle = iClose(NULL,timeframe,(candleNumber +1));
   double highPreviousCandle = iHigh(NULL,timeframe,(candleNumber +1));

   if(openPreviousCandle >= closePreviousCandle && openCandle < closeCandle && highPreviousCandle <= closeCandle)
     {
      return true;
     }
   else
     {
      return false;
     }
  }

//+------------------------------------------------------------------+
bool BearishEngulfingBarVerification(int candleNumber, int timeframe = PERIOD_CURRENT)
  {
   double openCandle = iOpen(NULL,timeframe,candleNumber);
   double closeCandle = iClose(NULL,timeframe,candleNumber);

   double openPreviousCandle = iOpen(NULL,timeframe,(candleNumber +1));
   double closePreviousCandle = iClose(NULL,timeframe,(candleNumber +1));
   double lowPreviousCandle = iLow(NULL,timeframe,(candleNumber +1));

   if(openPreviousCandle <= closePreviousCandle && openCandle > closeCandle && lowPreviousCandle >= closeCandle)
     {
      return true;
     }
   else
     {
      return false;
     }
  }

//+------------------------------------------------------------------+
bool PriceLevelVerification(double priceLevelToCheck, double marginOfErrorInPercent, double signalHigh, double signalLow)
  {
   double dailyVolatility = iATR(NULL,PERIOD_D1,3,1);
   double marginDailyVolatility = dailyVolatility * (marginOfErrorInPercent / 100);

   double marginPriceLevelHigh = priceLevelToCheck + marginDailyVolatility;
   double marginPriceLevelLow = priceLevelToCheck - marginDailyVolatility;

   if(signalHigh >= priceLevelToCheck && priceLevelToCheck >= signalLow)
     {
      return true;
     }
   else
      if(marginPriceLevelHigh >= signalHigh && signalHigh >= marginPriceLevelLow)
        {
         return true;
        }
      else
         if(marginPriceLevelHigh >= signalLow && signalLow >= marginPriceLevelLow)
           {
            return true;
           }
         else
           {
            return false;
           }
  }
  
//+------------------------------------------------------------------+
