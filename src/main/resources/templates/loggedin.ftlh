<#if !currentUser??>
    <br/>
    <a href="/login">Login</a>
</#if>
<#if currentUser??>
    <p>successful login</p>
</#if>