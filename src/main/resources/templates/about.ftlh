<#-- @ftlvariable name="currentUser" type="com.precub.CurrentUser" -->
<!DOCTYPE html>
<html lang="en">
<#include "header.ftlh">
<@header pageTitle="About" seoTitle="Adrian Precub" seoDescription="Personal Blog Java Backend Software Engineering Architecture"/>

<body>
<div>
    <section class="containerOuter">
        <#include "top.ftlh">
    </section>

    <section class="containerOuter" id="aboutMeIntro">
        <section class="containerInnerNarrow">
            <h2> </h2>
        </section>
    </section>
    <section class="containerOuter blogBodyContainer">
        <section class="containerInner blogBody">
            <p>
                I think we can all agree I am no web designer by all means. Exhibit A, this website!
                <br>
                I'm a <a href="http://github.com/adrianprecub">programmer</a> focussed on backend systems and all things related.
                <br>
                I <a href="http://twitter.com/adrianprecub">tweet</a> about software architecture, kubernetes,  coding best practices and IoT stuff.
                <br>
                I also have a <a href="https://www.youtube.com/channel/UCYM9RtHEpV8W-UH7FeRA6rg">Youtube</a> channel that has 0 subscribers.
            </p>
        </section>

    </section>

    <footer class="containerOuter">
        <#include "footer.ftlh">
    </footer>
</div>

</body>

</html>