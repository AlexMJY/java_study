package javaz.api;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

//System 클래스
//- 운영체제와 관련된 필드와 메서드 제공
//- 객체 생성 불필요 
//  - 모든 멤버가 static으로 선언되어 있음
//- 표준 입력/출력/에러, 프로그램 종료, 메모리 정리
//- 현재 시간 및 시스템 프로퍼티, 환경 변수 사용 등 가능

public class SystemMain {
	public static void main(String[] args)  {
		//1. 1부터 int형의 최대값까지 합산 소요 시간 계산 ----------
		long start = System.currentTimeMillis();
		
		System.out.println("currentTimeMillis : " + start);
		
		SimpleDateFormat dateFmt 
					= new SimpleDateFormat("yyyy.MM.dd a hh시 mm분 ss초");
		Date date = new Date(start);
		System.out.println("시작 : " + dateFmt.format(date));
		
		long sum = 0L;
		for(long i = 1L ; i <= Integer.MAX_VALUE ; i++) {
			sum += i; //1부터 int형의 최대값까지 누적 합산
		}
		
		long end = System.currentTimeMillis();
		date = new Date(end);
		System.out.println("종료 : " + dateFmt.format(date));
		System.out.println("소요 시간 : " + (end - start)/1000.0 + "초");						
		System.out.printf("1부터 %,d까지의 합 : %,d", Integer.MAX_VALUE, sum);
		System.out.println();
		System.out.println();
		
		//2.시스템 프로퍼티 읽어오기 -------------------------
		System.out.println("운영체제 : " + 
						   System.getProperty("os.name"));
		System.out.println("사용자명 : " +
						   System.getProperty("user.name"));
		System.out.println("사용자 홈디렉토리 : " +
						   System.getProperty("user.home"));
		System.out.println("파일 구분자 : " +
				   		   System.getProperty("file.separator"));
		System.out.println("경로 구분자 : " +
		   		   		   System.getProperty("path.separator"));
		System.out.println();
		
		Properties props = System.getProperties();
		props.list(System.out);
		System.out.println();
		
		//3.환경 변수 값 읽어오기 --------------------
		System.out.println("[JAVA_HOME] " + System.getenv("JAVA_HOME"));
		System.out.println("[Path] " + System.getenv("Path"));
		System.out.println();
		
		System.out.println("--- Path list ---");
		String[] paths = System.getenv("Path")
			                   .split(System.getProperty("path.separator"));
		for (String path : paths) {
			System.out.println(path);
		}
		System.out.println();
		
		//4.프로그램 종료 ---------------------------
		for(int i=3 ; i >= 0 ; i--) {
			System.out.println(i);
			
			if( i == 0 ) {
				System.err.println("시스템을 종료합니다.");
//				break; //1.반복을 중단
//				return; //2.프로그램을 호출한 쪽으로 반환
//				System.exit(0);	//3.시스템 종료
			}
		}
		System.out.println();
		
		
	}
}




















