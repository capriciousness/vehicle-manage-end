package com.internship.ds.filter;

import com.internship.ds.exceptionAOP.enums.ExceptionEnums;
import com.internship.ds.exceptionAOP.exception.ZcException;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@Component
@WebFilter(filterName = "LoginFilter",urlPatterns = "/*")
@Order(1)  //Order(1)在定义多个Filter时，用于决定执行顺序的，数字越小，越先执行。
public class LoginFilter implements Filter {
    private static final String [] ALLOWEDPATH = {"/login","/register",".ico",".js",".css",".jpg",".png","/fonts/"};
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
      // 这样在每个Servlet执行的时候都会先进行这个
        HttpServletRequest request= (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        if(needLogin(request)) {
            // 需要登录则跳转到登录Controller
            String userName = (String)((HttpServletRequest) request).getSession().getAttribute("username");
            System.out.println(userName);
            if(Optional.ofNullable(userName).map(String::length).orElse(0) <= 0){
                //response.sendRedirect("login.html");
                response.sendRedirect(request.getContextPath()+"/login.html");
                //throw new ZcException(ExceptionEnums.NOT_LOGGED_IN);
            }
            filterChain.doFilter(servletRequest, servletResponse);
            return;
        }else{
        }
        //因为有可能不止这一个过滤器,所以需要将所有的过滤器执行
        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {

    }

    private boolean needLogin(HttpServletRequest request) {
        //进行是否需要登录的判断操作
        String path = request.getRequestURI().substring(request.getContextPath().length()).replaceAll("[/]+$", "");
        System.out.println(path);
        boolean allowedPath = false;
        for (String url : ALLOWEDPATH) {
            if(path.contains(url)){
                allowedPath = true;
                break;
            }
        }
        return !allowedPath;
    }
}
