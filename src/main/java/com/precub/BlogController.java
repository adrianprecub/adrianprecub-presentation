package com.precub;

import com.buttercms.IButterCMSClient;
import com.buttercms.model.PostResponse;
import com.buttercms.model.PostsResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.stream.Collectors;

@Controller
public class BlogController {

    private final IButterCMSClient butterCMSClient;

    @Autowired
    public BlogController(IButterCMSClient butterCMSClient) {
        this.butterCMSClient = butterCMSClient;
    }

    @RequestMapping("/blog")
    public String getBlogs(Model model, @RequestParam(value = "category", required = false) String category,
                           @RequestParam(value = "tag", required = false) String tag) {
        PostsResponse posts = butterCMSClient.getPosts(new HashMap<>() {{
            put("category_slug", category);
            put("tag_slug", tag);
        }});
        if (posts.getData() == null || posts.getData().isEmpty()) {
            return "404";
        }
        System.out.println("posts:" + posts);
        model.addAttribute("blogs", posts.getData().stream()
                .map(value ->
                        new HashMap<String, String>() {{
                            put("slug", value.getSlug());
                            put("title", value.getTitle());
                        }}
                ).collect(Collectors.toList()));
        model.addAttribute("category", category);
        model.addAttribute("tag", tag);
        return "blog";
    }

    @RequestMapping("/blog/{slug}")
    public String getBlog(Model model, @PathVariable("slug") String slug) {
        PostResponse post = butterCMSClient.getPost(slug);
        model.addAttribute("blog", post.getData());
        return "blog-entry";
    }

}
