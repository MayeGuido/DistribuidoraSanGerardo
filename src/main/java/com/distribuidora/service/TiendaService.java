package com.distribuidora.service;

import com.distribuidora.domain.Tienda;
import com.distribuidora.repository.TiendaRepository;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class TiendaService {

    @Autowired
    private TiendaRepository tiendaRepository;

    @Transactional(readOnly = true)
    public List<Tienda> getProductos(boolean activos) {
        var lista = tiendaRepository.findAll();
        if (activos) lista.removeIf(e -> !e.isActivo());
        return lista;
    }

    @Transactional(readOnly = true)
    public Tienda getProducto(Tienda producto) {
        return tiendaRepository.findById(producto.getIdProducto()).orElse(null);
    }

    @Transactional
    public void save(Tienda producto) {
        tiendaRepository.save(producto);
    }

    @Transactional
    public boolean delete(Tienda producto) {
        try {
            tiendaRepository.delete(producto);
            tiendaRepository.flush();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public List<Tienda> buscarPorDescripcion(String descripcion) {
        return tiendaRepository.findByDescripcionContainingIgnoreCase(descripcion);
    }

    public Tienda getProductoPorId(Long id) {
        return tiendaRepository.findById(id).orElse(null);
    }
}
