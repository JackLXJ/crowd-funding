package com.muzimz.crowd.mvc.handler;

import com.github.pagehelper.PageInfo;
import com.muzimz.crowd.constant.CrowdConstant;
import com.muzimz.crowd.entity.Admin;
import com.muzimz.crowd.service.api.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

@Controller
public class AdminHandler {

    @Autowired
    public AdminService adminService;

    @RequestMapping(value = "admin/remove/page.html")
    public String removeAdminById(@RequestParam(value = "adminId") Integer adminId) {
        adminService.removeAdminById(adminId);
        return "redirect:/admin/page.html?pageNum=1";
    }

    @RequestMapping(value = "/admin/update.html")
    public String updateAdmin(Admin admin) {
        adminService.updateAdmin(admin);
        return "redirect:/admin/page.html?pageNum=1";
    }

    @RequestMapping(value = "/admin/to/edit/page.html")
    public String toEditPage(@RequestParam("adminId") Integer adminId,
                             ModelMap modelMap) {
        Admin admin = adminService.getAdminById(adminId);
        modelMap.addAttribute("admin", admin);
        return "admin-edit";
    }

    @PreAuthorize("hasRole('user:save')")
    @RequestMapping(value = "/save/admin.html")
    public String saveAdmin(Admin admin) {
        adminService.saveAdmin(admin);
        return "redirect:/admin/page.html?pageNum=" + Integer.MAX_VALUE;
    }

    @RequestMapping(value = "/admin/page.html")
    public String getAdminPage(@RequestParam(value = "keyword", defaultValue = "") String keyword,
                               @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
                               @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                               ModelMap modelMap) {
        PageInfo<Admin> pageInfo = adminService.getAdminPage(keyword, pageNum, pageSize);
        System.out.println(pageInfo);
        modelMap.addAttribute(CrowdConstant.ATTR_NAME_PAGE_INFO, pageInfo);
        return "admin-page";
    }

    @RequestMapping("/admin/do/logout.html")
    public String doLogout(HttpSession session) {
        // 强制Session失效
        session.invalidate();
        return "redirect:/admin/to/login/page.html";
    }

    @RequestMapping("/admin/do/login.html")
    public String doLogin(@RequestParam("loginAcct") String loginAcct,
                          @RequestParam("userPswd") String userPswd,
                          HttpSession session) {
        // 调用Service方法执行登录检查
        // 这个方法如果能够返回admin对象则说明登录成功，如果账号、密码不正确则抛出异常
        Admin admin = adminService.getAdminByLoginAcct(loginAcct, userPswd);

        // 登录成功返回的admin对象存入session域中
        session.setAttribute(CrowdConstant.ATTR_NAME_LOGIN_ADMIN, admin);
        return "redirect:/admin/to/main/page.html";
    }
}
