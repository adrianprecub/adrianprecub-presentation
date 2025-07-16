<#-- @ftlvariable name="currentUser" type="com.precub.CurrentUser" -->
<!DOCTYPE html>
<html>
<#include "../header.ftlh">
<@header pageTitle="Blog" seoTitle="${seoTitle}" seoDescription="${seoDescription}"/>

<body>
    <#include "../top.ftlh">
    
    <section class="containerOuter blogBodyContainer">
        <section class="containerInner blogBody">
            <article class="blog-post-article">
                <div class="post-article-header">
                    <nav class="breadcrumb">
                        <a href="/blog" class="breadcrumb-link">← Back to Blog</a>
                    </nav>
                    
                    <h1 class="post-article-title">${post['title']}</h1>
                    
                    <div class="post-article-meta">
                        <span class="post-article-date">${post['published']?date}</span>
                        <#if post['tags']??>
                            <div class="post-article-tags">
                                <#list post['tags'] as tag>
                                    <span class="tag">${tag['name']}</span>
                                </#list>
                            </div>
                        </#if>
                    </div>
                </div>
                
                <div class="post-article-content">
                    ${post['body']?no_esc}
                </div>
                
                <div class="post-article-footer">
                    <div class="post-navigation">
                        <a href="/blog" class="btn btn-outline">
                            <span class="icon">📝</span> Back to All Posts
                        </a>
                    </div>
                </div>
            </article>
        </section>
    </section>

    <footer class="containerOuter">
        <#include "../footer.ftlh">
    </footer>
</body>

</html>