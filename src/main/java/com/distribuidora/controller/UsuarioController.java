package com.distribuidora.controller;


import com.distribuidora.domain.Usuario;
import com.distribuidora.repository.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
public class UsuarioController {

    private final UsuarioRepository usuarioRepo;

    /*@GetMapping("/registro")
    public String mostrarFormularioRegistro(Model model) {
        model.addAttribute("usuario", new Usuario());
        return "registro";
    }

    @PostMapping("/registro")
    public String registrarUsuario(@ModelAttribute("usuario") Usuario usuario, Model model) {
        if (usuarioRepo.findByCorreo(usuario.getCorreo()) != null) {
            model.addAttribute("error", "Ya existe un usuario con ese correo.");
            return "registro";
        }
        usuarioRepo.save(usuario);
        return "redirect:/login";
    }*/
   
}
