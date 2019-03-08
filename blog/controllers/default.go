package controllers

import (
	"fmt"
	"strconv"
	"github.com/liuhua20121201/go/blog/models"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
)

type MainController struct {
	beego.Controller
}

func (c *MainController) CheckUser() {	
	var user models.User
    s := c.Ctx.GetCookie(COOKIE_NAME)
	if s != "" {
		user = cookie2user(s)
	}
	c.Data["user"] = user
}

func (c *MainController) Blogs() {	
	c.CheckUser()
	
	var blogs []*models.Blog
	num, _ := orm.NewOrm().QueryTable("Blog").All(&blogs)
	c.SetPaginator(10, num)
	c.Data["blogs"] = blogs

	c.Data["webname"] = beego.AppConfig.String("webname")
	c.Data["website"] = beego.AppConfig.String("website")
	c.Layout = "__base.tpl"
	c.LayoutSections = make(map[string]string)

	c.Data["title"] =  "欢迎"
    c.TplName = "blogs.tpl"
    c.LayoutSections["scriptTpl"] = "blogs_script.tpl"
}

func (c *MainController) Blog() {
	c.CheckUser()

	idString := c.Ctx.Input.Param(":id")
	id, err := strconv.Atoi(idString)
	if err != nil {
		fmt.Println("error: /blog/id")
		return
	}

	blog := models.Blog{Id: id}
	o := orm.NewOrm()
	
	if err := o.Read(&blog); err == orm.ErrNoRows {
	    c.Abort("404")
	} else if err == orm.ErrMissPK {
	    c.Abort("404")
	}

	var comments []*models.Comment
	o.QueryTable("Comment").Filter("BlogId", blog.Id).OrderBy("-Id").All(&comments)

	c.Data["blog"] = blog
	c.Data["comments"] = comments

	c.Data["webname"] = beego.AppConfig.String("webname")
	c.Data["website"] = beego.AppConfig.String("website")
	c.Layout = "__base.tpl"
	c.LayoutSections = make(map[string]string)

	c.Data["title"] =  "日志"
    c.TplName = "blog.tpl"
    c.LayoutSections["scriptTpl"] = "blog_script.tpl"
}

func (c *MainController) Login() {	
	c.Data["webname"] = beego.AppConfig.String("webname")
	c.Data["website"] = beego.AppConfig.String("website")
	c.Data["title"] =  "登陆"
	c.TplName = "login.tpl"
}

func (c *MainController) Logout() {
    c.Ctx.SetCookie(COOKIE_NAME, "")
    c.Ctx.Redirect(302, "/")
}

func (c *MainController) Register() {	
	c.Data["webname"] = beego.AppConfig.String("webname")
	c.Data["website"] = beego.AppConfig.String("website")
	c.Layout = "__base.tpl"
	c.LayoutSections = make(map[string]string)

	c.Data["title"] =  "注册"
    c.TplName = "register.tpl"
    c.LayoutSections["scriptTpl"] = "register_script.tpl"
}

func (c *MainController) Setting() {
	var user models.User
    s := c.Ctx.GetCookie(COOKIE_NAME)
	if s != "" {
		user = cookie2user(s)
	}
	c.Data["user"] = user
	if user == (models.User{}) {
		c.Ctx.Redirect(302, "/login")
	}

	c.Data["webname"] = beego.AppConfig.String("webname")
	c.Data["website"] = beego.AppConfig.String("website")
	c.Layout = "__base.tpl"
	c.LayoutSections = make(map[string]string)

	if user.Admin {
		c.Data["title"] =  "管理"
		c.TplName = "manage.tpl"
		c.LayoutSections["scriptTpl"] = "manage_script.tpl"
	}else{
		c.Data["title"] =  "设置"
		c.TplName = "setting.tpl"
		c.LayoutSections["scriptTpl"] = "setting_script.tpl"
	}		
}