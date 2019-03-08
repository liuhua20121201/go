package routers

import (
	"github.com/liuhua20121201/go/blog/controllers"
	"github.com/astaxie/beego"
)


func init() {
    beego.Router("/", &controllers.MainController{}, "get:Blogs")
    beego.Router("/blog/:id([0-9]+)", &controllers.MainController{}, "get:Blog")
    beego.Router("/login", &controllers.MainController{}, "get:Login")
    beego.Router("/logout", &controllers.MainController{}, "get:Logout")
    beego.Router("/register", &controllers.MainController{}, "get:Register")
    beego.Router("/setting", &controllers.MainController{}, "get:Setting")

    beego.Router("/api/login", &controllers.MainController{}, "post:ApiLogin")
    beego.Router("/api/register", &controllers.MainController{}, "post:ApiRegister")

	beego.Router("/api/blog/:id([0-9]+)/comments", &controllers.MainController{}, "post:ApiAddComment")

    beego.ErrorController(&controllers.ErrorController{})
}
