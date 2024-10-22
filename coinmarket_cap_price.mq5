//+------------------------------------------------------------------+
//|                                             coinmarket_price.mq5 |
//|                                       Copyright 2024, Spack King |
//|                                        https://t.me/spack_king   |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, Spack King"
#property link      "https://t.me/spack_king"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
input string CoinSymbol = "BTC"; // Symbol of the coin (e.g., BTC for Bitcoin)
input int UpdateInterval = 1;    // Update interval in minutes
input string APIKEY = "";    // Enter your Coin Market Api key

string apiKey = APIKEY; // Place your API key here
string baseURL = "https://pro-api.coinmarketcap.com/v2/cryptocurrency/quotes/latest";

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
   if(apiKey == "")
     {
     Alert("Enter a valid Api key");
      return INIT_PARAMETERS_INCORRECT;
     }
  Alert("CoinMarketCap Api initalized!");
// Set a timer to call OnTimer() every 'UpdateInterval' minutes
   EventSetTimer(UpdateInterval * 60); // Convert minutes to seconds
   return INIT_SUCCEEDED;
  }

//+------------------------------------------------------------------+
//| Timer function to be called periodically                         |
//+------------------------------------------------------------------+
void OnTimer()
  {
    GetCoinPrice(CoinSymbol);
   //if(price != -1)
   //  {
   //   string msg = "The current price of " + CoinSymbol + " is: $", price;
   //   Alert(msg);
   //   Print(msg);
   //  }
   //else
   //  {
   //   Print("Failed to fetch price for ", CoinSymbol);
   //  }
  }

//+------------------------------------------------------------------+
//| Fetch coin price from CoinMarketCap                              |
//+------------------------------------------------------------------+
void GetCoinPrice(string symbol)
  {
   string url = baseURL + "?symbol=" + symbol;
   char post_data[];
   char result[];
   string headers;

   headers = "X-CMC_PRO_API_KEY: " + apiKey;
   int timeout = 5000;
   int res = WebRequest("GET", url, headers, timeout, post_data, result, headers);

   ResetLastError();
   if(res == -1)

     {
      //add your URL into chart -> Tools - > option -> Expert Advisor -> Allow Web request From URL
      Print("Try adding ", url," into chart -> Tools - > option -> Expert Advisor -> Allow Web request From URL");
      Alert("Try adding ", url," into chart -> Tools - > option -> Expert Advisor -> Allow Web request From URL");
      Print("Failed to fetch price for ", CoinSymbol);
      Print("Error in WebRequest: ", GetLastError(), res);
     

     }
   else
     {
      string jsonResponse = CharArrayToString(result, 0, WHOLE_ARRAY, CP_UTF8);
      ParsePrice(jsonResponse);

     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//| Parse the price from the CoinMarketCap API response               |
//+------------------------------------------------------------------+
void ParsePrice(string response_str)
  {

// Extract the price (or any other specific data) from the JSON response
   string price_key = "\"price\":";
   int price_index = StringFind(response_str, price_key);
   if(price_index != -1)
     {
      int price_start = price_index + StringLen(price_key);
      string price_str = StringSubstr(response_str, price_start, 6);  // Extracting 6 characters as price (example)
      double price = StringToDouble(price_str);
      
      string msg = "The current price of " + CoinSymbol + " is: $" + price;
       Print(msg);
     }

  }

//+------------------------------------------------------------------+
//| Deinitialization function                                        |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   EventKillTimer(); // Remove the timer when deinitialized
  }
//+------------------------------------------------------------------+
