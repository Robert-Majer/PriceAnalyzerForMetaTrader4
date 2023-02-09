//+------------------------------------------------------------------+
//|                                             PrimaryFunctions.mqh |
//|                                                     Robert Majer |
//+------------------------------------------------------------------+

#property copyright "Copyright 2022, Robert Majer"
#property version   "1.00"
#property strict

//+------------------------------------------------------------------+
double PipValue()
  {
   if(Digits>=4)
     {
      return 0.0001;
     }
   else
     {
      return 0.01;
     }

  }
  
//+------------------------------------------------------------------+
double SpreadValue()
  {
   double spread = Ask - Bid;
   return spread;
  }
  
//+------------------------------------------------------------------+
