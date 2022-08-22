package com.precub;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class CurrentUserControllerAdvice {

    @ModelAttribute("currentUser")
    public CurrentUser getCurrentUser(Authentication authentication) {
        CurrentUser currentUser = null;
        if(authentication != null) {
            User user = (User) authentication.getPrincipal();
            currentUser = new CurrentUser(user);
        }

        return currentUser;
    }


}