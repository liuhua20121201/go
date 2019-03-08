package controllers

import (
	"github.com/astaxie/beego"
)

type ErrorController struct {
    beego.Controller
}

func (c *ErrorController) Error404() {
    c.Data["content"] = "404"
    c.TplName = "error.tpl"
}