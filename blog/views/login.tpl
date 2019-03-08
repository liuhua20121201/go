<!DOCTYPE html>
<html class="uk-height-1-1">
<head>
    <title>登录 - {{.website}}</title>
    <meta charset="utf-8" />
    <link rel="stylesheet" href="/static/css/uikit.min.css">
    <link rel="stylesheet" href="/static/css/uikit.gradient.min.css">
    <link rel="shortcut icon" href="/static/img/favicon.ico" type="image/x-icon" />
    <script src="/static/js/jquery.min.js"></script>
    <script src="/static/js/sha1.min.js"></script>
    <script src="/static/js/uikit.min.js"></script>
    <script src="/static/js/sticky.min.js"></script>
    <script src="/static/js/vue.min.js"></script>
    <script src="/static/js/awesome.js"></script>
<script>
$(function() {
    var vmAuth = new Vue({
        el: '#vm',
        data: {
            email: '',
            passwd: ''
        },
        methods: {
            submit: function(event) {
                event.preventDefault();
                var
                    $form = $('#vm'),
                    email = this.email.trim().toLowerCase(),
                    data = {
                        email: email,
                        passwd: this.passwd==='' ? '' : CryptoJS.SHA1(email + ':' + this.passwd).toString()
                    };
                $form.postJSON('/api/login', data, function(err, result) {
                    if (result.Str) {
                        return $form.showFormError(result.Str);
                    }
                    location.assign('/');
                });
            }
        }
    });
});
</script>
</head>
<body class="uk-height-1-1">
    <div class="uk-vertical-align uk-text-center uk-height-1-1">
        <div class="uk-vertical-align-middle" style="width: 320px">
            <h1><a href="/">{{.website}}</a></h1>
            <form id="vm" v-on="submit: submit" class="uk-panel uk-panel-box uk-form">               
                <div class="uk-form-row">
                    <div class="uk-form-icon uk-width-1-1">
                        <i class="uk-icon-envelope-o"></i>
                        <input v-model="email" name="email" type="text" placeholder="电子邮箱" maxlength="50" class="uk-width-1-1 uk-form-large">
                    </div>
                </div>
                <div class="uk-form-row">
                    <div class="uk-form-icon uk-width-1-1">
                        <i class="uk-icon-lock"></i>
                        <input v-model="passwd" name="passwd" type="password" placeholder="密码" maxlength="50" class="uk-width-1-1 uk-form-large">
                    </div>
                </div>
                <div class="uk-alert uk-alert-danger uk-hidden"></div>
                <div class="uk-form-row">
                    <button type="submit" class="uk-width-1-1 uk-button uk-button-primary uk-button-large"><i class="uk-icon-sign-in"></i> 登录</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>