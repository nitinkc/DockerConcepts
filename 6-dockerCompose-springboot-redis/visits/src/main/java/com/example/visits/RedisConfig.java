package com.example.visits;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import redis.clients.jedis.Jedis;

@Configuration
public class RedisConfig {

    @Bean
    public Jedis jedis() {
        // For Docker, the name of the server is from the docker compose service naem
        return new Jedis("redis-server", 6379);

        // Localhost from laptop
        //return new Jedis("localhost", 6379);
    }
}
