//+------------------------------------------------------------------+
//|                                        PriceAnalyzerPeriodH1.mq4 |
//|                                                     Robert Majer |
//+------------------------------------------------------------------+

#property copyright "Robert Majer"
#property version   "1.00"
#property strict
#property show_inputs

#include <DailyTimeframeFunctions.mqh>
#include <OrderFunctions.mqh>


input bool _isSLModifierOn = true; // Turn on SL modifier
input double _priceMarginTralingStop = 2.0; // SL modifier margin of error
input double _marginSRInPercent = 7.0; // Price level margin of error [%]

//First step variable
string _dailyCheck;

//Second step variable
datetime _actualPeriodTime;


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {

//+------------------------------------------------------------------+
//FIRST STEP

   if(areDailyHorizontalLinesOnChart == false)
     {
      ObjectsDeleteAll();
      SetHorizontalLinesOnChart();
      DailyCandleCheck();
     }

//+------------------------------------------------------------------+
// SECOND STEP

   if(Time[0] > _actualPeriodTime)
     {
      _actualPeriodTime = Time[0];

      if(ChartPeriod(0) == 60)
        {
         CandleAnalyzerPeriodH1();
        }
      else
         if(ChartPeriod(0) != 60)
           {
            Alert("Switch chart period on H1");
            SendNotification("Switch chart period on H1");
           }

      if(_isSLModifierOn == true)
        {
         StopLossModifier(_priceMarginTralingStop);
        }
     }
  }

//+------------------------------------------------------------------+
// THIRD STEP

void CandleAnalyzerPeriodH1()
  {
   string descriptionForAlert = Symbol() + " signal: ";
   string result = NULL;
   string descriptionForInsideBar = NULL;
   string descriptionForDailyCheck = NULL;

   if(_dailyCheck != NULL)
     {
      descriptionForDailyCheck = "[D1: " + _dailyCheck + "]";
     }

   int candleNumber = 1;
   int numberOfCandles = 24;

   if(BullishPinbarVerification(candleNumber,0.65,0.35,0) == true)
     {
      result += "BUY Pin Bar, ";
     }
   else
      if(BullishEngulfingBarVerification(candleNumber,0) == true)
        {
         result += " BUY Engulfing Bar, ";
        }

   if(BearishPinbarVerification(candleNumber,0.65,0.35,0) == true)
     {
      result += "SELL Pin Bar, ";
     }
   else
      if(BearishEngulfingBarVerification(candleNumber,0) == true)
        {
         result += "SELL Engulfing Bar, ";
        }

   int numberMotherBar = InsideBarVerification(candleNumber,numberOfCandles);

   if(numberMotherBar > 0)
     {
      descriptionForInsideBar += "WARNING! Inside Bar! (" + IntegerToString(numberMotherBar) + ")" ;
     }

//+------------------------------------------------------------------+
// FOURTH STEP

   int resultIsPinBar = StringFind(result,"Pin Bar");
   int resultIsEngulfingBar = StringFind(result,"Engulfing Bar");

   bool isConfirmedSignal = false;

   if(dailyMotherBarHigh > 0 && dailyMotherBarLow > 0)
     {
      if(resultIsPinBar >= 0)
        {
         for(int i=0; i<2; i++)
           {
            if(PriceLevelVerification(dailyImportantLevels[i],_marginSRInPercent,High[1],Low[1]) == true)
              {
               isConfirmedSignal = true;
              }
           }
        }
      else
         if(resultIsEngulfingBar >= 0)
           {
            int higherCandleNumber = iHighest(NULL,NULL,MODE_HIGH,2,1);
            int lowerCandleNumber = iLowest(NULL,NULL,MODE_LOW,2,1);

            for(int i=0; i<2; i++)
              {
               if(PriceLevelVerification(dailyImportantLevels[i],_marginSRInPercent,High[higherCandleNumber],Low[lowerCandleNumber]) == true)
                 {
                  isConfirmedSignal = true;
                 }
              }
           }
     }
   else
     {
      if(resultIsPinBar >= 0)
        {
         for(int i=0; i<8; i++)
           {
            if(PriceLevelVerification(dailyImportantLevels[i],_marginSRInPercent,High[1],Low[1]) == true)
              {
               isConfirmedSignal = true;
              }
           }
        }
      else
         if(resultIsEngulfingBar >= 0)
           {
            int higherCandleNumber = iHighest(NULL,NULL,MODE_HIGH,2,1);
            int lowerCandleNumber = iLowest(NULL,NULL,MODE_LOW,2,1);

            for(int i=0; i<8; i++)
              {
               if(PriceLevelVerification(dailyImportantLevels[i],_marginSRInPercent,High[higherCandleNumber],Low[lowerCandleNumber]) == true)
                 {
                  isConfirmedSignal = true;
                 }
              }
           }
     }

//+------------------------------------------------------------------+
// FIFTH STEP

   if(result != NULL && isConfirmedSignal == true)
     {
      if(numberMotherBar > 0)
        {
         CreateRectangle(High[numberMotherBar],Low[numberMotherBar],Time[numberMotherBar],Time[1]);
        }

      Alert(descriptionForAlert + result + descriptionForInsideBar + descriptionForDailyCheck);
      SendNotification(descriptionForAlert + result + descriptionForInsideBar + descriptionForDailyCheck);

      int resultIsBuy = StringFind(result,"BUY");
      int resultIsSell = StringFind(result,"SELL");

      if(resultIsBuy >= 0)
        {
         CreateArrow(true,1);
        }
      else
         if(resultIsSell >= 0)
           {
            CreateArrow(false,1);
           }
     }
  }


//+------------------------------------------------------------------+
//Function for first step

void DailyCandleCheck()
  {
   string descriptionForAlert = "Yesterday candle is: ";
   string result = NULL;

   int isInsideBar = YesterdayDailyCandleInsideBarVerification(true);
   string yesderdayCandleCheck = YesterdayDailyCandleVerification();

   if(isInsideBar > 0)
     {
      result += "Inside Bar(" + IntegerToString(isInsideBar) + "), " ;
     }

   result += yesderdayCandleCheck;

   if(isInsideBar > 0 || yesderdayCandleCheck != NULL)
     {
      Alert(Symbol() + "  " + descriptionForAlert + result);
      SendNotification(Symbol() + "  " + descriptionForAlert + result);
      _dailyCheck = result;
     }
   else
     {
      Alert(Symbol() + "  Yesterday's candle was checked");
      SendNotification(Symbol() + "  Yesterday's candle was checked");
     }
  }

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   Print(Symbol() + " EA Deleted " + TimeToStr(TimeCurrent(),TIME_MINUTES));
  }

//+------------------------------------------------------------------+
