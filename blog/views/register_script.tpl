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