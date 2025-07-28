package com.distribuidora.controller;

import com.distribuidora.domain.Tienda; // o Producto
import com.distribuidora.service.TiendaService; // o ProductoService
import com.distribuidora.service.RecetasService;
import com.distribuidora.service.FirebaseStorageService;

import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/tienda")
public class TiendaController {

    @Autowired
    private TiendaService tiendaService;

    @Autowired
    private RecetasService recetasService;

    @Autowired
    private FirebaseStorageService firebaseStorageService;

    @Autowired
    private MessageSource messageSource;

    @GetMapping("/listado")
    public String listado(Model model) {
        var lista = tiendaService.getProductos(false);
        model.addAttribute("productos", lista);
        var categorias = recetasService.getRecetas(true);
        model.addAttribute("categorias", categorias);
        model.addAttribute("totalProductos", lista.size());
        return "/tienda/listado";
    }

    @PostMapping("/guardar")
    public String guardar(Tienda producto,
                          @RequestParam("imagenFile") MultipartFile imagenFile,
                          RedirectAttributes redirectAttrs) {
        if (!imagenFile.isEmpty()) {
            tiendaService.save(producto);
            String rutaImagen = firebaseStorageService.cargaImagen(imagenFile, "tienda", producto.getIdProducto());
            producto.setRutaImagen(rutaImagen);
        }
        tiendaService.save(producto);
        redirectAttrs.addFlashAttribute("todoOk", messageSource.getMessage("mensaje.actualizado", null, Locale.getDefault()));
        return "redirect:/tienda/listado";
    }

    @PostMapping("/eliminar")
    public String eliminar(Tienda producto, RedirectAttributes redirectAttrs) {
        producto = tiendaService.getProducto(producto);
        if (producto == null) {
            redirectAttrs.addFlashAttribute("error", messageSource.getMessage("producto.error01", null, Locale.getDefault()));
        } else if (tiendaService.delete(producto)) {
            redirectAttrs.addFlashAttribute("todoOk", messageSource.getMessage("mensaje.eliminado", null, Locale.getDefault()));
        } else {
            redirectAttrs.addFlashAttribute("error", messageSource.getMessage("producto.error03", null, Locale.getDefault()));
        }
        return "redirect:/tienda/listado";
    }

    @PostMapping("/modificar")
    public String modificar(Tienda producto, Model model) {
        producto = tiendaService.getProducto(producto);
        var categorias = recetasService.getRecetas(true);
        model.addAttribute("categorias", categorias);
        model.addAttribute("producto", producto);
        return "/tienda/modifica";
    }

    @GetMapping("/buscar")
    public String buscar(@RequestParam("nombre") String descripcion, Model model) {
        List<Tienda> productos = tiendaService.buscarPorDescripcion(descripcion);
        model.addAttribute("productos", productos);
        return "/tienda/listado";
    }

    @GetMapping("/detalle/{id}")
    public String detalleProducto(@PathVariable("id") Long id, Model model) {
        Tienda producto = tiendaService.getProductoPorId(id);
        model.addAttribute("producto", producto);
        return "/tienda/detalle";
    }
}
