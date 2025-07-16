<!DOCTYPE html>
<html lang="en">
<#include "header.ftlh">
<@header pageTitle="Projects" seoTitle="Adrian Precub - Projects" seoDescription="Personal Apps and Projects by Adrian Precub"/>

<body>
<div>
    <section class="containerOuter">
        <#include "top.ftlh">
    </section>

    <section class="containerOuter" id="appsIntro">
        <section class="containerInnerNarrow">
            <h2>Projects</h2>
        </section>
    </section>
    <section class="containerOuter blogBodyContainer">
        <section class="containerInner blogBody">
            <p class="apps-intro">
                Here are some apps and projects I've built. Each project includes links to the GitHub repository.
            </p>
            
            <div class="projects-grid">
                <!-- Screen Olympics Project -->
                <div class="project-card">
                    <div class="project-header">
                        <h3>Screen Olympics</h3>
                        <div class="project-links">
                            <a href="https://github.com/adrianprecub/screen-olympics-support" target="_blank" rel="noopener noreferrer" class="btn btn-github">
                                <span class="icon">📱</span> GitHub
                            </a>
                        </div>
                    </div>
                    
                    <div class="project-details">
                        <p class="project-description">
                            A comprehensive screen time management app that helps parents create healthy digital habits for their kids through gamification and fun activities.
                        </p>
                        
                        <div class="tech-stack">
                            <span class="tech-badge swift">Swift</span>
                            <span class="tech-badge swiftui">SwiftUI</span>
                            <span class="tech-badge coredata">Core Data</span>
                            <span class="tech-badge ios">iOS 15+</span>
                        </div>
                    </div>
                </div>
                
                <!-- Personal Website Project -->
                <div class="project-card">
                    <div class="project-header">
                        <h3>Personal Website</h3>
                        <div class="project-links">
                            <a href="https://github.com/adrianprecub/adrianprecub-presentation" target="_blank" rel="noopener noreferrer" class="btn btn-github">
                                <span class="icon">🌐</span> GitHub
                            </a>
                        </div>
                    </div>
                    
                    <div class="project-details">
                        <p class="project-description">
                            A modern, responsive personal website built with Spring Boot, featuring a blog component powered by ButterCMS and containerized deployment.
                        </p>
                        
                        <div class="tech-stack">
                            <span class="tech-badge java">Java</span>
                            <span class="tech-badge spring">Spring Boot</span>
                            <span class="tech-badge freemarker">FreeMarker</span>
                            <span class="tech-badge docker">Docker</span>
                            <span class="tech-badge buttercms">ButterCMS</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="more-projects-section">
                <h3>More Projects Coming Soon</h3>
                <p>I'm currently working on several exciting projects. Check back soon to see what's in the pipeline!</p>
                <div class="github-cta">
                    <a href="https://github.com/adrianprecub" target="_blank" rel="noopener noreferrer" class="btn btn-outline">
                        <span class="icon">💻</span> View All Projects on GitHub
                    </a>
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