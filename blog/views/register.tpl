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
            
            <div class="uk-form-row">
                <button type="submit" class="uk-button uk-button-primary"><i class="uk-icon-user"></i> 注册</button>
            </div>
            <div class="uk-alert uk-alert-danger uk-hidden"></div>
        </form>
    </div>