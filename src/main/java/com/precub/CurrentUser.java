package com.precub;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.Collection;

public class CurrentUser {

    private String username;
    private  Collection<GrantedAuthority> roles;

    public CurrentUser(User user) {
        this.username = user.getUsername();
        this.roles = user.getAuthorities();
    }

    public String getUsername() {
        return username;
    }

    public Collection<GrantedAuthority> getRoles() {
        return roles;
    }

    @Override
    public String toString() {
        return "CurrentUser{" +
                "user=" + username +
                "} " + super.toString();
    }
}