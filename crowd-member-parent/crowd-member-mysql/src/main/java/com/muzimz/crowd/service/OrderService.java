package com.muzimz.crowd.service;

import java.util.List;

import com.muzimz.crowd.entity.vo.AddressVO;
import com.muzimz.crowd.entity.vo.OrderProjectVO;
import com.muzimz.crowd.entity.vo.OrderVO;

public interface OrderService {

	OrderProjectVO getOrderProjectVO(Integer projectId, Integer returnId);

	List<AddressVO> getAddressVOList(Integer memberId);

	void saveAddress(AddressVO addressVO);

	void saveOrder(OrderVO orderVO);

}
