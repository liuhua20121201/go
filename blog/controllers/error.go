package controllers

import (
	"github.com/astaxie/beego"
)

type ErrorController struct {
    beego.Controller
}

func (c *ErrorController) Error404() {
	c.Data["webname"] = beego.AppConfig.String("webname")
	c.Data["website"] = beego.AppConfig.String("website")
	c.Data["title"] =  "错误"
    c.Data["content"] = "404"
    c.TplName = "error.tpl"
}