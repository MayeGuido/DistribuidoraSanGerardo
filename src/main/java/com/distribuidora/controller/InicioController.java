
package com.distribuidora.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class InicioController {
    @GetMapping("/index")
    public String inicio() {
        return "index"; 
    }
}
