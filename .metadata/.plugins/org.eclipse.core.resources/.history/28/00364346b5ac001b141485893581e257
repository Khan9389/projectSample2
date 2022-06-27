package common.utils.uuid;

import common.utils.crypt.CryptUtil;

public class AES256_Test {
	
	public static void main(String[] args) {
		
		String key = "a6a7cd3d07a942d7a1bb36c2335d1b76"; // 32bit
		
		String target = "abcd 우리나라 대한민국";
		
		String encrypted = CryptUtil.encryptAES256(target, key);
		
		System.out.println(encrypted);
		
		String decrypted = CryptUtil.decryptAES256(encrypted, key);
		
		System.out.println(decrypted);
	}
}
