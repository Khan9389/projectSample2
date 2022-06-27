package common.utils.common;

public class PentasMapBuilder {
	
	PentasMap pentasMap;
	
	public PentasMapBuilder() {
		this.pentasMap = new PentasMap();
	}
	
	public PentasMapBuilder(PentasMap pentasMap) {
		this.pentasMap = new PentasMap();
		this.pentasMap.putAll(pentasMap);
	}
	
	public PentasMapBuilder putAll(PentasMap pentasMap) {
		this.pentasMap.putAll(pentasMap);
		return this;
	}
	
	public PentasMapBuilder put(Object key, Object value) {
		pentasMap.put(key, value);
		return this;
	}
	
	public PentasMap build(){
		return pentasMap;
	}
}
