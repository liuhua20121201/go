package controllers

import (
	"bytes"
	"fmt"
	"strconv"
	"strings"
	"time"
	"crypto/sha1"
	"github.com/liuhua20121201/go/blog/models"
	"github.com/astaxie/beego/orm"
)

const COOKIE_NAME = "MyBlogUser"
const COOKIE_KEY = "UseBeego"

func user2cookie(user models.User, maxAge int64) string {
	id := strconv.Itoa(user.Id)
	expires := strconv.FormatInt(time.Now().Unix() + maxAge, 10)
	s := id + "-" + user.Passwd + "-" + expires + "-" + COOKIE_KEY

    var b bytes.Buffer
    fmt.Fprintf(&b, "%x", sha1.Sum([]byte(s)))

	r := id + "-" + expires + "-" + string(b.String())
	return r
}

func cookie2user(s string) models.User {
	var user models.User 
	var strs []string
	
	strs = strings.Split(s, "-")
	if len(strs) != 3 {
		return user
	}
	id, _ := strconv.Atoi(strs[0])
	expires, _ := strconv.ParseInt(strs[1], 10, 64)
	sha := strs[2]

	if expires < time.Now().Unix() {
        return user
	}

	err := orm.NewOrm().QueryTable("User").Filter("Id", id).One(&user)
	if err == orm.ErrMultiRows {
	    fmt.Println("Returned Multi Rows Not One")
	    return user
	}
	if err == orm.ErrNoRows {
	    fmt.Println("Not row found")
	    return user
	}

    str := strs[0] + "-" + user.Passwd + "-" + strs[1] + "-" + COOKIE_KEY
	sha2 := sha1.Sum([]byte(str))
    if sha != string( sha2[:] ) {
    	return user
    }
   
    user.Passwd = "******"

	return user
}
