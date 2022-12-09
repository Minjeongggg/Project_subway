package subway.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import subway.dto.BookmarkDTO;

public class BookmarkDAO {

	private PreparedStatement pstmt;
	private Connection con;
	private DataSource dataFactory;

	
	public BookmarkDAO()  {
		try {
			
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:comp/env");
			dataFactory = (DataSource) envContext.lookup("jdbc/oracle");
			
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public List<BookmarkDTO> selectBookmarkList(String member_id){
	
		List<BookmarkDTO> bookmarkList = new ArrayList();
		
		try {
			con = dataFactory.getConnection();
			System.out.println("커넥션풀 성공 = > 북마크 리스트 접근");
			
			String query = "";
			query += "SELECT C.STATION_NM, ";
			query += "C.STATION_CD AS STATION_CD,  ";
			query += "B.MEMBER_ID,  ";
			query += "B.BOOKMARK_CD, ";
			query += "B.BOOKMARK_DATE ";
			query += "FROM CODE_TBL C ";
			query += "LEFT OUTER JOIN  ";
			query += "BOOKMARK_TBL B ";
			query += "ON C.STATION_CD = B.STATION_CD ";
			query += "WHERE B.MEMBER_ID = ? ";
			
			query += "UNION ALL ";
			
			query += "SELECT C1.STATION_NM,  ";
			query += "C1.STATION_CD,  ";
			query += " '', NULL, NULL ";
			query += "FROM CODE_TBL C1 ";
			query += "WHERE C1.STATION_CD NOT IN ( ";
			query += "SELECT CC.STATION_CD AS STATION_CD ";
			query += "FROM CODE_TBL CC ";
			query += "LEFT OUTER JOIN ";
			query += "BOOKMARK_TBL BB ";
			query += "ON CC.STATION_CD = BB.STATION_CD ";
			query += "WHERE BB.MEMBER_ID = ? ";
			query += ") ";
			query += " ";
			
			//System.out.println(query);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,member_id);
			pstmt.setString(2,member_id);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BookmarkDTO dto = new BookmarkDTO();
				
				dto.setBookmark_cd(rs.getString("bookmark_cd"));
				dto.setMember_id(rs.getString("member_id"));
				dto.setStation_cd(rs.getInt("station_cd"));
				dto.setBookmark_date(rs.getDate("bookmark_date"));
				dto.setStation_nm(rs.getString("station_nm"));
				
				bookmarkList.add(dto);
				//System.out.println(dto.getStation_nm());
			}
			

			if (rs != null) {
				rs.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (con != null) {
				con.close();
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return  bookmarkList;
	}
	
	
	
	
	
	public boolean checkBookmark(String member_id, int station_cd) {
		try {
			con = dataFactory.getConnection();
			System.out.println("커넥션풀 성공 => 북마크 체크");
			
			String query = "SELECT * ";
			query += "FROM CODE_TBL C ";
			query += "JOIN ";
			query += "BOOKMARK_TBL B ";
			query += "ON C.STATION_CD = B.STATION_CD ";
			query += "WHERE B.MEMBER_ID = ? ";
			query += "AND B.STATION_CD = ? ";
			
			System.out.println("쿼리" +query);
			pstmt= con.prepareStatement(query);
			pstmt.setString(1, member_id);
			pstmt.setInt(2, station_cd);
			
			ResultSet rs = pstmt.executeQuery();
			

			while(rs.next()) {
				 String rs_stationCD;
				 rs_stationCD =rs.getString("station_cd");
				 System.out.println("db 받은 값 :"+rs_stationCD);
				 
				 if( rs_stationCD  != null) {
					 System.out.println("return false ===========");
						return true;
					}
			}
			
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(con != null) con.close();
			
			//return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	
	
	public boolean insertBookmark(String member_id, int station_cd) {
		
		try {
			con = dataFactory.getConnection();
			System.out.println("커넥션풀 성공 => bookmark 테이블");
			
			String query = "";
			query +="INSERT INTO BOOKMARK_TBL ";
			query +="(BOOKMARK_CD, MEMBER_ID, STATION_CD, BOOKMARK_DATE) ";
			query +="VALUES ";
			query +="( ";
			query +="?, ";
			query +="?, ";
			query +="?, ";
			query +="NOW() ";
			query +=") ";
			
			System.out.println("인서트 쿼리 : "+query);
			
			pstmt= con.prepareStatement(query);
			pstmt.setString(1, ""+member_id+station_cd);
			pstmt.setString(2, member_id);
			pstmt.setInt(3, station_cd);
			
			ResultSet rs = pstmt.executeQuery();
			
			if (rs != null) {
				rs.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (con != null) {
				con.close();
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	
	public boolean deleteBookmark (String member_id, int station_cd) {
		
		try {
			con =dataFactory.getConnection();
			System.out.println("커넥션풀 성공 => 기존 북마크 삭제 진입");
			
			String query = "DELETE FROM BOOKMARK_TBL ";
			query += "WHERE MEMBER_ID = ? ";
			query += "AND STATION_CD = ? ";
			query += "";
	
			System.out.println("쿼리는 : "+query);
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, member_id);
			pstmt.setInt(2, station_cd);
			
			ResultSet rs = pstmt.executeQuery();
	
			
			if (rs != null) {
				rs.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (con != null) {
				con.close();
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
				
		return true;
	}
	




}
