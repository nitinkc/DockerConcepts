package com.example.visits;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Autowired;
import redis.clients.jedis.Jedis;

@RestController
public class RedisController {

    @Autowired
    private Jedis jedis;

    @GetMapping("/")
    public String getVisits() {
        try {
            String visits = jedis.get("visits");
            if (visits == null) {
                visits = "0";
            }
            jedis.set("visits", String.valueOf(Integer.parseInt(visits) + 1));
            return "Number of visits is " + visits;
        } catch (Exception e) {
            e.printStackTrace();
            return "Internal Server Error";
        }
    }
}
