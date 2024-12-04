package main

import (
    "net/http"

    "github.com/gin-gonic/gin"
)

type msgstruct struct {
    MSG     string  `json:"msg"`
}

var pesan = []msgstruct{
    {MSG: "hello world"},
}

func getPesan(c *gin.Context) {
	c.Header("Content-Type", "application/json")
    c.IndentedJSON(http.StatusOK, pesan)
}

func main() {
    router := gin.Default()

	router.GET("/", getPesan)

    router.Run(":8080")
}