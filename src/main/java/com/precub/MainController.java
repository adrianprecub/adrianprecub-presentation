package com.precub;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {
    @GetMapping(value = "/")
    public String index(Model model) {

        return "index";
    }

    @GetMapping(value = "/login")
    public ModelAndView login(Model model) {

        return new ModelAndView("login");
    }

    @GetMapping(value = "/success")
    public ModelAndView success(Model model) {

        return new ModelAndView("success");
    }

    @GetMapping(value = "/about")
    public ModelAndView about(Model model) {

        return new ModelAndView("about");
    }

    @GetMapping(value = "/apps")
    public ModelAndView apps(Model model) {

        return new ModelAndView("apps");
    }

//    @GetMapping(value = "/blog")
//    public ModelAndView blog(Model model) {
//
//        return new ModelAndView("blog");
//    }



}
