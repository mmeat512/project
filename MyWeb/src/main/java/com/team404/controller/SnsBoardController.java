package com.team404.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.myweb.command.SnsBoardVO;
import com.team404.snsboard.service.SnsBoardService;


@Controller
@RequestMapping("/snsBoard")
public class SnsBoardController {

	@Autowired
	@Qualifier("snsBoardService")
	private SnsBoardService snsBoardService;
	
	//화면처리
	@RequestMapping("/snsList")
	public String snsList() {
		
		return "snsBoard/snsList";
	}

	@RequestMapping("/upload")
	@ResponseBody //form으로 받았기 때문에 @RequestParam으로 받을 수 있다. 
	public String upload(@RequestParam("file") MultipartFile file,
						 @RequestParam("content") String content,
						 HttpSession session) {
		//1. 날짜별로 20191211형식으로 upload아래에 폴더를 생성
		//2. uploadPath는 날짜폴더를 포함한 경로 
		//3. fileRealName은 변경하기 전 파일 이름
		//4. fileName은 변경해서 저장할 이름 
		//5. fileLoca 20191211형식으로 만들어진 폴더이름
		//6. transferTo()메서드를 이용해서 전송되온 파일을 해당 날짜에 업로드
		//7. DB에서 insert메서드를 통해서 값들을 저장
		//8. 성공시에 화면에 success를 반환, 실패시 fail를 반환
		
		//날짜별로 폴더생성
		Date date = new Date();
		SimpleDateFormat sd = new SimpleDateFormat("yyyyMMdd");
		String day = sd.format(date);
		
		//날짜폴더를 포함한 경로
		String uploadPath = "D:\\juyeon_spring\\upload\\"+day;

		File folder = new File(uploadPath);
		if(!folder.exists()) {
			folder.mkdir();
		}
		
		//변경하기전 파일 이름
		String fileRealName = file.getOriginalFilename();
		System.out.println(fileRealName);
		
		//확장자
		String fileExtension = fileRealName.substring(fileRealName.lastIndexOf(".")-1, fileRealName.length());
		
		//변경해서 저장할 파일 이름 
		//파일명변경 ex)43ff3986609249ce828b1891055f07cf.jpg;
		UUID uuid = UUID.randomUUID();
		String uuids = uuid.toString().replace("-", "");
		//확장자는 파일 이름 뒤에 붙이고 파일 경로에 따로 쓰지 않음.
		String fileName = uuids.substring(0,8)+fileExtension;
		
		//폴더 이름
		String fileLoca = day;
		
		//파일업로드
		try {
			//저장될 파일
			File saveFile = new File("D:\\juyeon_spring\\upload\\"+day+"\\"+fileName); //파일확장자는 파일이름에 붙여서 한번에 사용
			file.transferTo(saveFile);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//작성자
		String writer = (String)session.getAttribute("user_Id");
		
		//DB에 보낼 vo생성
		SnsBoardVO vo = new SnsBoardVO(0, writer, uploadPath, fileLoca, fileName, fileRealName, content, null);
		
		int result = snsBoardService.insert(vo);

		return result == 1 ? "success" : "fail";
	}

	@RequestMapping("/view")
	@ResponseBody
	public byte[] view(@RequestParam("fileLoca") String fileLoca,
					   @RequestParam("fileName") String fileName) {
		
		File file = new File("D:\\juyeon_spring\\upload\\"+fileLoca+"\\"+fileName);
		byte[] result = null;
		try {
			//스프링의 파일데이터를 읽어서 바이트배열형으로 리턴하는 메서드(매개값으로 file타입을 받음)
			result = FileCopyUtils.copyToByteArray(file);
			System.out.println(result);
		} catch (Exception e) {
		}
		return result;
	}
	
	@RequestMapping("/getList")
	@ResponseBody
	public ArrayList<SnsBoardVO> getList(){
		
		System.out.println(snsBoardService.getList().toString());
		
		return snsBoardService.getList();
	}
	

}
