<!DOCTYPE html>
<html>
<head>
    <title>{{ .blog.Name }} - {{.website}}</title>
    {{template "head" .}}

<script>
var comment_url = '/api/blog/{{ .blog.Id }}/comments';

$(function () {
    var $form = $('#form-comment');
    $form.submit(function (e) {
        e.preventDefault();
        $form.showFormError('');
        var content = $form.find('textarea').val().trim();
        if (content==='') {
            return $form.showFormError('请输入评论内容！');
        }
        $form.postJSON(comment_url, { content: content }, function (err, result) {
            if (result.Str) {
                return $form.showFormError(result.Str);
            }
            refresh();
        });
    });
});
</script>
</head>
<body>

{{template "header" .}}

<div class="uk-container uk-container-center">
    <div class="uk-grid">

    <div class="uk-width-medium-3-4">
        <article class="uk-article">
            <h2>{{ .blog.Name }}</h2>
            <p class="uk-article-meta">发表于{{dateformat .blog.Created "2006-01-02 15:04:05"}}</p>
            <p>{{ .blog.Content }}</p>
        </article>

        <hr class="uk-article-divider">

    {{ if .user.Name }}
        <h3>发表评论</h3>

        <article class="uk-comment">
            <header class="uk-comment-header">
                <img class="uk-comment-avatar uk-border-circle" width="50" height="50" src="{{ .user.Image }}">
                <h4 class="uk-comment-title">{{ .user.Name }}</h4>
            </header>
            <div class="uk-comment-body">
                <form id="form-comment" class="uk-form">                    
                    <div class="uk-form-row">
                        <textarea rows="6" placeholder="说点什么吧" style="width:100%;resize:none;"></textarea>
                    </div>
                    <div class="uk-alert uk-alert-danger uk-hidden"></div>
                    <div class="uk-form-row">
                        <button type="submit" class="uk-button uk-button-primary"><i class="uk-icon-comment"></i> 发表评论</button>
                    </div>
                </form>
            </div>
        </article>

        <hr class="uk-article-divider">
    {{ end }}

        <h3>最新评论</h3>

        <ul class="uk-comment-list">
            {{ range $index, $elem := .comments }}
            <li>
                <article class="uk-comment">
                    <header class="uk-comment-header">
                        <img class="uk-comment-avatar uk-border-circle" width="50" height="50" src="{{ $elem.UserImage }}">
                        <h4 class="uk-comment-title">{{ $elem.UserName }}</h4>
                        <p class="uk-comment-meta">{{dateformat $elem.Created "2006-01-02 15:04:05"}}</p>
                    </header>
                    <div class="uk-comment-body">
                        {{ $elem.Content }}
                    </div>
                </article>
            </li>
            {{ else }}
            <p>还没有人评论...</p>
            {{ end }}
        </ul>

    </div>

    <div class="uk-width-medium-1-4">
        {{template "right" .}}
    </div>

    </div>
</div>

{{template "footer" .}}

</body>
</html>