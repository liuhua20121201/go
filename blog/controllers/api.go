package controllers

import (
	"strconv"
	"strings"
	"encoding/json"
	"github.com/astaxie/beego/orm"
	"github.com/liuhua20121201/go/blog/models"
)

type Err struct {
	Str   string
}

func (c *MainController) ApiLogin() {	

	type userJson struct {
		Email   string
		Passwd  string
	}
	var uj userJson
	json.Unmarshal(c.Ctx.Input.RequestBody, &uj)     
    if uj.Email == "" {
		c.Data["json"] = &Err{"请输入电子邮箱"}
    	c.ServeJSON()
    	return
    }
    if uj.Passwd == "" {
        c.Data["json"] = &Err{"请输入密码"}
    	c.ServeJSON()
    	return
    }

	var user models.User 
	err := orm.NewOrm().QueryTable("User").Filter("Email", uj.Email).One(&user)
	if err == orm.ErrMultiRows {
        c.Data["json"] = &Err{"找不到用户"}
    	c.ServeJSON()
    	return
	}
	if err == orm.ErrNoRows {
        c.Data["json"] = &Err{"找不到用户"}
    	c.ServeJSON()
    	return
	}

	if uj.Passwd == user.Passwd {
	    c.Ctx.SetCookie(COOKIE_NAME, user2cookie(user, 3600), "3600", "/")
		user.Passwd = "******"
		c.Data["json"] = &Err{}
		c.ServeJSON()		
	}else{
        c.Data["json"] = &Err{"密码错误"}
    	c.ServeJSON()
    	return
	}
}

func (c *MainController) ApiRegister() {	
	type userJson struct {
		Name    string
		Email   string
		Passwd  string
	}
	var u userJson

	json.Unmarshal(c.Ctx.Input.RequestBody, &u)

	name := strings.TrimSpace(u.Name)
	email := strings.TrimSpace(u.Email)
	passwd := strings.TrimSpace(u.Passwd)

    if name == "" {
		c.Data["json"] = &Err{"请输入用户名"}
		c.ServeJSON()
		return
    }
    if email == "" {
		c.Data["json"] = &Err{"请输入电子邮箱"}
		c.ServeJSON()
		return
    }
    if passwd == "" {
		c.Data["json"] = &Err{"请输入密码"}
		c.ServeJSON()
		return
    }

    if exist := orm.NewOrm().QueryTable("User").Filter("Email", u.Email).Exist(); exist{
		c.Data["json"] = &Err{"电子邮箱已注册"}
		c.ServeJSON()
		return
    }

    user := models.User{Name: name, Email: email, Passwd: passwd, Admin: false, Image: "/static/img/user.png"}
    if _, err := orm.NewOrm().Insert(&user); err !=nil {
		c.Data["json"] = &Err{"注册失败"}
		c.ServeJSON()
		return
    }

    c.Ctx.SetCookie(COOKIE_NAME, user2cookie(user, 3600), "3600")
	c.Data["json"] = &Err{}
	c.ServeJSON()
}

func (c *MainController) ApiAddComment() {
	var user models.User
    s := c.Ctx.GetCookie(COOKIE_NAME)
	if s != "" {
		user = cookie2user(s)
	}
	if user == (models.User{}) {
		c.Data["json"] = &Err{"请登陆后评论"}
		c.ServeJSON()
		return
	}

	type commentJson struct {
		Content    string
	}
	var cj commentJson
	json.Unmarshal(c.Ctx.Input.RequestBody, &cj)
	content := strings.TrimSpace(cj.Content)
    if content == "" {
		c.Data["json"] = &Err{"操作失败"}
		c.ServeJSON()
		return
    }

	idString := c.Ctx.Input.Param(":id")
	id, err := strconv.Atoi(idString)
	if err != nil {
		c.Data["json"] = &Err{"操作失败"}
		c.ServeJSON()
		return
	}
	if orm.NewOrm().QueryTable("Blog").Filter("Id", id).Exist() {
		comment := models.Comment{BlogId:id, UserId:user.Id, UserName:user.Name, UserImage:user.Image, Content:content}
		if _, err := orm.NewOrm().Insert(&comment); err !=nil {
			c.Data["json"] = &Err{"操作失败"}
			c.ServeJSON()
			return
	    }
	}

	c.Data["json"] = &Err{}
	c.ServeJSON()	
}
