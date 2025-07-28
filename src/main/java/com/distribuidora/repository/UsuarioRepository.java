
package com.distribuidora.repository;

import com.distribuidora.domain.Usuario;
import org.springframework.data.repository.CrudRepository;

public interface UsuarioRepository extends CrudRepository<Usuario, Long> {
    Usuario findByCorreo(String correo);
}

