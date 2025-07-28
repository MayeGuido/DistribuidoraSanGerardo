
package com.distribuidora.domain;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "rol")
public class Rol {



@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
@Column(name = "id")
private Long idRol;

private String nombre;


}