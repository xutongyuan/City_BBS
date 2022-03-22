package ssm.util.converter;

import java.security.MessageDigest;

public class Md5Utils {

	public final static String md5(String s) {
		char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				'a', 'b', 'c', 'd', 'e', 'f' };

		try {
			byte[] btInput = s.getBytes();// 加密原字符串
			MessageDigest mdInst = MessageDigest.getInstance("MD5");//md5加密实例
			mdInst.update(btInput);//传入要加密的数据
			byte[] md = mdInst.digest();//获取密文
			int j = md.length;//16个字节
			char str[] = new char[j * 2];//每个字节用两个16进制数表示
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte byte0 = md[i];
				//1111 0100 1001
				//0000 1111      0xf
				str[k++] = hexDigits[byte0 >>> 4 & 0xf];//高4位
				str[k++] = hexDigits[byte0 & 0xf];//地4位
			}
			return new String(str);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
