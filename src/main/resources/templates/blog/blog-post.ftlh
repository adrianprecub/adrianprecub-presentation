<#-- @ftlvariable name="currentUser" type="com.precub.CurrentUser" -->
<!DOCTYPE html>
<html>
<#include "../header.ftlh">
<@header pageTitle="Blog" seoTitle="${seoTitle}" seoDescription="${seoDescription}"/>

<body>
<div>
    <section class="containerOuter">
        <#include "../top.ftlh">
    </section>
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

    <footer class="containerOuter">
        <#include "../footer.ftlh">
    </footer>
</div>
</body>

</html>