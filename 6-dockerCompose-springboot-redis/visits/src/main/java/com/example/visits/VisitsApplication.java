package com.example.visits;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import redis.clients.jedis.Jedis;

@SpringBootApplication
public class VisitsApplication {

	public static void main(String[] args) {
		SpringApplication.run(VisitsApplication.class, args);
	}
}
