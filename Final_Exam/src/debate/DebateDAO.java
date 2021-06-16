package debate;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class DebateDAO {

	private Connection conn;
	private ResultSet rs;

	public DebateDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/final_exam?characterEncoding=euckr&useUnicode=true&mysqlEncoding=euckr";
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
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	public int getNext() {
		String SQL = "SELECT debateID FROM DEBATE ORDER BY debateID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int write(String debateTitle, String userID, String debateContent) {
		String SQL = "INSERT INTO DEBATE VALUES (?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext());
			pstmt.setString(2,  debateTitle);
			pstmt.setString(3,  userID);
			pstmt.setString(4,  getDate());
			pstmt.setString(5,  debateContent);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Debate> getList(int pageNumber){
		String SQL = "SELECT * FROM DEBATE WHERE debateID < ? ORDER BY debateID DESC LIMIT 10";
		ArrayList<Debate> list = new ArrayList<Debate>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Debate debate = new Debate();
				debate.setDebateID(rs.getInt(1));
				debate.setDebateTitle(rs.getString(2));
				debate.setUserID(rs.getString(3));
				debate.setDebateDate(rs.getString(4));
				debate.setDebateContent(rs.getString(5));
				list.add(debate);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM DEBATE WHERE debateID < ?";
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
	
	public Debate getDebate(int debateID) {
		String SQL = "SELECT * FROM DEBATE WHERE debateID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, debateID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Debate debate = new Debate();
				debate.setDebateID(rs.getInt(1));
				debate.setDebateTitle(rs.getString(2));
				debate.setUserID(rs.getString(3));
				debate.setDebateDate(rs.getString(4));
				debate.setDebateContent(rs.getString(5));
				return debate;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int debateID, String debateTitle, String debateContent) {
		String SQL = "UPDATE DEBATE SET debateTitle = ?, debateContent = ? WHERE debateID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, debateTitle);
			pstmt.setString(2, debateContent);
			pstmt.setInt(3, debateID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int debateID) {
		String SQL = "DELETE FROM DEBATE WHERE debateID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, debateID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
