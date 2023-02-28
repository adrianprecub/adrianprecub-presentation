package com.precub;

import com.buttercms.ButterCMSClient;
import com.buttercms.IButterCMSClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class CustomWebConfig {

    @Value("${buttercms.key}")
    private String butterCMSKey;

    @Bean
    public IButterCMSClient butterCMSClient() {
        return new ButterCMSClient(butterCMSKey, false);
    }

}