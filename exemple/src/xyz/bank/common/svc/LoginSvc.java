package xyz.bank.common.svc;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CmmnDao;

@Service
public class LoginSvc {
	
	@Autowired
	CmmnDao cmmnDao;

}