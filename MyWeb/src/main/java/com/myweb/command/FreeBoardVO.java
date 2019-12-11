package com.myweb.command;

import java.sql.Timestamp;

import lombok.Data;

//롬복라이브러리추가시 @Data 어노테이션 getter, setter, toString 자동생성
//@AllArgsConstructor 어노테이션은 모든 변수를 초기화하는 생성자
//@NoAragConstructor 어노테이션은 기본생성자
@Data
public class FreeBoardVO {
	
	//테이블 칼럼명과 동일하게 멤버변수를 선언 
	private int bno;
	private String title;
	private String content;
	private String writer;
	private Timestamp regdate;
	private Timestamp updatedate;	
}
