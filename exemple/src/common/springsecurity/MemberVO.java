package common.springsecurity;

import java.util.Collection;
import java.util.Date;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Data;

@Data
public class MemberVO implements UserDetails {
	
	private static final long serialVersionUID = -513243367094871788L;

	/* 회원 아이디 */
	private String mbrId;

	/* 비밀번호 */
	private String mbrPw;

	/* 회원 유형 */
	private String mbrTyp;

	/* 입력된 비밀번호 */
	private String inputMbrPw;

	/* 회원 이름 */
	private String usrName;
	
	
	/* 계정이 가지고 있는 권한목록 */
	private Collection<SimpleGrantedAuthority> authorities;

	/**
	* GETTER & SETTER
	*/

	
	
	/**
	 * UserDetails 구현 메소드
	 */

	

	@Override
	public String getPassword() {
		return null;
	}

	/**
	 * 계정이 만료되지 않았는지를 리턴(true를 리턴하면 만료되지 않음을 의미)
	 */
	@Override
	public boolean isAccountNonExpired() {
		return true; // 체크를 하지 않겠다는 의미
	}

	/**
	 * 계정이 잠겨있지 않은지를 리턴(true를 리턴하면 계정이 잠겨있지 않음을 의미)
	 */
	@Override
	public boolean isAccountNonLocked() {
		return false; // 체크를 하지 않겠다는 의미
	}

	/**
	 * 계정의 패스워드가 만료되지 않았는지를 리턴(true를 리턴하면 패스워드가 만료되지 않음을 의미)
	 */
	@Override
	public boolean isCredentialsNonExpired() {
		return false; // 체크를 하지 않겠다는 의미
	}

	/**
	 * 계정이 사용가능한 계정인지를 리턴(true를 리턴하면 사용가능한 계정을 의미)
	 */
	@Override
	public boolean isEnabled() {
		return false; // 체크를 하지 않겠다는 의미
	}

	@Override
	public String getUsername() {
		return null;
	}

	
}
