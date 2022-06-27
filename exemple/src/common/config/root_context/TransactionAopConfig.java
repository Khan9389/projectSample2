package common.config.root_context;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.sql.DataSource;

import org.aspectj.lang.annotation.Aspect;
import org.springframework.aop.Advisor;
import org.springframework.aop.aspectj.AspectJExpressionPointcut;
import org.springframework.aop.support.DefaultPointcutAdvisor;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.interceptor.RollbackRuleAttribute;
import org.springframework.transaction.interceptor.RuleBasedTransactionAttribute;
import org.springframework.transaction.interceptor.TransactionInterceptor;

@Aspect
@EnableAspectJAutoProxy(proxyTargetClass = true)
@Configuration
@EnableTransactionManagement // 어노테이션기반의 트랜잭션이 가능하도록 하는 설정 <tx:annotation-driven>
public class TransactionAopConfig {
	
	private static final String AOP_POINTCUT_EXPRESSION = "execution(* *..*.*Svc.*(..))";

	@Bean(name = "transactionManager")
	public DataSourceTransactionManager dataSourceTransactionManager(@Qualifier("dataSource") DataSource dataSource) {
		return new DataSourceTransactionManager(dataSource);
	}
	
	@Bean
	public TransactionInterceptor transactionInterceptor(DataSourceTransactionManager dataSourceTransactionManager) {
		TransactionInterceptor transactionInterceptor = new TransactionInterceptor();
		Properties properties = new Properties();
		
		List<RollbackRuleAttribute> rollbackRules = new ArrayList<RollbackRuleAttribute>();
		rollbackRules.add(new RollbackRuleAttribute(Exception.class));
		
		RuleBasedTransactionAttribute ruleBasedTransactionAttribute = 
				new RuleBasedTransactionAttribute(TransactionDefinition.PROPAGATION_REQUIRED, rollbackRules);
		String writeTransactionAttributesDefinition = ruleBasedTransactionAttribute.toString();
		properties.setProperty("*", writeTransactionAttributesDefinition);
		
		transactionInterceptor.setTransactionAttributes(properties);
		transactionInterceptor.setTransactionManager(dataSourceTransactionManager);
		
		return transactionInterceptor;
	}
	
	@Bean
	public Advisor advisor(@Qualifier("transactionManager") DataSourceTransactionManager dataSourceTransactionManager) {
		AspectJExpressionPointcut aspectJExpressionPointcut = new AspectJExpressionPointcut();
		aspectJExpressionPointcut.setExpression(AOP_POINTCUT_EXPRESSION);
		return new DefaultPointcutAdvisor(aspectJExpressionPointcut, transactionInterceptor(dataSourceTransactionManager));
	}
}
