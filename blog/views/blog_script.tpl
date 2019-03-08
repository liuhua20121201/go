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