package com.distribuidora.repository;

import com.distribuidora.domain.Tienda;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TiendaRepository extends JpaRepository<Tienda, Long> {
    List<Tienda> findByDescripcionContainingIgnoreCase(String descripcion);
}
