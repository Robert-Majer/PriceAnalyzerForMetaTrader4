//+------------------------------------------------------------------+
//|                                               OrderFunctions.mqh |
//|                                                     Robert Majer |
//+------------------------------------------------------------------+

#property copyright "Copyright 2022, Robert Majer"
#property version   "1.00"
#property strict

#include <PrimaryFunctions.mqh>
#include <DrawOnTheChart.mqh>

//+------------------------------------------------------------------+
void MyOrderClose()
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      double priceBid = MarketInfo(OrderSymbol(),MODE_BID);
      double priceAsk = MarketInfo(OrderSymbol(),MODE_ASK);

      bool result = false;
      int priceSlippage = 0;

      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderType() == OP_BUY)
           {
            result = OrderClose(OrderTicket(),OrderLots(),priceBid,priceSlippage);
           }
         else
            if(OrderType() == OP_SELL)
              {
               result = OrderClose(OrderTicket(),OrderLots(),priceAsk,priceSlippage);
              }
         if(result == false)
           {
            Print("Warning! Unable to close transaction number: ",OrderTicket(),"; error number: ",GetLastError());
           }
        }
     }
  }

//+------------------------------------------------------------------+
double OrderSize(bool isBuy, double entryPrice, double exitPrice, double lossSize)
  {
   double lotSize=0.0;

   if(isBuy)
     {
      double pips = (entryPrice-exitPrice)/PipValue();
      double value = lossSize/MarketInfo(NULL,MODE_TICKVALUE)/pips;
      lotSize = value/10;
      lotSize *= 100;
      lotSize = MathFloor(lotSize);
      lotSize /= 100;
     }
   else
     {
      double pips = (exitPrice-entryPrice)/PipValue();
      double value = lossSize/MarketInfo(NULL,MODE_TICKVALUE)/pips;
      lotSize = value/10;
      lotSize *= 100;
      lotSize = MathFloor(lotSize);
      lotSize /= 100;
     }
   if(lotSize < 0.01)
     {
      lotSize = 0.01;
     }
   return (lotSize);
  }

//+------------------------------------------------------------------+
void StopLossModifier(double priceMarginTralingStop)
  {
   for(int i=OrdersTotal()-1; i >= 0; i--)
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
        {
         if(OrderSymbol() == Symbol())
           {

            if(OrderType() == OP_BUY)

              {
               if(OrderStopLoss() < Low [1] - priceMarginTralingStop * PipValue())
                 {
                  bool orderModifyBuy = OrderModify(OrderTicket(), OrderOpenPrice(), (Low[1] - priceMarginTralingStop * PipValue()), OrderTakeProfit(), OrderExpiration(), clrNONE);
                  Alert(Symbol() + " StopLoss modifited BUY");
                  SendNotification(Symbol() + " StopLoss modifited BUY");
                 }
              }

            if(OrderType() == OP_SELL)
              {
               if(OrderStopLoss() > High[1] + priceMarginTralingStop * PipValue())
                 {
                  bool orderModifySell = OrderModify(OrderTicket(), OrderOpenPrice(), (High[1] + priceMarginTralingStop * PipValue() + SpreadValue()), OrderTakeProfit(), OrderExpiration(), clrNONE);
                  Alert(Symbol() + " StopLoss modifited SELL");
                  SendNotification(Symbol() + " StopLoss modifited SELL");
                 }
              }
           }
        }
  }

//+------------------------------------------------------------------+
void OrderSet(double entry, double stopLoss, double risk, int takeProfit)//dołożyć is buy, takeprofit ile razy,
  {
   double volume = 0.0;
   double takeProfitPrice = 0.0;

   if(entry > stopLoss)
     {
      takeProfitPrice = entry + (entry - stopLoss) * takeProfit;

      volume = OrderSize(true, entry, stopLoss,risk);
      if(volume < 0.01)
        {
         volume = 0.01;
        }

      if(entry != 0 && stopLoss != 0 && Ask < entry)
         int orderBuy = OrderSend(NULL,OP_BUYSTOP,volume,entry,1,stopLoss,takeProfitPrice,NULL,0,0,clrNONE);
      else
         if(entry != 0 && stopLoss != 0 && Ask > entry)
            int orderBuy = OrderSend(NULL,OP_BUYLIMIT,volume,entry,1,stopLoss,takeProfitPrice,NULL,0,0,clrNONE);

      CreateFiboLevels(entry, stopLoss,Time[1],takeProfit);

      Print("Entry " + DoubleToString(entry,5));
      Print("StopLoss " + DoubleToString(stopLoss,5));
      Print("TakeProfit " + DoubleToString(takeProfitPrice,5));
      Print("Lot " + DoubleToString(volume,2));
      Print("Account balance: " + DoubleToString(AccountBalance()));
      Print("Risk: " + DoubleToString(risk));
     }

   else
      if(entry < stopLoss)
        {
         takeProfitPrice = entry - (stopLoss - entry) * takeProfit;

         volume = OrderSize(false, entry, stopLoss,risk);
         if(volume < 0.01)
           {
            volume = 0.01;
           }

         if(entry != 0 && stopLoss != 0 && Bid > entry)
            int orderSell = OrderSend(NULL,OP_SELLSTOP,volume,entry,1,stopLoss,takeProfitPrice,NULL,0,0,clrNONE);
         else
            if(entry != 0 && stopLoss != 0 && Bid < entry)
               int orderSell = OrderSend(NULL,OP_SELLLIMIT,volume,entry,1,stopLoss,takeProfitPrice,NULL,0,0,clrNONE);

         CreateFiboLevels(entry, stopLoss,Time[1],takeProfit);

         Print("Entry " + DoubleToString(entry,5));
         Print("StopLoss " + DoubleToString(stopLoss,5));
         Print("TakeProfit " + DoubleToString(takeProfitPrice,5));
         Print("Lot " + DoubleToString(volume,2));
         Print("Account balance: " + DoubleToString(AccountBalance()));
         Print("Risk: " + DoubleToString(risk));
        }
  }

//+------------------------------------------------------------------+
