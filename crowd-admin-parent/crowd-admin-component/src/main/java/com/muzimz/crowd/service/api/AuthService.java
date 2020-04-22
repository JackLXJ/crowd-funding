package com.muzimz.crowd.service.api;

import java.util.List;
import java.util.Map;

import com.muzimz.crowd.entity.Auth;

public interface AuthService {

	List<Auth> getAll();

	List<Integer> getAssignedAuthIdByRoleId(Integer roleId);

	void saveRoleAuthRelathinship(Map<String, List<Integer>> map);

	List<String> getAssignedAuthNameByAdminId(Integer adminId);

}
