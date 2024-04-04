package com.example.visits;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.actuate.health.Health;
import org.springframework.boot.actuate.health.HealthIndicator;
import org.springframework.stereotype.Component;
import redis.clients.jedis.Jedis;

@Component
@Slf4j
public class RedisHealthIndicator implements HealthIndicator {
    @Override
    public Health health() {
        try (Jedis jedis = new Jedis("redis-server", 6379)) { // Update with your Redis host and port
            // Attempt to connect to Redis
            log.info("Ping redis-server on 6379 :: {}",jedis.ping());
            return Health.up()
                    .withDetail("status", "OK")
                    .withDetail("message", "Redis connection successful")
                    .build(); // Redis connection successful
        } catch (Exception e) {
            return Health.down().withDetail("error", e.getMessage()).build(); // Redis connection failed
        }
    }
}
