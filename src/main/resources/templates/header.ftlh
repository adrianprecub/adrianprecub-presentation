<#macro header pageTitle seoTitle seoDescription>
    <head>
        <title>${pageTitle}</title>
        <meta charset="UTF-8">

        <title>${seoTitle}"></title>
        <meta name="description" content="${seoDescription}"/>
        <meta name="author" content="Adrian Precub">
        <meta name="copyright" content="Adrian Precub">
        <meta name="keywords" content="Java JVM Software Engineering Architecture Backend Developer">

        <!-- Mobile Metas -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        
        <!-- Preload critical resources -->
        <link rel="preload" href="/css/style.css?v=2" as="style">
        
        <!-- Stylesheets -->
        <link type="text/css" href="/css/style.css?v=2" rel="stylesheet">
        
        <!-- JavaScript -->
        <script src="/js/navigation.js" defer></script>

        <!-- Google tag (gtag.js) -->
        <script async src="https://www.googletagmanager.com/gtag/js?id=G-1TYT3JN04D"></script>
        <script>
            window.dataLayer = window.dataLayer || [];
            function gtag(){dataLayer.push(arguments);}
            gtag('js', new Date());

            gtag('config', 'G-1TYT3JN04D');
        </script>
    </head>
</#macro>