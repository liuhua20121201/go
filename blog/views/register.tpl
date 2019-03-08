<!DOCTYPE html>
<html>
<head>
    <title>注册 - {{.website}}</title>
    {{template "head" .}}
<script>
function validateEmail(email) {
    var re = /^[a-z0-9\.\-\_]+\@[a-z0-9\-\_]+(\.[a-z0-9\-\_]+){1,4}$/;
    return re.test(email.toLowerCase());
}

$(function () {
    var vm = new Vue({
        el: '#vm',
        data: {
            name: '',
            email: '',
            password1: '',
            password2: ''
        },
        methods: {
            submit: function (event) {
                event.preventDefault();
                var $form = $('#vm');
                if (! this.name.trim()) {
                    return $form.showFormError('请输入名字');
                }
                if (! validateEmail(this.email.trim().toLowerCase())) {
                    return $form.showFormError('请输入正确的Email地址');
                }
                if (this.password1.length < 6) {
                    return $form.showFormError('密码长度至少为6个字符');
                }
                if (this.password1 !== this.password2) {
                    return $form.showFormError('两次输入的密码不一致');
                }
                var email = this.email.trim().toLowerCase();
                $form.postJSON('/api/register', {
                    Name: this.name.trim(),
                    Email: email,
                    Passwd: CryptoJS.SHA1(email + ':' + this.password1).toString()
                }, function (err, r) {
                    if (r.Str) {
                        return $form.showFormError(r.Str);
                    }
                    return location.assign('/');
                });
            }
        }
    });
    $('#vm').show();
});
</script>
</head>
<body>

{{template "header" .}}

    <div class="uk-container-center" style="width: 400px">
        <h1>欢迎注册！</h1>
        <form id="vm" v-on="submit: submit" class="uk-form uk-form-stacked">         
            <div class="uk-form-row">
                <label class="uk-form-label">名字:</label>
                <div class="uk-form-controls">
                    <input v-model="name" type="text" maxlength="50" placeholder="名字" class="uk-width-1-1">
                </div>
            </div>
            <div class="uk-form-row">
                <label class="uk-form-label">电子邮箱:</label>
                <div class="uk-form-controls">
                    <input v-model="email" type="text" maxlength="50" placeholder="your-name@example.com" class="uk-width-1-1">
                </div>
            </div>
            <div class="uk-form-row">
                <label class="uk-form-label">输入密码:</label>
                <div class="uk-form-controls">
                    <input v-model="password1" type="password" maxlength="50" placeholder="输入密码" class="uk-width-1-1">
                </div>
            </div>
            <div class="uk-form-row">
                <label class="uk-form-label">重复密码:</label>
                <div class="uk-form-controls">
                    <input v-model="password2" type="password" maxlength="50" placeholder="重复密码" class="uk-width-1-1">
                </div>
            </div>
            <div class="uk-alert uk-alert-danger uk-hidden"></div>
            <div class="uk-form-row">
                <button type="submit" class="uk-button uk-button-primary"><i class="uk-icon-user"></i> 注册</button>
            </div>
        </form>
    </div>

{{template "footer" .}}
</body>
</html>