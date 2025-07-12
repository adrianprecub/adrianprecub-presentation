<!DOCTYPE html>
<html lang="en">
<#include "header.ftlh">
<@header pageTitle="Apps" seoTitle="Adrian Precub - Apps" seoDescription="Personal Apps and Projects by Adrian Precub"/>

<body>
<div>
    <section class="containerOuter">
        <#include "top.ftlh">
    </section>

    <section class="containerOuter" id="appsIntro">
        <section class="containerInnerNarrow">
            <h2>Apps</h2>
        </section>
    </section>
    <section class="containerOuter blogBodyContainer">
        <section class="containerInner blogBody">
            <p>
                Here are some apps and projects I've built:
            </p>
            
            <div class="apps-grid">
                <div class="app-card">
                    <h3><a href="https://adrianprecub.github.io/screen-olympics-support/" target="_blank" rel="noopener noreferrer">Screen Support</a></h3>
                    <p class="app-description">
                        Support page for Screen Olympics - a screen time management app for kids. Helps parents create healthy digital habits through gamification and fun activities.
                    </p>
                    <div class="app-meta">
                        <span class="app-category">iOS App</span>
                        <span class="app-status">Live</span>
                    </div>
                </div>
            </div>
            
            <div class="more-apps-section">
                <h3>More Apps Coming Soon</h3>
                <p>I'm currently working on several exciting projects. Check back soon to see what's in the pipeline!</p>
                <div class="coming-soon-placeholder">
                    <div class="placeholder-card">
                        <div class="placeholder-content">
                            <h4>New Project</h4>
                            <p>Something awesome is being built...</p>
                            <span class="status-badge">In Development</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>

    </section>

    <footer class="containerOuter">
        <#include "footer.ftlh">
    </footer>
</div>

</body>

</html>