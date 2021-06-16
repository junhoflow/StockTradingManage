package stock;

public class StockDTO {
	
	private int stockID;
	private String stockName;
	private String buysell;
	private String stockQuantity;
	private String stockPrice;
	private String buyReason;
	private String todayDate;
	private String userID;
	public String getStockName() {
		return stockName;
	}
	public void setStockName(String stockName) {
		this.stockName = stockName;
	}
	public String getBuysell() {
		return buysell;
	}
	public void setBuysell(String buysell) {
		this.buysell = buysell;
	}
	public String getStockQuantity() {
		return stockQuantity;
	}
	public void setStockQuantity(String stockQuantity) {
		this.stockQuantity = stockQuantity;
	}
	public String getStockPrice() {
		return stockPrice;
	}
	public void setStockPrice(String stockPrice) {
		this.stockPrice = stockPrice;
	}
	public String getBuyReason() {
		return buyReason;
	}
	public void setBuyReason(String buyReason) {
		this.buyReason = buyReason;
	}
	public String getTodayDate() {
		return todayDate;
	}
	public void setTodayDate(String todayDate) {
		this.todayDate = todayDate;
	}
	public int getStockID() {
		return stockID;
	}
	public void setStockID(int stockID) {
		this.stockID = stockID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
}
