package subway.dto;

import java.sql.Date;

public class BookmarkDTO {
	
	int bookmark_cd;
	String member_id;
	int station_cd;
	Date bookmark_date;

	// 추가 (db엔 없음)
	String station_nm;

	public int getBookmark_cd() {
		return bookmark_cd;
	}

	public void setBookmark_cd(int bookmark_cd) {
		this.bookmark_cd = bookmark_cd;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public int getStation_cd() {
		return station_cd;
	}

	public void setStation_cd(int station_cd) {
		this.station_cd = station_cd;
	}

	public Date getBookmark_date() {
		return bookmark_date;
	}

	public void setBookmark_date(Date bookmark_date) {
		this.bookmark_date = bookmark_date;
	}

	public String getStation_nm() {
		return station_nm;
	}

	public void setStation_nm(String station_nm) {
		this.station_nm = station_nm;
	}
	
	
	
}
