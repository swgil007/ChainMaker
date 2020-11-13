package kr.happyjob.chainmaker.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.chainmaker.scm.model.DailyOrderListVO;
import kr.happyjob.chainmaker.scm.model.OrderDetailByOrderNoAndProNoDTO;
import kr.happyjob.chainmaker.scm.model.PageAndOrderInfoDTO;
import kr.happyjob.chainmaker.scm.model.WHInfoByProNoDTO;
import kr.happyjob.chainmaker.scm.model.WHInfoByProNoVO;

public interface DailyOrderHistoryService {

	/** 일별 주문 목록 조회 */
	public List<DailyOrderListVO> listDailyOrder(PageAndOrderInfoDTO pageOrderInfoDTO);
	
	// 주문 목록 개수 조회
	public int countListDailyOrder();
	
	// 주문 번호, 제품 번호로 주문 상세 정보 조회
	public OrderDetailByOrderNoAndProNoDTO selectOrderDetailByOrderNoAndProNo(PageAndOrderInfoDTO pageOrderInfoDTO);
	
	// 제품번호에 해당하는 제품이 있는 창고 정보 조회
	public List<WHInfoByProNoDTO> selectWHInfoByProNo(String pro_no);
}
