package com.distribuidora.repository;

import com.distribuidora.domain.Recetas;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RecetasRepository extends JpaRepository<Recetas, Long> {

}
