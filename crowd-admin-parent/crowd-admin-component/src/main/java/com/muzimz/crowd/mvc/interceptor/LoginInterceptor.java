package com.muzimz.crowd.mvc.interceptor;

import com.muzimz.crowd.constant.CrowdConstant;
import com.muzimz.crowd.entity.Admin;
import com.muzimz.crowd.exception.AccessForbiddenException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        // 1. 通过request对象获取session对象
        HttpSession session = request.getSession();
        // 2. 尝试从session域中获取admin对象
        Admin admin = (Admin)session.getAttribute(CrowdConstant.ATTR_NAME_LOGIN_ADMIN);
        if (admin == null) {
            // 4. 抛出异常
            throw new AccessForbiddenException(CrowdConstant.MESSAGE_ACCESS_FORBIDEN);
        }
        // 5. 如果ADmin对象不为null，则返回true放行
        return super.preHandle(request, response, handler);
    }
}
