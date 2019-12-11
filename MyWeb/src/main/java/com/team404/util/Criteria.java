package com.team404.util;

import lombok.Data;

@Data //게터세터 자동생성
public class Criteria { //DB로 전송될 클래스

	private int pageNum; //현재 조회하는 페이지 번호
	private int amount; //한 페이지에서 몇 개의 데이터를 보여줄 것인가
	
	private String searchType; //검색타입
	private String searchName; //검색이름
	
	
	

	public Criteria() {//첫 페이지 진입시 생성될 클래스
		this(1, 10);
	}
	
	public Criteria(int pageNum, int amount) {//페이지 번호를 클릭 시 실행될 생성자
		this.pageNum = pageNum;
		this.amount = amount;
	}







}
