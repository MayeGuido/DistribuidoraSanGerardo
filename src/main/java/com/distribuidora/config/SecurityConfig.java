
package com.distribuidora.config;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@RequiredArgsConstructor
public class SecurityConfig {

     @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(auth -> auth
                .anyRequest().permitAll()  // 🔓 Todo el mundo puede entrar a todo
            )
            .csrf(csrf -> csrf.disable()) // Desactiva CSRF por si usás formularios POST
            .formLogin(form -> form.disable()) // ❌ Desactiva el login
            .httpBasic(httpBasic -> httpBasic.disable()); // ❌ Desactiva login básico

        return http.build();
    }
    @Bean
public PasswordEncoder passwordEncoder() {
    return new BCryptPasswordEncoder();
}
}
