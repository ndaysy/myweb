package com.example.myweb;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

@RestController
public class HelloController {

    @GetMapping("/hello")
    public String hello(){
        DateFormat bf = new SimpleDateFormat("yyyy-MM-dd E a HH:mm:ss");
        return "hello. " + bf.format(new Date());
    }
}
