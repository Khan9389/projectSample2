package common.utils.excel;

import java.util.List;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;

import common.utils.common.ExcelDownConfig;
import common.utils.common.PentasMap;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ExcelDataProcess {

public void process(ExcelDownConfig config, List<PentasMap> dataList, Workbook workbook) {
		
		String sheetName = config.getString("sheetName");
		List<String> columnsInfo = (List<String>) config.get("columnsInfo");
		
		int columnsInfoLength = columnsInfo.size();
		
		String[] columnTitleList = new String[columnsInfoLength];
		String[] columnKeyList = new String[columnsInfoLength];
		Integer[] columnSizeList = new Integer[columnsInfoLength];
		
		for(int i = 0; i < columnsInfoLength; i++) {
			String[] tmp = columnsInfo.get(i).split("\\|");
			columnKeyList[i] = tmp[0];
			columnTitleList[i] = tmp[1];
			columnSizeList[i] = Integer.parseInt(tmp[2]);
		}
		
		log.debug("### buildExcelDocument start !!!");
		
		Sheet worksheet = workbook.createSheet(sheetName);
		
		Cell cell = null;
		CellStyle headerCellStyle = workbook.createCellStyle();
		headerCellStyle.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.index);
		headerCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		headerCellStyle.setBorderBottom(BorderStyle.THIN);
		headerCellStyle.setBorderLeft(BorderStyle.THIN);
		headerCellStyle.setBorderRight(BorderStyle.THIN);
		headerCellStyle.setBorderTop(BorderStyle.THIN);
		headerCellStyle.setAlignment(HorizontalAlignment.CENTER);
		
		for(int i=0; i<columnSizeList.length; i++){
			worksheet.setColumnWidth(i, columnSizeList[i]);			
		}
		
		int rowCnt = -1;
		
		Row row = null;
		
		// 엑셀 컬럼제목 넣기
		row = worksheet.createRow(++rowCnt);
		for(int i=0; i<columnTitleList.length; i++){
			cell = row.createCell(i);
			cell.setCellValue(columnTitleList[i]);
			cell.setCellStyle(headerCellStyle);			
		}
		
		CellStyle bodyCellStyle = workbook.createCellStyle();
		bodyCellStyle.setAlignment(HorizontalAlignment.CENTER);
		bodyCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		
		// 엑셀 데이터넣기	
		for(PentasMap data : dataList){
			row = worksheet.createRow(++rowCnt);
			for(int i=0; i<columnsInfoLength; i++){
				cell = row.createCell(i);
				if (data.get(columnKeyList[i]) instanceof Integer) {
					cell.setCellValue((int)data.get(columnKeyList[i]));
					cell.setCellStyle(bodyCellStyle);
				} else if (data.get(columnKeyList[i]) instanceof String) {
					cell.setCellValue((String)data.get(columnKeyList[i]));
					cell.setCellStyle(bodyCellStyle);
				} else {
					cell.setCellValue("");
					cell.setCellStyle(bodyCellStyle);
				}
			}
		}	
	}
}
