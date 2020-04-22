package com.muzimz.crowd.service.api;

import java.util.List;

import com.github.pagehelper.PageInfo;
import com.muzimz.crowd.entity.Admin;

public interface AdminService {
	
	void saveAdmin(Admin admin);

	List<Admin> getAll();

    Admin getAdminByLoginAcct(String loginAcct, String userPswd);

    PageInfo<Admin> getAdminPage(String keyword, Integer pageNum,
								 Integer pageSize);

    Admin getAdminById(Integer adminId);

    void updateAdmin(Admin admin);

    void removeAdminById(Integer adminId);

    void saveAdminRoleRelationship(Integer adminId,  List<Integer> roleIdList);

}
