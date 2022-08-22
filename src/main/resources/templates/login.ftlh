<#-- @ftlvariable name="currentUser" type="com.precub.CurrentUser" -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Log in</title>
</head>
<body>

    <h1>Log in</h1>
<form role="form" action="/login" method="post">
    <div>
        <label for="username">Username</label>
        <input type="text" name="username" id="username"/>
    </div>
    <div>
        <label for="password">Password</label>
        <input type="password" name="password" id="password"/>
    </div>
    <button type="submit">Sign in</button>
</form>

</body>
</html>