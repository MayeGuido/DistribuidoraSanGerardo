package com.distribuidora.service;

import com.distribuidora.domain.Rol;
import com.distribuidora.domain.Usuario;
import com.distribuidora.repository.RolRepository;
import com.distribuidora.repository.UsuarioRepository;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private RolRepository rolRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public void guardarUsuarioCliente(Usuario usuario) {
        usuario.setContrasena(passwordEncoder.encode(usuario.getContrasena()));
        usuario.setActivo(true);

        Optional<Rol> rolCliente = rolRepository.findByNombre("ROLE_CLIENTE");
        rolCliente.ifPresent(rol -> usuario.setRoles(List.of(rol)));

        usuarioRepository.save(usuario);
    }

}
