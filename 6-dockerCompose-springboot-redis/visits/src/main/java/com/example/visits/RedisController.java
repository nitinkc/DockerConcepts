package com.example.visits;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Autowired;
import redis.clients.jedis.Jedis;

@RestController
public class RedisController {

    @Autowired
    private RedisService redisService;

    @GetMapping("/")
    public String getVisits() {
        return redisService.getNumberOfVisits();
    }
}