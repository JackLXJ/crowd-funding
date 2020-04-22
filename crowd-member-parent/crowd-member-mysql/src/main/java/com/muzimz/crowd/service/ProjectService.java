package com.muzimz.crowd.service;

import com.muzimz.crowd.entity.vo.DetailProjectVO;
import com.muzimz.crowd.entity.vo.PortalTypeVO;
import com.muzimz.crowd.entity.vo.ProjectVO;

import java.util.List;

public interface ProjectService {

	void saveProject(ProjectVO projectVO, Integer memberId);

	List<PortalTypeVO> getPortalTypeVO();

	DetailProjectVO getDetailProjectVO(Integer projectId);
}
