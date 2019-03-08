<!DOCTYPE html>
<html>
<head>
	<title>日志 - {{.website}}</title>
	{{template "head" .}}
</head>
<body>

{{template "header" .}}

<div class="uk-container uk-container-center">
	<div class="uk-grid">

    <div class="uk-width-medium-3-4">
    {{range $index, $elem := .blogs}}
        <article class="uk-article">
            <h2><a href="/blog/{{ $elem.Id }}">{{ $elem.Name }}</a></h2>
            <p class="uk-article-meta">发表于{{dateformat $elem.Created "2006-01-02 15:04:05"}}</p>
            <p>{{ $elem.Summary }}</p>
            <p><a href="/blog/{{ $elem.Id }}">继续阅读 <i class="uk-icon-angle-double-right"></i></a></p>
        </article>
        <hr class="uk-article-divider">
    {{end}}

    {{if gt .paginator.PageNums 1}}
		<ul class="uk-pagination">
		    {{if .paginator.HasPrev}}
		        <li><a href="{{.paginator.PageLinkFirst}}">第一页</a></li>
		        <li><a href="{{.paginator.PageLinkPrev}}">&lt;</a></li>
		    {{else}}
		        <li class="uk-disabled"><span>第一页</span></li>
		        <li class="uk-disabled"><span>&lt;</span></li>
		    {{end}}
		    {{range $index, $page := .paginator.Pages}}
		        {{if $.paginator.IsActive .}}
		        <li class="uk-active" ><span href="{{$.paginator.PageLink $page}}">{{$page}}</span>
		        </li>
		        {{else}}
		        <li><a href="{{$.paginator.PageLink $page}}">{{$page}}</a>
		        </li>
		        {{end}}
		    {{end}}
		    {{if .paginator.HasNext}}
		        <li><a href="{{.paginator.PageLinkNext}}">&gt;</a></li>
		        <li><a href="{{.paginator.PageLinkLast}}">尾页</a></li>
		    {{else}}
		        <li class="uk-disabled"><span>&gt;</span></li>
		        <li class="uk-disabled"><span>尾页</span></li>
		    {{end}}
		</ul>
	{{end}}

    </div>

    <div class="uk-width-medium-1-4">
		{{template "right" .}}
    </div>

	</div>
</div>

{{template "footer" .}}

</body>
</html>