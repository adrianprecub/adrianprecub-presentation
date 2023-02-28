package com.precub.blog;

import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter
@Component
public class GenericLoggingFilter extends OncePerRequestFilter {
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;

        System.out.println(Thread.currentThread().getName() + "_____filter" + httpServletRequest.getMethod() + "_____" + httpServletRequest.getRequestURI());

        chain.doFilter(request, response);
    }
//    @Override
//    public void doFilter(ServletRequest request, ServletResponse response,
//                         FilterChain chain) throws IOException, ServletException {
//        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
//
//        System.out.println(httpServletRequest.getMethod() + " " +
//                httpServletRequest.getRequestURI());
//
//        chain.doFilter(request, response);
//    }
}
