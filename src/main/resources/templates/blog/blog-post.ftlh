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
    <section class="containerOuter">
        <section class="containerInner">
            <p>
                Author: ${post.author}
                <br>
                Body: ${post.body}
            </p>
        </section>
    </section>

    <footer class="containerOuter">
        <#include "../footer.ftlh">
    </footer>
</div>
</body>

</html>