{{define "header"}}    
    <nav class="uk-navbar uk-navbar-attached uk-margin-bottom">
        <div class="uk-container uk-container-center">
            <a href="/" class="uk-navbar-brand">{{.website}}</a>
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

{{end}}