<#-- @ftlvariable name="currentUser" type="com.precub.CurrentUser" -->
<!DOCTYPE html>
<html>
<#include "../header.ftlh">
<@header pageTitle="Adrian Precub's Blog" seoTitle="Adrian Precub" seoDescription="Personal Blog Java Backend Software Engineering Architecture"/>

<body>
<div>
    <section class="containerOuter">
        <#include "../top.ftlh">
    </section>
    <section class="containerOuter">
        <section class="containerInner">
            <#list posts as post>
                <li><a href="/blog/${post['slug']}">${post['title']}</a></li>
            </#list>
        </section>
    </section>

    <footer class="containerOuter">
        <#include "../footer.ftlh">
    </footer>
</div>
</body>

</html>