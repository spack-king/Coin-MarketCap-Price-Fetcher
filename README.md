# Coin-MarketCap-Price-Fetcher
The provided code is an MQL5 script designed for fetching and displaying cryptocurrency prices from the CoinMarketCap API. Here's a brief description:

---

### Description of `coinmarket_price.mq5`

This MQL5 script allows users to retrieve and display the current price of a specified cryptocurrency (e.g., Bitcoin) at regular intervals. Key features include:

- **User Inputs**: The script accepts user-defined inputs for the cryptocurrency symbol, update interval (in minutes), and API key for CoinMarketCap.
- **Initialization**: On initialization, the script checks for a valid API key and sets a timer to periodically fetch the coin's price.
- **Price Fetching**: The `GetCoinPrice` function sends a web request to the CoinMarketCap API to retrieve the latest price data. It includes error handling to notify users if the request fails.
- **JSON Parsing**: The `ParsePrice` function processes the API response to extract and display the current price of the cryptocurrency.
- **Deinitialization**: The script cleans up by killing the timer when deinitialized.

This script is a useful tool for traders and investors looking to monitor cryptocurrency prices in real-time.

--- 
- [Visit] (https://www.mql5.com/en/market/product/125023)
