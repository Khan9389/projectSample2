package common.config.properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import common.dao.CmmnDao;
import common.utils.common.CmmnUtil;
import common.utils.common.PentasMap;
import common.utils.crypt.CryptUtil;
import lombok.Data;

@Component
@Data
public class SettingProperties {
   
   @Autowired
   CmmnDao cmmnDao;
   
   @Value("${run.env}")
   private String runEnv;
   
   @Value("${rsc.ver}")
   private String rscVer;
   
   @Value("${upload.root.path_win}")
   private String uploadRootPath_win;
   
   @Value("${upload.root.path_linux}")
   private String uploadRootPath_linux;   
   
   @Value("${upload.path}")
   private String uploadPath;
   
   @Value("${upload.max.size}")
   private String uploadMaxSize;
   
   @Value("${upload.video.max.size}")
   private String uploadVideoMaxSize;
   
   @Value("${upload.deny.ext.list}")
   private String uploadDenyExtList;

}