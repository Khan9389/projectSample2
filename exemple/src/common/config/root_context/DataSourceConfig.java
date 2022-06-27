package common.config.root_context;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import net.sf.log4jdbc.Log4jdbcProxyDataSource;
import net.sf.log4jdbc.tools.Log4JdbcCustomFormatter;
import net.sf.log4jdbc.tools.LoggingType;

@Configuration
public class DataSourceConfig {
	
	@Autowired
	Environment environment;
	
    private static HikariConfig config = new HikariConfig();
    private static HikariDataSource ds;

	@Bean(name = "dataSource")
	public DataSource dataSource() {
		
//		DriverManagerDataSource dataSource = new DriverManagerDataSource();
//		dataSource.setDriverClassName(environment.getProperty("datasource.driverClassName"));
//		dataSource.setUrl(environment.getProperty("datasource.url"));
//		dataSource.setUsername(environment.getProperty("datasource.username"));
//		dataSource.setPassword(environment.getProperty("datasource.password"));
//		
//		Log4jdbcProxyDataSource log4jdbcProxyDataSource = new Log4jdbcProxyDataSource(dataSource);
//		
//		log4jdbcProxyDataSource.setLogFormatter(
//				new Log4JdbcCustomFormatter() {{
//					setLoggingType(LoggingType.MULTI_LINE);
//					setSqlPrefix(" SQL ===> \n");
//				}});
//		
//        return log4jdbcProxyDataSource;
		config.setDriverClassName(environment.getProperty("datasource.driverClassName"));
        config.setJdbcUrl(environment.getProperty("datasource.url"));
        config.setUsername(environment.getProperty("datasource.username"));
        config.setPassword(environment.getProperty("datasource.password"));
        config.addDataSourceProperty( "cachePrepStmts" , "true" );
        config.addDataSourceProperty( "prepStmtCacheSize" , "250" );
        config.addDataSourceProperty( "prepStmtCacheSqlLimit" , "2048" );
        ds = new HikariDataSource( config );
        
		Log4jdbcProxyDataSource log4jdbcProxyDataSource = new Log4jdbcProxyDataSource(ds);
		
		log4jdbcProxyDataSource.setLogFormatter(
				new Log4JdbcCustomFormatter() {{
					setLoggingType(LoggingType.MULTI_LINE);
					setSqlPrefix(" SQL ===> \n");
				}});
		
        return log4jdbcProxyDataSource;
		
	}
	
    @Bean(name = "sqlSession")
    public SqlSessionFactory SqlSessionFactory(ApplicationContext applicationContext) throws Exception{
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(dataSource());
        sqlSessionFactoryBean.setMapperLocations(applicationContext.getResources("classpath:/**/*_SQL.xml"));
        sqlSessionFactoryBean.setConfigLocation(applicationContext.getResource("classpath:/common/config/mybatis/mybatis-config.xml"));
        return sqlSessionFactoryBean.getObject();
    }
    
    @Bean
    public SqlSessionTemplate sqlSessionTemplate(@Qualifier("sqlSession") SqlSessionFactory sqlSessionFactory) {
    	return new SqlSessionTemplate(sqlSessionFactory);
    }
}
