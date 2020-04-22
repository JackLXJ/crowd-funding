package com.muzimz.crowd;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.muzimz.crowd.mapper")
public class MysqlApplicaton {
    public static void main(String[] args) {
        SpringApplication.run(MysqlApplicaton.class, args);
    }
}
