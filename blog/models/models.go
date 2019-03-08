package models

import (
    "reflect"
    "time"
    "github.com/astaxie/beego"
    "github.com/astaxie/beego/orm"
    _ "github.com/go-sql-driver/mysql"
)

type User struct {
    Id          int
    Email       string    `orm:"size(50)"`
    Passwd      string    `orm:"size(50)"`
    Admin       bool
    Name        string    `orm:"size(50)"`
    Image       string    `orm:"size(50);null"`
    Created     time.Time `orm:"auto_now_add;type(datetime)"`
}

type Blog struct {
    Id          int
    Name        string    `orm:"size(100)"`
    Summary     string    `orm:"size(200)"`
    Content     string    `orm:"type(text)"`
    Created     time.Time `orm:"auto_now_add;type(datetime)"`
}

type Comment struct {
    Id          int
    BlogId      int
    UserId      int
    UserName    string    `orm:"size(50)"`
    UserImage   string    `orm:"size(50);null"`
    Content     string    `orm:"type(text)"`
    Created     time.Time `orm:"auto_now_add;type(datetime)"`
}

func init() {
    orm.RegisterDataBase("default", "mysql", beego.AppConfig.String("mysqlconn"))
    orm.RegisterModel(new(User), new(Blog), new(Comment))
  
    // 自动建表
    if ok,_ := beego.AppConfig.Bool("mysqlnew"); ok {
        orm.RunSyncdb("default", false, true)

        o := orm.NewOrm()

        blog := Blog{Name: "1n", Summary: "1s", Content: "1c"}
        o.Insert(&blog)
        blog = Blog{Name: "2n", Summary: "2s", Content: "3c"}
        o.Insert(&blog)
    }
}

func (u User) IsEmpty() bool {
    return reflect.DeepEqual(u, User{})
}