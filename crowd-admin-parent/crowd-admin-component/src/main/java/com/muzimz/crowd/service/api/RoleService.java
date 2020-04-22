package com.muzimz.crowd.service.api;

import com.github.pagehelper.PageInfo;
import com.muzimz.crowd.entity.Role;

import java.util.List;

public interface RoleService {

    public PageInfo<Role> getPageInfo(Integer pageNume, Integer pageSize, String keyword);

    void saveRole(Role role);

    void updateRole(Role role);

    void removeRole(List<Integer> roleIdList);

    List<Role> getAssignedRole(Integer adminId);

    List<Role> getUnAssignedRole(Integer adminId);
}
