package com.precub.blog.service;

import com.buttercms.IButterCMSClient;
import com.buttercms.model.Category;
import com.buttercms.model.Post;
import com.buttercms.model.Tag;
import com.precub.blog.dto.BlogsDto;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import static com.precub.blog.dto.ConstDtoValues.*;

@Service
public class BlogService {
    private final IButterCMSClient butterCMSClient;
    
    // Cache for blog posts and categories
    private final Map<String, List<Post>> postsCache = new ConcurrentHashMap<>();
    private final Map<String, List<Category>> categoriesCache = new ConcurrentHashMap<>();
    private final Map<String, Post> singlePostCache = new ConcurrentHashMap<>();
    private final Map<String, Category> singleCategoryCache = new ConcurrentHashMap<>();
    private final Map<String, Tag> singleTagCache = new ConcurrentHashMap<>();
    
    // Cache timestamps
    private volatile LocalDateTime lastCacheUpdate = null;
    private static final long CACHE_DURATION_HOURS = 25;

    public BlogService(IButterCMSClient butterCMSClient) {
        this.butterCMSClient = butterCMSClient;
    }
    
    private boolean isCacheExpired() {
        return lastCacheUpdate == null || 
               LocalDateTime.now().isAfter(lastCacheUpdate.plusHours(CACHE_DURATION_HOURS));
    }
    
    private void refreshCacheIfNeeded() {
        if (isCacheExpired()) {
            synchronized (this) {
                if (isCacheExpired()) {
                    refreshCache();
                }
            }
        }
    }
    
    private void refreshCache() {
        try {
            // Clear existing cache
            postsCache.clear();
            categoriesCache.clear();
            singlePostCache.clear();
            singleCategoryCache.clear();
            singleTagCache.clear();
            
            // Cache all posts
            List<Post> allPosts = butterCMSClient.getPosts(Collections.emptyMap()).getData();
            postsCache.put("all", allPosts);
            
            // Cache individual posts by slug
            for (Post post : allPosts) {
                singlePostCache.put(post.getSlug(), post);
            }
            
            // Cache all categories
            List<Category> allCategories = butterCMSClient.getCategories(Collections.emptyMap()).getData();
            categoriesCache.put("all", allCategories);
            
            // Cache individual categories by slug
            for (Category category : allCategories) {
                singleCategoryCache.put(category.getSlug(), category);
            }
            
            lastCacheUpdate = LocalDateTime.now();
        } catch (Exception e) {
            // Log error but don't throw - fallback to direct API calls
            System.err.println("Error refreshing blog cache: " + e.getMessage());
        }
    }
    
    private List<Post> getCachedPosts() {
        refreshCacheIfNeeded();
        return postsCache.getOrDefault("all", Collections.emptyList());
    }
    
    private List<Category> getCachedCategories() {
        refreshCacheIfNeeded();
        return categoriesCache.getOrDefault("all", Collections.emptyList());
    }
    
    private Post getCachedPost(String slug) {
        refreshCacheIfNeeded();
        return singlePostCache.get(slug);
    }
    
    private Category getCachedCategory(String slug) {
        refreshCacheIfNeeded();
        return singleCategoryCache.get(slug);
    }

    public BlogsDto getBlogs() {
        List<Post> posts = getCachedPosts();
        List<Category> categories = getCachedCategories();
        
        // Fallback to direct API call if cache is empty
        if (posts.isEmpty()) {
            posts = butterCMSClient.getPosts(Collections.emptyMap()).getData();
        }
        if (categories.isEmpty()) {
            categories = butterCMSClient.getCategories(Collections.emptyMap()).getData();
        }
        
        BlogsDto dto = new BlogsDto();
        dto.setSeoTitle(BLOG_SEO_TITLE);
        dto.setSeoDescription(BLOG_SEO_DESCRIPTION);
        dto.setBreadcrumbText(ALL_BLOGS);
        dto.setPosts(posts);
        dto.setCategories(categories);
        return dto;
    }

    public BlogsDto getBlogsBySlug(String slug) {
        Post post = getCachedPost(slug);
        List<Category> categories = getCachedCategories();
        
        // Fallback to direct API call if not in cache
        if (post == null) {
            post = butterCMSClient.getPost(slug).getData();
        }
        if (categories.isEmpty()) {
            categories = butterCMSClient.getCategories(Collections.emptyMap()).getData();
        }
        
        BlogsDto dto = new BlogsDto();
        dto.setSeoTitle(post.getSeoTitle());
        dto.setSeoDescription(post.getMetaDescription());
        dto.setBreadcrumbText(post.getTitle());
        dto.setSubCollection(post.getTitle());
        dto.setCategories(categories);
        dto.setPosts(Collections.singletonList(post));
        dto.setFeaturedImageUrl(post.getFeaturedImage());
        return dto;
    }

    public BlogsDto getBlogsByCategory(String categorySlug) {
        Category category = getCachedCategory(categorySlug);
        List<Category> categories = getCachedCategories();
        
        // Filter posts by category from cache
        List<Post> posts = getCachedPosts().stream()
            .filter(post -> post.getCategories().stream()
                .anyMatch(cat -> cat.getSlug().equals(categorySlug)))
            .toList();
        
        // Fallback to direct API call if not in cache
        if (category == null) {
            category = butterCMSClient.getCategory(categorySlug, Collections.emptyMap()).getData();
        }
        if (posts.isEmpty()) {
            Map<String, String> queryParams = new HashMap<>() {{
                put("category_slug", categorySlug);
            }};
            posts = butterCMSClient.getPosts(queryParams).getData();
        }
        if (categories.isEmpty()) {
            categories = butterCMSClient.getCategories(Collections.emptyMap()).getData();
        }
        
        String categoryName = category.getName();
        BlogsDto dto = new BlogsDto();
        dto.setSeoTitle(BLOG_CATEGORY_SEO_TITLE + categoryName);
        dto.setSeoDescription(BLOG_CATEGORY_SEO_DESCRIPTION + categoryName);
        dto.setBreadcrumbText(BLOGS_BY_CATEGORY);
        dto.setSubCollection("Category: " + categoryName);
        dto.setPosts(posts);
        dto.setCategories(categories);
        return dto;
    }

    public BlogsDto getBlogsByTag(String tagSlug) {
        Tag tag = singleTagCache.get(tagSlug);
        List<Category> categories = getCachedCategories();
        
        // Filter posts by tag from cache
        List<Post> posts = getCachedPosts().stream()
            .filter(post -> post.getTags().stream()
                .anyMatch(t -> t.getSlug().equals(tagSlug)))
            .toList();
        
        // Fallback to direct API call if not in cache
        if (tag == null) {
            tag = butterCMSClient.getTag(tagSlug, Collections.emptyMap()).getData();
            singleTagCache.put(tagSlug, tag);
        }
        if (posts.isEmpty()) {
            Map<String, String> queryParams = new HashMap<>() {{
                put("tag_slug", tagSlug);
            }};
            posts = butterCMSClient.getPosts(queryParams).getData();
        }
        if (categories.isEmpty()) {
            categories = butterCMSClient.getCategories(Collections.emptyMap()).getData();
        }
        
        String tagName = tag.getName();
        BlogsDto dto = new BlogsDto();
        dto.setSeoTitle(BLOG_TAG_SEO_TITLE + tagName);
        dto.setSeoDescription(BLOG_TAG_SEO_DESCRIPTION + tagName);
        dto.setBreadcrumbText(BLOGS_BY_TAG);
        dto.setSubCollection("Tag: " + tagName);
        dto.setPosts(posts);
        dto.setCategories(categories);
        return dto;
    }

    public BlogsDto searchBlogs(String searchTerm) {
        List<Category> categories = getCachedCategories();
        
        // Perform search on cached posts (simple title and content search)
        String lowerSearchTerm = searchTerm.toLowerCase();
        List<Post> posts = getCachedPosts().stream()
            .filter(post -> 
                post.getTitle().toLowerCase().contains(lowerSearchTerm) ||
                post.getSummary().toLowerCase().contains(lowerSearchTerm) ||
                (post.getBody() != null && post.getBody().toLowerCase().contains(lowerSearchTerm)))
            .toList();
        
        // Fallback to ButterCMS search API if cache search returns no results
        if (posts.isEmpty()) {
            Map<String, String> queryParams = new HashMap<>() {{
                put("query", searchTerm);
            }};
            posts = butterCMSClient.getSearchPosts(queryParams).getData();
        }
        if (categories.isEmpty()) {
            categories = butterCMSClient.getCategories(Collections.emptyMap()).getData();
        }
        
        BlogsDto dto = new BlogsDto();
        dto.setSeoTitle(BLOG_SEARCH_SEO_TITLE + searchTerm);
        dto.setSeoDescription(BLOG_SEARCH_SEO_DESCRIPTION + searchTerm);
        dto.setBreadcrumbText(SEARCH_RESULTS);
        dto.setSubCollection("Search: " + searchTerm);
        dto.setPosts(posts);
        dto.setCategories(categories);
        return dto;
}
}
