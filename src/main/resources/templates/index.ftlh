<!DOCTYPE html>
<html>
<#include "header.ftlh">
<@header pageTitle="Home" seoTitle="Adrian Precub" seoDescription="Personal Blog Java Backend Software Engineering Architecture"/>

<body>
    <#include "top.ftlh">
    <section class="hero-section" id="intro">
        <div class="hero-content">
            <div class="hero-text">
                <h1 class="hero-title">Software Architect</h1>
                <p class="hero-subtitle">Passionate about building scalable and secure systems.</p>
                <p class="hero-description">
                    I enjoy taking stuff apart to see how they work. Putting them back together is also fun, 
                    especially when you have parts and screws remaining on the side but the thing somehow <strong>still works</strong>.
                </p>
                <div class="hero-cta">
                    <a href="/about" class="btn btn-primary">Learn More About Me</a>
                    <a href="/apps" class="btn btn-outline">Check Out My Apps</a>
                </div>
            </div>
            <div class="hero-image">
                <img src="/images/adi-banner.png" alt="Adrian Precub" class="profile-image">
            </div>
        </div>
    </section>

    <#include "footer.ftlh">

</body>

</html>