package com.example.visits;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import redis.clients.jedis.Jedis;

@Service
public class RedisService {

    @Autowired
    private Jedis jedis;
    public String getNumberOfVisits() {
        String visits = null;
        try {
            visits  = jedis.get("visits");
        } catch (Exception e) {
            e.printStackTrace();
            return "Internal Server Error";
        }
        if (visits == null) {
            visits = "0";
        }

        jedis.set("visits", String.valueOf(Integer.parseInt(visits) + 1));
        return "Number of visits is " + visits;
    }
}
