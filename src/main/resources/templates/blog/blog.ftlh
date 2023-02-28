<!DOCTYPE html>
<html>
<#include "../header.ftlh">
<@header pageTitle="Adrian Precub's Blog" seoTitle="Adrian Precub" seoDescription="Personal Blog Java Backend Software Engineering Architecture"/>

<body>
<div>
    <section class="containerOuter">
        <#include "../top.ftlh">
    </section>
    <article>
        <#list posts as post>
            <section class="containerOuter blogHeader line-tan">
                <section class="containerInnerNarrow">
                    <h2 class="blogTitle"><a href="/blog/${post['slug']}">${post['title']}</a></h2>
                </section>
            </section>
            <section class="containerOuter blogBodyContainer">
                <section class="containerInner blogBody">
                        ${post['body']?no_esc}
                </section>
            </section>
        </#list>
    </article>

    <footer class="containerOuter">
        <#include "../footer.ftlh">
    </footer>
</div>
</body>

</html>