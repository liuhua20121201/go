package main

import (
	_ "github.com/liuhua20121201/go/blog/routers"
	_ "github.com/liuhua20121201/go/blog/models"
	"github.com/astaxie/beego" 
)

func main() {
	beego.Run()
}

