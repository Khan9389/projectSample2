package common.config.root_context;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

import common.springsecurity.CustomAuthenticationProvider;

@Configuration
@EnableWebSecurity
public class SpringSecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
    CustomAuthenticationProvider authenticationProvider;
	
    @Override
	public void configure(WebSecurity web) throws Exception {
		// 스프링시큐리티의 간섭을 받지않는 경로들
		web.ignoring().antMatchers(
								"/static_resources/**",
								"/upload/**"
								);
	} 

	@Override
    protected void configure(HttpSecurity http) throws Exception {
		System.out.println("configure #### ");
        http.csrf().disable()
            .formLogin() // 로그인 페이지 및 성공 url, handler 그리고 로그인시 사용되는 id, password 파라미터 정의
	            .loginPage("/") 
	            .loginProcessingUrl("/loginProc") // 로그인처리시 호출할 URL
	            .defaultSuccessUrl("/afterLoginProc", true) // 로그인 성공후 이동할 URL
	            .failureUrl("/loginFail")  // 로그인 실패후 이동할 URL
	            .usernameParameter("mbrId") // 로그인페이지에서 로그인 ID 파라메타 명
	            .passwordParameter("mbrPw") // 로그인페이지에서 로그인 password 파라메타 명
	            .and()
            .authorizeRequests()
            	/* 접근권한 설정 */
//            	.antMatchers("/groupware/expenseAdmin/**").hasAuthority("ADMIN")
//            	.antMatchers("/groupware/notice/**").hasAnyAuthority("ADMIN", "SYSAD")
//            	.antMatchers("/groupware/performance/**").hasAnyAuthority("ADMIN", "SYSAD")
//            	.antMatchers("/groupware/cmmnCd/**").hasAnyAuthority("ADMIN", "SYSAD")
            	/* 접근권한 설정 */
            	.antMatchers("/**").permitAll()
            	.and()
            .authenticationProvider(authenticationProvider)
            .headers()
            	.frameOptions()
            	.sameOrigin()
            	;
        
        /* 접근거부될 시 이동할 에러페이지 */
        http.exceptionHandling().accessDeniedPage("/WEB-INF/jsp/error/error403.jsp");
    }
}
