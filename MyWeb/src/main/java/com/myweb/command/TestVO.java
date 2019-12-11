package com.myweb.command;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data //getter, setter
@AllArgsConstructor //모든 변수 초기화 생성자
@NoArgsConstructor //기본생성자
public class TestVO {

	private int age;
	private String name;
	private String id;
}
