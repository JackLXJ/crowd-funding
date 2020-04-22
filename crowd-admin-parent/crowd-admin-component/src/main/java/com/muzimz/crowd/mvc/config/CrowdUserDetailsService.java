package com.muzimz.crowd.mvc.config;

import com.muzimz.crowd.entity.Admin;
import com.muzimz.crowd.entity.Role;
import com.muzimz.crowd.service.api.AdminService;
import com.muzimz.crowd.service.api.AuthService;
import com.muzimz.crowd.service.api.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class CrowdUserDetailsService implements UserDetailsService {

    @Autowired
    private AdminService adminService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private AuthService authService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        Admin admin = adminService.getAdminByLoginAcct(username, "");

        Integer adminId = admin.getId();

        List<Role> assignedRole = roleService.getAssignedRole(adminId);

        List<String> authNameList = authService.getAssignedAuthNameByAdminId(adminId);

        ArrayList<GrantedAuthority> authorities = new ArrayList<>();

        for (Role role: assignedRole) {
            String roleName = "ROLE_" + role.getName();
            SimpleGrantedAuthority simpleGrantedAuthority = new SimpleGrantedAuthority(roleName);
            authorities.add(simpleGrantedAuthority);
        }
        for (String authName: authNameList) {
            SimpleGrantedAuthority simpleGrantedAuthority = new SimpleGrantedAuthority(authName);
            authorities.add(simpleGrantedAuthority);
        }
        SecurityAdmin securityAdmin = new SecurityAdmin(admin, authorities);
        return securityAdmin;

    }
}
