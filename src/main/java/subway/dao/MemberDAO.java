package subway.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import subway.dto.MemberDTO;

public class MemberDAO {

	private PreparedStatement pstmt;
	private Connection con;
	private DataSource dataFactory;

	public MemberDAO() {
		try {
			Context ctx = new InitialContext();

			Context envContext = (Context) ctx.lookup("java:comp/env");
			dataFactory = (DataSource) envContext.lookup("jdbc/oracle");

		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	//
	public boolean insertMember(MemberDTO memberDTO) {

		try {
			con = dataFactory.getConnection();
			System.out.println("커넥션풀 성공 => member테이블");
			String query = "";

			query += "INSERT INTO MEMBER_TBL ";
			query += "(member_id, member_pw, member_name, member_email, member_nickname) ";
			query += "VALUES(?, ?, ?, ?, ?) ";
			query += "";

			pstmt = con.prepareStatement(query);
			System.out.println("쿼리는 : " + query);
			pstmt.setString(1, memberDTO.getMember_id());
			pstmt.setString(2, memberDTO.getMember_pw());
			pstmt.setString(3, memberDTO.getMember_name());
			pstmt.setString(4, memberDTO.getMember_email());
			pstmt.setString(5, memberDTO.getMember_nickname());

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
//	
//	public boolean loginMember(MemberDTO memberDTO) {
//		// con = dataFactory.
//		MemberDTO dto = new MemberDTO();
//		try {
//			con = dataFactory.getConnection();
//			System.out.println("커넥션풀 성공 => member테이블");
//			String query = "";
//			query += "SELECT * ";
//			query += "FROM MEMBER_TBL ";
//			query += "WHERE MEMBER_ID = ? ";
//			query += "AND MEMBER_PW =?";
//
//			
//			pstmt = con.prepareStatement(query);
//			pstmt.setString(1, memberDTO.getMember_id());
//			pstmt.setString(2, memberDTO.getMember_pw());
//			ResultSet rs = pstmt.executeQuery();
//			
//			String member_id = rs.getString("member_id");
//			String member_pw = rs.getString("member_pw");
//			String member_name = rs.getString("member_name");
//			String member_email = rs.getString("member_email");
//			String member_nickname = rs.getString("member_nickname");
//
//			
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			return false;
//		}
//		return true;
//	}

	public MemberDTO selectMember(MemberDTO memberDTO) {
		// con = dataFactory.
		MemberDTO dto = new MemberDTO();
		try {
			con = dataFactory.getConnection();
			System.out.println("커넥션풀 성공 => member테이블");
			String query = "";
			query += "SELECT * ";
			query += "FROM MEMBER_TBL ";
			query += "WHERE MEMBER_ID = ? ";
			query += "";
			
			System.out.println(query+"쿼리");
			System.out.println(memberDTO.getMember_id()+"이걸로 조회");
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, memberDTO.getMember_id());
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
			String member_id = rs.getString("member_id");
			String member_pw = rs.getString("member_pw");
			String member_name = rs.getString("member_name");
			String member_email = rs.getString("member_email");
			String member_nickname = rs.getString("member_nickname");
			String memo_contents = rs.getString("memo_contents");
			dto.setMember_id(member_id);
			dto.setMember_pw(member_pw);
			dto.setMember_name(member_name);
			dto.setMember_email(member_email);
			dto.setMember_nickname(member_nickname);
			dto.setMemo_contents(memo_contents);
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
		return dto;
	}
	
	
	
	
	public boolean insertMemo(String id, String memo) {

		try {
			con = dataFactory.getConnection();
			System.out.println("커넥션풀 성공 => Memo 인서트");
			String query = "";
			query += "UPDATE MEMBER_TBL ";
			query += "SET MEMO_CONTENTS= ?  ";
			query += "WHERE MEMBER_ID = ?  ";
			System.out.println("쿼리 : " + query);
			System.out.println(id+"에 :"+ memo);
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, memo);
			pstmt.setString(2, id);
			
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

	
	
	
	
	//======
}
