package com.distribuidora.controller;

import com.distribuidora.domain.Recetas;
import com.distribuidora.service.RecetasService;
import com.distribuidora.service.FirebaseStorageService;
import java.util.Locale;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/recetas")
public class RecetasController {

    @Autowired
    private RecetasService recetasService;

    @Autowired
    private FirebaseStorageService firebaseStorageService;

    @Autowired
    private MessageSource messageSource;

    @GetMapping("/listado")
    public String listado(Model model) {
        var lista = recetasService.getRecetas(false);
        model.addAttribute("recetas", lista);
        model.addAttribute("totalRecetas", lista.size());
        return "/recetas/listado";
    }

    @PostMapping("/guardar")
    public String guardar(Recetas receta,
                          @RequestParam("imagenFile") MultipartFile imagenFile,
                          RedirectAttributes redirectAttrs) {

        if (!imagenFile.isEmpty()) {
            recetasService.save(receta);
            String rutaImagen = firebaseStorageService.cargaImagen(
                    imagenFile, "recetas", receta.getIdRecetas());
            receta.setRutaImagen(rutaImagen);
        }

        recetasService.save(receta);
        redirectAttrs.addFlashAttribute("todoOk",
                messageSource.getMessage("mensaje.actualizado", null, Locale.getDefault()));

        return "redirect:/recetas/listado";
    }

    @PostMapping("/eliminar")
    public String eliminar(Recetas receta, RedirectAttributes redirectAttributes) {
        receta = recetasService.getReceta(receta);
        if (receta == null) {
            redirectAttributes.addFlashAttribute("error",
                    messageSource.getMessage("recetas.error01", null, Locale.getDefault()));
        } else if (false) {
            redirectAttributes.addFlashAttribute("error",
                    messageSource.getMessage("recetas.error02", null, Locale.getDefault()));
        } else if (recetasService.delete(receta)) {
            redirectAttributes.addFlashAttribute("todoOk",
                    messageSource.getMessage("mensaje.eliminado", null, Locale.getDefault()));
        } else {
            redirectAttributes.addFlashAttribute("error",
                    messageSource.getMessage("recetas.error03", null, Locale.getDefault()));
        }
        return "redirect:/recetas/listado";
    }

    @PostMapping("/modificar")
    public String modificar(Recetas receta, Model model) {
        receta = recetasService.getReceta(receta);
        model.addAttribute("receta", receta);
       
     return "/recetas/modifica";
    }
}