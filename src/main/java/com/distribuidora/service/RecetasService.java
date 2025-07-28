package com.distribuidora.service;

import com.distribuidora.domain.Recetas;
import com.distribuidora.repository.RecetasRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class RecetasService {

    @Autowired
    private RecetasRepository recetasRepository;

    @Transactional(readOnly = true)
    public List<Recetas> getRecetas(boolean activos) {
        var lista = recetasRepository.findAll();
        if (activos) {
            lista.removeIf(e -> !e.isActivo());
        }
        return lista;
    }

    @Transactional(readOnly = true)
    public Recetas getReceta(Recetas receta) {
        return recetasRepository.findById(receta.getIdRecetas()).orElse(null);
    }

    @Transactional
    public void save(Recetas receta) {
        recetasRepository.save(receta);
    }

    @Transactional
    public boolean delete(Recetas receta) {
        try {
            recetasRepository.delete(receta);
            recetasRepository.flush();
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
