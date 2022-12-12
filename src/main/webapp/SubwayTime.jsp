<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URL" %> 
<%@ page import="java.net.URLConnection" %> 
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.OutputStreamWriter" %>
<%@ page import="java.net.HttpURLConnection" %>

<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %> 

<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.parser.ParseException" %>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %> 
<%@ include file="util.jsp" %>

<% 

//http://localhost:8080/project/SubwayTime.jsp?station=%EC%88%98%EC%9B%90&type=time


// 현재 시간   
Calendar now = Calendar.getInstance(); 
int year = now.get(Calendar.YEAR);
int month = now.get(Calendar.MONTH) + 1; 
int day = now.get(Calendar.DAY_OF_MONTH); 
int hour = now.get(Calendar.HOUR_OF_DAY);
int min = now.get(Calendar.MINUTE);
int sec = now.get(Calendar.SECOND);
String str_time = String.format("%02d:%02d:%02d", 
  							now.get(Calendar.HOUR_OF_DAY),
                         	now.get(Calendar.MINUTE),
                        	now.get(Calendar.SECOND)
                            );  
System.out.println("Time : " + str_time); 


String cur_date = String.format("%04d-%02d-%02d", year,month,day); 
String cur_time = String.format("%02d:%02d:%02d", hour, min, sec);

String station_name = request.getParameter("station");
String target_type = request.getParameter("type");


InitialContext initialContext = new InitialContext();
DataSource dataSource = (DataSource) initialContext.lookup("java:comp/env/jdbc/mysqlDB");

Connection connect = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
try{
	connect = dataSource.getConnection();
	if (connect == null) { 		// db에러 생기면 0으로 초기화
		if (target_type.equals("time"))
		    out.println(arrivetimeToJSON("")); 
	    else if (target_type.equals("delay")){				
	    	JSONObject nullObject = new JSONObject();
	    	min = 0;
			sec = 0;  
			nullObject.put("UP",String.format("%02d:%02d",min,sec));
			nullObject.put("UP_STATE",CalculateTime("", 0)); 
			nullObject.put("DOWN",String.format("%02d:%02d",min,sec));
			nullObject.put("DOWN_STATE",CalculateTime("", 0)); 
			out.println(nullObject);
		}
		if (true) return;
	} 
}  catch(Exception ex) {
	System.out.println("Exception Error :" + ex.getMessage());
}   

int time_max = 1;
int count = 0;
String up_time =""; // db에 있는 상행 시간값
String down_time ="";  // db에 있는 하행 시간값
String time_data = "";

if (target_type.equals("time"))   // time일 경우 
	time_max = 5;



StringBuffer time_up = new StringBuffer("");   // api로 불러와서 저장하는 상행 시간
StringBuffer time_down = new StringBuffer("");  // api로 불러와서 저장하는 하행 시간

try {
    String query  = "SELECT ARRIVETIME FROM fixedtime_tbl where station_nm='" + station_name + "'";
    query += " and LINE_NUM='" + "1호선" + "'";
    query += " and ARRIVETIME>='" + str_time + "'";
	query += " and INOUT_TAG = 1";   // 상행 시간표 가져오기
    query += " limit 0, " + Integer.toString(time_max);  // limit으로 출력 레코드 수 조절
    System.out.println(query);  // db에서 현재 시간 보다 이후에 있는 시간표 가져오기  -> 5개
    pstmt = connect.prepareStatement(query); 
    rs = pstmt.executeQuery();
    
    while(rs.next()){	 
		if (time_up.length()>0) 
		    time_up.append(",");
		time_up.append(rs.getString("ARRIVETIME"));	  
		if (++count==1) {
            up_time = cur_date + " " + rs.getString("ARRIVETIME");   // 나중 시간 계산을 위해 현재 날짜 정보를 포함시켜준다.
		}  
    } 

	count = 0;
	query  = "SELECT ARRIVETIME FROM fixedtime_tbl where station_nm='" + station_name + "'";
    query += " and LINE_NUM='" + "1호선" + "'";
    query += " and ARRIVETIME>='" + str_time + "'";
	query += " and INOUT_TAG = 2";   	// 하행 시간표 가져오기 
    query += " limit 0, " + Integer.toString(time_max);
    System.out.println(query);
    pstmt = connect.prepareStatement(query); 
    rs = pstmt.executeQuery(); 	    
    while(rs.next()){	 
		if (time_down.length()>0) 
		    time_down.append(",");
		time_down.append(rs.getString("ARRIVETIME"));	
		if (++count==1) {
            down_time = cur_date + " " + rs.getString("ARRIVETIME"); // 나중 시간 계산을 위해 현재 날짜 정보를 포함시켜준다.
		}     
    } 
    time_data = time_up + "/" + time_down;
    if (rs != null) try{rs.close(); }  catch (SQLException es) {}
    if (pstmt != null) try{pstmt.close(); }  catch (SQLException es) {} 
   
} catch(SQLException ex) { 
	System.out.println("Exception Error :" + ex.getMessage()); 
}    
System.out.println("Up Time : " + up_time +", Down Time : " + down_time);

if (target_type.equals("time")) {   
    out.println(arrivetimeToJSON(time_data.toString())); 
}
 
else if (target_type.equals("delay")) {
	int start_group = 1;
	int end_group = 5;
	JSONParser parser = new JSONParser();
	String cont = null; 
	try{
		
		cont = callingApi(station_name, start_group, end_group);
		JSONObject jsonObject = (JSONObject)parser.parse(cont);
		JSONObject error_msg = (JSONObject)jsonObject.get("errorMessage");
		long total = (long)error_msg.get("total");
		System.out.println("[total:" + Long.toString(total) + "]");
		
		String cur_up_time = ""; 	// api에서 넘어오는 실시간 상행 열차 도착 시간??
		String cur_down_time = ""; 
		String statnTid;			// 다음 지하철 역명
		String subwayID;			// 현재 지하철 역명
		String updnLine;			// 상하행선 구분
		String recptnDt; 			// 열차도착정보 시간
		String arvlCd;				// 도착 코드 -> 코드로 현재 열차 상태 알 수 있음
		String arvlMsg3_up = "";	// 상행 열차의 도착 메시지
		String arvlMsg3_down = "";	// 하행 열차의 도착 메시지
		
		JSONArray resultJsonArray = (JSONArray) jsonObject.get("realtimeArrivalList");
		//String arrival_time;
		JSONObject tempJson = new JSONObject();
		for (int i = 0; i < resultJsonArray.size(); i++) {  
		    tempJson = (JSONObject) resultJsonArray.get(i);
		    subwayID = tempJson.get("subwayId").toString();
		    updnLine = tempJson.get("updnLine").toString();
		    
		    if (subwayID.equals("1001") && updnLine.equals("상행") && cur_up_time.length() == 0){
		    	statnTid = tempJson.get("statnTid").toString(); 
		    	recptnDt = tempJson.get("recptnDt").toString();  
				arvlCd = tempJson.get("arvlCd").toString();  
				arvlMsg3_up = tempJson.get("arvlMsg3").toString();
				//arvlMsg3_up = laststn(arvlMsg3_up, "up");
	            cur_up_time = recptnDt; 
	            System.out.println("상행 time: " + cur_up_time);
		    }
		    if (subwayID.equals("1001") && updnLine.equals("하행") && cur_down_time.length() == 0){
		    	statnTid = tempJson.get("statnTid").toString(); 
				recptnDt = tempJson.get("recptnDt").toString();  
				arvlCd = tempJson.get("arvlCd").toString();  
				arvlMsg3_down = tempJson.get("arvlMsg3").toString(); 
				//arvlMsg3_down = laststn(arvlMsg3_down, "down");
	            cur_down_time = recptnDt;
	            System.out.println("하행 time: " + cur_down_time);
	            break;
		    }
		}
	    if (cur_down_time.length() == 0){
			start_group += 5;			// 한번의 호출로 하행 열차를 찾을 수 없는 경우 api 호출
			end_group = start_group + 5;
			
			cont = callingApi(station_name, start_group, end_group);
			jsonObject = (JSONObject)parser.parse(cont);
			System.out.println("cont: " + cont);
			resultJsonArray = (JSONArray) jsonObject.get("realtimeArrivalList");
			tempJson = new JSONObject();
			
			for (int j = 0; j < resultJsonArray.size(); j++) {  
	            tempJson = (JSONObject) resultJsonArray.get(j);	
	            subwayID = (String)tempJson.get("subwayId").toString(); 
			    updnLine = (String)tempJson.get("updnLine").toString(); 
	 
		    	if (subwayID.equals("1001") && updnLine.equals("하행") && cur_down_time.length()==0) {
			    	statnTid = (String)tempJson.get("statnTid").toString(); 
			    	recptnDt = (String)tempJson.get("recptnDt").toString();  
			    	arvlCd = (String)tempJson.get("arvlCd").toString();  
					arvlMsg3_down = (String)tempJson.get("arvlMsg3").toString();
					//arvlMsg3_down = laststn(arvlMsg3_down, "down");
	                cur_down_time = recptnDt; 
	                //System.out.println("하행 time: " + cur_down_time);
				    break;
			    }
	        }	
		}
	    
	
	System.out.println("<p>Time</p>");	
	System.out.println(String.format("[현재 위치]  상행 : %s, %s, 하행 : %s, %s<br>", arvlMsg3_up, cur_up_time, arvlMsg3_down, cur_down_time));
	System.out.println(String.format("[원래 시간]  상행 : %s, 하행 : %s<br>", up_time, down_time));
		
	int station_cd=0;
	int station_up_cd=0;
	int station_down_cd=0;
	int delay_time=0;
	String query = "";
	try{
		query = "SELECT STATION_CD, STATION_NM FROM CODE_TBL WHERE STATION_NM='" + station_name + "'";
		query += " or STATION_NM='" + arvlMsg3_up + "'";			// api에서 현재 도착역으로 db에서 역이름, 역코드 찾음 
		query += " or STATION_NM='" + arvlMsg3_down + "'";
		pstmt = connect.prepareStatement(query);
		rs = pstmt.executeQuery();
		while(rs.next()){	 // 역 코드 찾아내기
			if (station_name.equals(rs.getString("STATION_NM"))) {
				station_cd = rs.getInt("STATION_CD");
			}
			if (arvlMsg3_up.equals(rs.getString("STATION_NM"))) {
				station_up_cd = rs.getInt("STATION_CD");
			}
			if (arvlMsg3_down.equals(rs.getString("STATION_NM"))) {
				station_down_cd = rs.getInt("STATION_CD");
			}
	    }  
	} catch(Exception ex){
		System.out.println("Exception Error :" + ex.getMessage());
	}
	
	System.out.println(String.format("stn_cd:%d, up_cd:%d, down_cd:%d", station_cd, station_up_cd, station_down_cd));
	if(station_cd != 0 && station_up_cd != 0 && station_down_cd != 0){
		JSONObject timeObject = new JSONObject();
		if(station_cd != station_up_cd){
			query = "SELECT going_up FROM CODE_TBL WHERE ";
			query += String.format("STATION_CD > %d AND STATION_CD <= %d", station_cd, station_up_cd);
			System.out.println(query);
			pstmt = connect.prepareStatement(query); 
			rs = pstmt.executeQuery();  
			
			while(rs.next()){
				String stime = rs.getString("going_up");
				System.out.println("interval : " + stime);
				min = Integer.parseInt(stime.substring(3, 5));
				sec = Integer.parseInt(stime.substring(6));
				delay_time += min * 60 + sec;
			}
			min = delay_time/60;
			sec = delay_time%60; 
		}else{
			min = 0;
			sec = 0;
			delay_time = 0;
		}
		System.out.println("interval : " + delay_time);
		timeObject.put("UP", String.format("%02d:%02d", min, sec));
		timeObject.put("UP_STATE", CalculateTime(up_time, delay_time));
		
		if(station_cd != station_down_cd){
			query = "SELECT going_up FROM CODE_TBL WHERE ";
			query += String.format("STATION_CD > %d and STATION_CD <= %d", station_down_cd, station_cd);
			System.out.println(query);
			pstmt = connect.prepareStatement(query); 
			rs = pstmt.executeQuery();    
			delay_time=0; 
			while(rs.next()){	  
				String stime = rs.getString("going_up");
				System.out.println("interval : " + stime);
				min   = Integer.parseInt(stime.substring(3,5));
			    sec   = Integer.parseInt(stime.substring(6));
				delay_time += min*60 + sec;    
			}  
			min = delay_time/60;
			sec = delay_time%60; 
		}else{
			min = 0;
			sec = 0;
			delay_time = 0;
		}
		System.out.println("interval : " + delay_time); 
		timeObject.put("DOWN",String.format("%02d:%02d", min, sec));		
		timeObject.put("DOWN_STATE",CalculateTime(down_time, delay_time));  		 
		out.println(timeObject);
	}
	
	
	}catch(Exception e) {
	    e.printStackTrace();
	    out.println("api 제공 안함");
	}	
}
System.out.println();
if (connect != null) try{connect.close(); }  catch (SQLException es) {} 
%> 
