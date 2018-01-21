package GoogleImageDownload;

import java.util.List;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.net.URL;
import javax.imageio.ImageIO;
import java.io.File;
import java.util.ArrayList;

public class crawling0 {
	public static void main(String[] args) throws Exception{
		String URL1 = "http://blog.naver.com/PostView.nhn?blogId=kkyeong1203&logNo=220655544731&parentCategoryNo=&categoryNo=35&viewDate=&isShowPopularPosts=true&from=search";
		
		Document doc1 = Jsoup.connect(URL1).get();
		
		Elements elems1 = doc1.select("#post-view220655544731 img");
				
		List<String> imageUrls1 = new ArrayList<>();
		
		for(Element img : elems1) {
			imageUrls1.add(img.attr("abs:src"));
		}
		
		int j = 1211;
		
		for(int i = j; i < imageUrls1.size()+j ; i++){
			String element0 = imageUrls1.get(i-j).toString();
			System.out.println(element0);
			BufferedImage image = null;
			URL url = new URL(element0);

			
			try {
				image = ImageIO.read(url);
				String fileNm = String.valueOf(i);
				System.out.println(image);
				File file = new File("C:/Users/hwk07/Downloads/crawling/"+fileNm+".jpg");
				ImageIO.write(image, "jpg", file);
			}catch (IOException e) {
		         e.printStackTrace();
	        }
		}

	}
	

	


}
