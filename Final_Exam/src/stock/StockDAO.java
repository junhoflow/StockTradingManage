package stock;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import debate.Debate;

public class StockDAO {

	private Connection conn;
	private ResultSet rs;
	
	public StockDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/final_exam";
			String dbID = "root";
			String dbPassword = "1662";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public int getNext() {
		String SQL = "SELECT stockID FROM STOCKS ORDER BY stockID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public int write(String stockName, String buysell, String stockQuantity, String stockPrice, String buyReason, String userID) {
		String SQL = "INSERT INTO STOCKS VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, stockName);
			pstmt.setString(3, buysell);
			pstmt.setString(4, stockQuantity);
			pstmt.setString(5, stockPrice);
			pstmt.setString(6, buyReason);
			pstmt.setString(7, getDate());
			pstmt.setInt(8, 1);
			pstmt.setString(9, userID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<StockDTO> getList(int pageNumber){
		String SQL = "SELECT * FROM STOCKS WHERE stockID < ? AND stockAvailable = 1 ORDER BY stockID DESC";
		ArrayList<StockDTO> list = new ArrayList<StockDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				StockDTO stock = new StockDTO();
				stock.setStockID(rs.getInt(1));
				stock.setStockName(rs.getString(2));
				stock.setBuysell(rs.getString(3));
				stock.setStockQuantity(rs.getString(4));
				stock.setStockPrice(rs.getString(5));
				stock.setBuyReason(rs.getString(6));
				stock.setTodayDate(rs.getString(7));
				stock.setStockAvailable(rs.getInt(8));
				stock.setUserID(rs.getString(9));
				list.add(stock);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM STOCKS WHERE stockID < ? AND stockAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public StockDTO getStock(int stockID) {
		String SQL = "SELECT * FROM STOCKS WHERE stockID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, stockID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				StockDTO stock = new StockDTO();
				stock.setStockID(rs.getInt(1));
				stock.setStockName(rs.getString(2));
				stock.setBuysell(rs.getString(3));
				stock.setStockQuantity(rs.getString(4));
				stock.setStockPrice(rs.getString(5));
				stock.setBuyReason(rs.getString(6));
				stock.setTodayDate(rs.getString(7));
				stock.setStockAvailable(rs.getInt(8));
				return stock;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int stockID, String stockName, String buysell, String stockQuantity, String stockPrice, String buyReason) {
		String SQL = "UPDATE STOCKS SET stockName = ?, buysell = ?, stockQuantity= ?, stockPrice=?, buyReason=? WHERE stockID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, stockName);
			pstmt.setString(2, buysell);
			pstmt.setString(3, stockQuantity);
			pstmt.setString(4, stockPrice);
			pstmt.setString(5, buyReason);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int stockID) {
		String SQL = "UPDATE STOCKS SET stockAvailable = 0 WHERE stockID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, stockID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
