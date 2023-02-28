package com.precub.blog;

import com.precub.blog.dto.BlogsDto;
import com.precub.blog.service.BlogService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.concurrent.CompletableFuture;
import java.util.concurrent.Executor;

@Controller
public class BlogController {


    private final BlogService blogService;

    private final Executor executor;

    public BlogController(BlogService blogService, Executor executor) {
        this.blogService = blogService;
        this.executor = executor;
    }

    @GetMapping("/blog")
    public ModelAndView blogs(Model model) {
        BlogsDto blogsDto = blogService.getBlogs();
        model.addAttribute("posts", blogsDto.getPosts());
        model.addAttribute("categories", blogsDto.getCategories());
        model.addAttribute("seoTitle", blogsDto.getSeoTitle());
        model.addAttribute("seoDescription", blogsDto.getSeoDescription());
        model.addAttribute("breadcrumbText", blogsDto.getBreadcrumbText());
        return new ModelAndView("blog/blog");
    }

    @GetMapping("/testasync")
    public CompletableFuture<ResponseEntity<String>> testAsync() {
        return CompletableFuture.supplyAsync(() -> {
            System.out.println(Thread.currentThread().getName() + "_____controller");
           return new ResponseEntity<>("async result", HttpStatus.OK);
        });
    }



    @GetMapping("/blog/{slug}")
    public String blogById(@PathVariable String slug, Model model) {
        BlogsDto blogsDto = blogService.getBlogsBySlug(slug);
        model.addAttribute("post", blogsDto.getPosts().get(0));
        model.addAttribute("categories", blogsDto.getCategories());
        model.addAttribute("seoTitle", blogsDto.getSeoTitle());
        model.addAttribute("seoDescription", blogsDto.getSeoDescription());
        model.addAttribute("breadcrumbText", blogsDto.getBreadcrumbText());
        model.addAttribute("subCollection", blogsDto.getSubCollection());
        return "blog/blog-post";
    }

    @GetMapping("/blog/category/{categorySlug}")
    public String blogByCategory(@PathVariable String categorySlug, Model model) {
        BlogsDto blogsDto = blogService.getBlogsByCategory(categorySlug);
        model.addAttribute("posts", blogsDto.getPosts());
        model.addAttribute("category", blogsDto.getCategory());
        model.addAttribute("categories", blogsDto.getCategories());
        model.addAttribute("seoTitle", blogsDto.getSeoTitle());
        model.addAttribute("seoDescription", blogsDto.getSeoDescription());
        model.addAttribute("breadcrumbText", blogsDto.getBreadcrumbText());
        model.addAttribute("subCollection", blogsDto.getSubCollection());
        return "blog/blog";
    }

    @GetMapping("/blog/tag/{tagSlug}")
    public String blogByTag(@PathVariable String tagSlug, Model model) {
        BlogsDto blogsDto = blogService.getBlogsByTag(tagSlug);
        model.addAttribute("posts", blogsDto.getPosts());
        model.addAttribute("tag", blogsDto.getTag());
        model.addAttribute("categories", blogsDto.getCategories());
        model.addAttribute("seoTitle", blogsDto.getSeoTitle());
        model.addAttribute("seoDescription", blogsDto.getSeoDescription());
        model.addAttribute("breadcrumbText", blogsDto.getBreadcrumbText());
        model.addAttribute("subCollection", blogsDto.getSubCollection());
        return "blog/blog";
    }

    @GetMapping(value = "/blog/search")
    public String search(@RequestParam(name = "q", required = false, defaultValue = "") String searchTerm, Model model) {
        BlogsDto blogsDto = blogService.searchBlogs(searchTerm);
        model.addAttribute("posts", blogsDto.getPosts());
        model.addAttribute("categories", blogsDto.getCategories());
        model.addAttribute("seoTitle", blogsDto.getSeoTitle());
        model.addAttribute("seoDescription", blogsDto.getSeoDescription());
        model.addAttribute("breadcrumbText", blogsDto.getBreadcrumbText());
        model.addAttribute("subCollection", blogsDto.getSubCollection());
        return "blog/blog";
    }

}
