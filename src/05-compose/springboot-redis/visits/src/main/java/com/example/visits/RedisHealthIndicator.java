package com.example.visits;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.actuate.health.Health;
import org.springframework.boot.actuate.health.HealthIndicator;
import org.springframework.stereotype.Component;
import redis.clients.jedis.Jedis;

@Component("redis-health")
@Slf4j
public class RedisHealthIndicator implements HealthIndicator {
    @Value("${redis.server.hostname}")
    private String redisServerHostname;
    @Value("${redis.server.port}")
    private int redisServerPort;

    @Override
    public Health health() {
        try (Jedis jedis = new Jedis(redisServerHostname, redisServerPort)) { // Update with your Redis host and port
            // Attempt to connect to Redis
            log.info("Ping redis-server on {} :: {}",redisServerPort, jedis.ping());
            return Health.up()
                    .withDetail("status", "OK")
                    .withDetail("message", "Redis connection successful")
                    .build(); // Redis connection successful
        } catch (Exception e) {
            return Health.down().withDetail("error", e.getMessage()).build(); // Redis connection failed
        }
    }
}
