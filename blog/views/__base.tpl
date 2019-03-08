<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>{{.title}} - {{.webname}}</title>
	<link rel="shortcut icon" href="/static/img/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="/static/css/uikit.gradient.min.css">
	<link rel="stylesheet" href="/static/css/awesome.css" />
	<script src="/static/js/jquery.min.js"></script>
	<script src="/static/js/sha1.min.js"></script>
	<script src="/static/js/uikit.min.js"></script>
	<script src="/static/js/sticky.min.js"></script>
	<script src="/static/js/vue.min.js"></script>
	<script src="/static/js/awesome.js"></script>
	{{.scriptTpl}}
</head>
<body>

<nav class="uk-navbar uk-navbar-attached uk-margin-bottom">
    <div class="uk-container uk-container-center">
        <a href="/" class="uk-navbar-brand">{{.webname}}</a>
        <ul class="uk-navbar-nav">
            <li><a href="/"><i class="uk-icon-home"></i> 日志</a></li>
            <li><a href=""><i class="uk-icon-book"></i> 待定</a></li>
            <li><a href=""><i class="uk-icon-code"></i> 待定</a></li>
        </ul>
        <div class="uk-navbar-flip">
            <ul class="uk-navbar-nav">
            {{if .user.Name }}
                <li><a href="/setting" target="_blank"><i class="uk-icon-user"></i> {{.user.Name}}</a></li>
                <li><a href="/logout"><i class="uk-icon-sign-out"></i> 退出</a></li>
            {{else}}
                <li><a href="/login"><i class="uk-icon-sign-in"></i> 登陆</a></li>
                <li><a href="/register"><i class="uk-icon-edit"></i> 注册</a></li>
            {{end}}

            </ul>
        </div>
    </div>
</nav>

<div class="uk-container uk-container-center">
	<div class="uk-grid">
		{{.LayoutContent }}
	</div>
</div>

<div class="uk-margin-large-top" style="background-color:#eee; border-top:1px solid #ccc;">
    <div class="uk-container uk-container-center uk-text-center">
        <div class="uk-panel uk-margin-top uk-margin-bottom">
            <p>Powered by "{{.webname}}". Copyright &copy; 2019.</p>
            <p>{{.website}}. All rights reserved.</p>
            <a target="_blank" href="http://www.w3.org/TR/html5/"><i class="uk-icon-html5" style="font-size:32px; color: #444;"></i></a>
        </div>

    </div>
</div>

</body>
</html>