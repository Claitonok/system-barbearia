package com.barbearia.system.controller;

import com.barbearia.system.model.UsuarioApiSecurity;
import com.barbearia.system.service.UsuarioApiSecurityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth/config") // Rota específica para configuração de segurança
public class UsuarioApiSecurityController {

    @Autowired
    private UsuarioApiSecurityService service;

    @PostMapping("/setup-user")
    public ResponseEntity<UsuarioApiSecurity> criarUsuarioAcesso(@RequestBody UsuarioApiSecurity usuario) {
        try {
            UsuarioApiSecurity novoUsuario = service.criarUsuario(usuario);
            return new ResponseEntity<>(novoUsuario, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}