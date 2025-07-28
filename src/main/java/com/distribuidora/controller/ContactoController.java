package com.distribuidora.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class ContactoController {

    @GetMapping("/contacto")
    public String mostrarFormularioContacto() {
        return "contacto/listado"; // archivo contacto/listado.html en templates
    }

    @PostMapping("/contacto/enviar")
    public String enviarContacto(String nombre, String email, String mensaje, Model model) {
        model.addAttribute("exito", "Gracias por contactarnos, pronto responderemos.");
        return "contacto/listado";
    }
}
