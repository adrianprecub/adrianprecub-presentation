<!DOCTYPE html>
<html>
<#include "../header.ftlh">
<@header pageTitle="Adrian Precub's Blog" seoTitle="Adrian Precub" seoDescription="Personal Blog Java Backend Software Engineering Architecture"/>

<body>
    <#include "../top.ftlh">
    
    <section class="containerOuter" id="blogIntro">
        <section class="containerInnerNarrow">
            <h2>Blog</h2>
        </section>
    </section>
    
    <section class="containerOuter blogBodyContainer">
        <section class="containerInner blogBody">
            <p class="blog-intro">
                Welcome to my blog where I share insights on backend development, software architecture, and technology.
            </p>

            <#if categories?has_content>
                <div class="blog-categories">
                    <h4>Browse by Category:</h4>
                    <div class="categories-grid">
                        <#list categories as category>
                            <a href="/blog/category/${category['slug']}" class="category-badge">
                                <span class="category-icon">📂</span>
                                <span class="category-name">${category['name']}</span>
                            </a>
                        </#list>
                    </div>
                </div>
            </#if>
            
            <div class="blog-posts-grid">
                <#list posts as post>
                    <article class="blog-post-card">
                        <div class="post-header">
                            <h3><a href="/blog/${post['slug']}" class="post-title-link">${post['title']}</a></h3>
                            <div class="post-meta">
                                <span class="post-date">${post['published']?date}</span>
                                <#if post['categories']?has_content>
                                    <div class="post-categories">
                                        <#list post['categories'] as category>
                                            <a href="/blog/category/${category['slug']}" class="category category-link">${category['name']}</a>
                                        </#list>
                                    </div>
                                </#if>
                                <#if post['tags']??>
                                    <div class="post-tags">
                                        <#list post['tags'] as tag>
                                            <a href="/blog/tag/${tag['slug']}" class="tag tag-link">${tag['name']}</a>
                                        </#list>
                                    </div>
                                </#if>
                            </div>
                        </div>
                        
                        <div class="post-content">
                            <div class="post-excerpt">
                                <#if post['summary']??>
                                    ${post['summary']}
                                <#else>
                                    <#-- Extract first paragraph or truncate body -->
                                    ${post['body']?no_esc?truncate(200, '...')}
                                </#if>
                            </div>
                            
                            <div class="post-actions">
                                <a href="/blog/${post['slug']}" class="btn btn-primary">
                                    <span class="icon">📖</span> Read More
                                </a>
                            </div>
                        </div>
                    </article>
                </#list>
            </div>
            
            <#if posts?size == 0>
                <div class="no-posts">
                    <h3>No Posts Yet</h3>
                    <p>Check back soon for new blog posts about software development and technology!</p>
                </div>
            </#if>
        </section>
    </section>

    <footer class="containerOuter">
        <#include "../footer.ftlh">
    </footer>
</body>

</html>