package com.example.visits;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import redis.clients.jedis.Jedis;

@Configuration
public class RedisConfig {

    @Value("${redis.server.hostname}")
    private String redisServerHostname;
    @Value("${redis.server.port}")
    private int redisServerPort;

    @Bean
    public Jedis jedis() {
        // For Docker, the name of the server is from the docker compose service naem
        return new Jedis(redisServerHostname, redisServerPort);//"redis-server", 6379

        // Localhost from laptop
        //return new Jedis("localhost", 6379);
    }
}
