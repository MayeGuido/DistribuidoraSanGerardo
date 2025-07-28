
package com.distribuidora.service;

import com.distribuidora.domain.Rol;
import com.distribuidora.domain.Usuario;
import com.distribuidora.repository.UsuarioRepository;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class UsuarioDetailsService implements UserDetailsService {

    private final UsuarioRepository usuarioRepository;

    public UsuarioDetailsService(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    public UserDetails loadUserByUsername(String correo) throws UsernameNotFoundException {
    Usuario usuario = usuarioRepository.findByCorreo(correo);
    if (usuario == null) {
        throw new UsernameNotFoundException("Usuario no encontrado");
    }
    
    // Obtener los nombres de roles
    String[] roles = usuario.getRoles().stream()
        .map(Rol::getNombre)      // suponiendo que Rol tiene getNombre()
        .filter(nombre -> nombre != null && !nombre.isEmpty())
        .toArray(String[]::new);

    if (roles.length == 0) {
        throw new UsernameNotFoundException("El usuario no tiene roles asignados");
    }

    return User.builder()
        .username(usuario.getCorreo())
        .password(usuario.getContrasena())
        .roles(roles)
        .build();
}
}