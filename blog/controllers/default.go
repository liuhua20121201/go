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

	c.Data["website"] = beego.AppConfig.String("website")
	c.Data["blogs"] = blogs
	c.TplName = "blogs.tpl"
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

	c.Data["website"] = beego.AppConfig.String("website")
	c.Data["blog"] = blog
	c.Data["comments"] = comments
	c.TplName = "blog.tpl"
}

func (c *MainController) Login() {	
	c.Data["website"] = beego.AppConfig.String("website")
	c.TplName = "login.tpl"
}

func (c *MainController) Logout() {
    c.Ctx.SetCookie(COOKIE_NAME, "")
    c.Ctx.Redirect(302, "/")
}

func (c *MainController) Register() {	
	c.Data["website"] = beego.AppConfig.String("website")
	c.TplName = "register.tpl"
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

	if user.Admin {
		c.Data["website"] = beego.AppConfig.String("website")
		c.TplName = "manage.tpl"
	}else{
		c.Data["website"] = beego.AppConfig.String("website")
		c.TplName = "setting.tpl"
	}		
}