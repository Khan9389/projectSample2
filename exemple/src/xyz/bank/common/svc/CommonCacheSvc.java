package xyz.bank.common.svc;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import common.dao.CmmnDao;
import common.utils.common.PentasMap;

@Service
public class CommonCacheSvc {

	@Autowired
	CmmnDao cmmnDao;
	
	@Cacheable(value = "ComCodeCache")
	public List<PentasMap> getComCodeCache(){
		return cmmnDao.selectList("common.getComCodeList");
	}
	
	@CacheEvict(value = "ComCodeCache")
	public void clearComCodeCache(){
		
	}
}
