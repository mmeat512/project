package com.team404.util.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class LogAdvice {

	//로그를 찍을 수 있게 하는 기능 
	/*
	<logger name="com.team404.util.aop">
		<level value="info" />
	</logger>
	 */
	private static final Logger log = LoggerFactory.getLogger(LogAdvice.class);
	
	//이 프로젝트의 모든 서비스에 대해서 target, args,signature의 실행정보를 출력하는 aop
	@Around("execution(* com.team404.*.service.*ServiceImpl.*(..))")
	public Object arount(ProceedingJoinPoint jp) {
		
		Object result = null;
		
		log.info("적용 클래스 : "+jp.getTarget());
		log.info("서비스 파라미터 : "+Arrays.toString(jp.getArgs()));
		log.info("적용 메서드 : "+jp.getSignature());
		
		long start = System.currentTimeMillis();
		try {
			result = jp.proceed();
		} catch (Throwable e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		long end = System.currentTimeMillis();
		
		log.info("메서드 수행시간 : "+((end-start)*0.001)+"초");
		return result;
	}
	
	
	
}
