<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URL" %> 
<%@ page import="java.net.URLConnection" %> 
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.OutputStreamWriter" %>
<%@ page import="java.net.HttpURLConnection" %>

<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.parser.ParseException" %>
<%@ page import= "java.util.Arrays" %>


<%! 
	/*
    public static Connection getConnection() {
    	
        Connection conn = null;
		String jdbcDriver = "jdbc:mysql://localhost:3306/subway"; 
        String id = "root";
        String pw = "6574";
        try { 
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(jdbcDriver,id,pw); 
            return conn;
        } catch (Exception e) {
            System.out.println("DBUtil.getConnection() : " + e.toString());
        }
        return null;
    } */

	public static JSONObject arrivetimeToJSON(String data)
	{
		JSONObject sendObject = new JSONObject();
		JSONArray Array1 = new JSONArray(); 
		JSONArray Array2 = new JSONArray(); 
		
	    //JSONArray sendArray = new JSONArray(); 
	   // System.out.println("data : " + data);    
		try{
			String[] sp_result = data.split("/");   // '/'로 구분되는 상행/하행 시간표 나눔
			String[] sp_result2 = sp_result[0].split(",");    // 상행 시간표들 가져오기
			
	        //JSONObject Object1 = new JSONObject();
			
			//System.out.println("array Length : " + Integer.toString(sp_result2.length));
		    for (int i=0;i<sp_result2.length;i++) {
			    Array1.add(sp_result2[i]);				// 상행 시간표 하나씩 가져와 array에 저장
		    }
	        //Object1.put("UP_TIME",Array1);
			//sendArray.add(Object1);
			sendObject.put("UP_TIME", Array1);
			
			sp_result2 = sp_result[1].split(",");
	        //JSONObject Object2 = new JSONObject();
			
		    for (int i=0;i<sp_result2.length;i++) {
			    Array2.add(sp_result2[i]);
		    }
	        //Object2.put("DOWN_TIME",Array2);
			//sendArray.add(Object2);
		    sendObject.put("DOWN_TIME", Array2);
	
	    } catch (Exception e) {
	        System.out.println("JSONObject / Array Error" + e.toString());
			
	    }
	
		//sendObject.put(msg_name,sendArray); 
		return sendObject;
	}
	
	public static String CalculateTime(String time1, int delay_time)//String time2)
	{
		String result_time = ""; 

	    try{
			Calendar cal = Calendar.getInstance(); 
			int year  = Integer.parseInt(time1.substring(0,4)); // cal.get(Calendar.YEAR);
			int month = Integer.parseInt(time1.substring(5,7)); 
			int day   = Integer.parseInt(time1.substring(8,10));
            int hour  = Integer.parseInt(time1.substring(11,13));
			int min   = Integer.parseInt(time1.substring(14,16));
			int sec   = Integer.parseInt(time1.substring(17));

			//cal.set(year,month,day,hour,min,sec);  
			//java.util.Date ctime1 = cal.getTime();

			/* year  = Integer.parseInt(time2.substring(0,4));
			month = Integer.parseInt(time2.substring(5,7));
			day   = Integer.parseInt(time2.substring(8,10));
            hour  = Integer.parseInt(time2.substring(11,13));
			min   = Integer.parseInt(time2.substring(14,16));
			sec   = Integer.parseInt(time2.substring(17));
			cal.set(year,month,day,hour,min,sec); */

			cal.set(year,month,day,hour,min,sec);  
			java.util.Date ctime1 = cal.getTime();

			Calendar now = Calendar.getInstance();   
			java.util.Date ctime2 = now.getTime();
			long calDate = ctime2.getTime() + (long)(delay_time*1000) - ctime1.getTime();

            long calTime = calDate / 1000; 
			long absTime = Math.abs(calTime);
			if (absTime>3600) absTime = 0;
			min = (int)(absTime/60);
			sec = (int)(absTime %60); 
            if (calTime<0 && absTime != 0) 
			    result_time = "-";
			result_time += String.format("%02d:%02d",min,sec); 
	    }catch(Exception e){ ; }
         
		System.out.println("result : " + result_time);
		return result_time;
	}

	
	public static String callingApi(String target_station, int start, int end) {
		URL url = null;
		URLConnection con = null;
		InputStreamReader isr = null;
		BufferedReader br = null;
		StringBuffer sb = null;
		String cont = null;
		try{

			StringBuffer urlBuilder = new StringBuffer("http://swopenapi.seoul.go.kr/api/subway"); 
		    urlBuilder.append("/425067427774686531313674546d6967");
		    urlBuilder.append("/json"); 
		    urlBuilder.append("/realtimeStationArrival"); 
		    urlBuilder.append("/" + Integer.toString(start));  
		    urlBuilder.append("/" + Integer.toString(end)); 
		    urlBuilder.append("/" + java.net.URLEncoder.encode(target_station,"utf-8"));    
		   
		   String str_url = urlBuilder.toString().trim();
		   //out.println(str_url);
		   //out.println("<br>");
			 
			url = new URL(str_url);
			con = url.openConnection(); 
			con.connect();
		       
		    isr = new InputStreamReader(con.getInputStream(),"UTF-8"); 

		    br = new BufferedReader(isr); 
		    sb = new StringBuffer(); 
		    String line  = null; 
		    while((line = br.readLine()) != null){ 
		      sb.append(line+"\n"); 
		    }
			cont = sb.toString().trim(); 
		} catch(Exception e) {
		    e.printStackTrace();
		}
		return cont;
	}
	
/* 	public static String laststn (String arvlMsg3, String updn){
		List<String> list = 
		String[] stns = {"수원", "세류", "병점", "세마", "오산대", "오산", "진위", "송탄", "서정리", "평택지제", "평택", "성환", "직산", "두정", "천안"};
		System.out.println(" arvlMsg3 : " + arvlMsg3 + "up down : " + updn);
		boolean a = false;
		for(String i : stns){
			//System.out.print(i);
			if(stns.includes(arvlMsg3)){
				//anyMatch(s -> s.equals(stringToSearch))
				System.out.println(i + " 	리스트에 있어요");
				//a = true;
			}else{
				System.out.println(i + "리스트에 없어요 ");
				//a = true;
			}
		}
		
		if(a){
			if(updn.equals("up")){
				System.out.println("I'n in");
				return "수원";
			}
				
			else if(updn.equals("down")){
				System.out.println("I'n down");
				return "천안";
			}
				
		}
		return arvlMsg3;
	} */
	

%>