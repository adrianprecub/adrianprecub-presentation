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
                    <br/>
                    I specialize in applications performance tuning and <a href="https://engineering.tomtom.com/aks-tcp-captures/" target="_blank" rel="noopener noreferrer">figuring out network problems in general</a>.
                    <br/>
                    Also gave a talk about <a href="https://www.youtube.com/watch?v=nzkZ29Ts6Co" target="_blank" rel="noopener noreferrer">networking issues at DevWorld</a>, and also a <a href="https://www.k8spodcast.nl/afleveringen/aflevering-62-the-great-reset-packet-mystery-how-tcp-analysis-saved-the-day" target="_blank" rel="noopener noreferrer">podcast interview</a> about the same topic.
                </p>
                <div class="hero-cta">
                    <a href="/projects" class="btn btn-outline">Check Out My Projects</a>
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