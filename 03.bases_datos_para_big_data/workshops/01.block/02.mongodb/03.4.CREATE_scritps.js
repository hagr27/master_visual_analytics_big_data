// Base de Datos para Usuarios, logs.
use('mydb');

// Crear colección usuario
db.createCollection("usuario");

// Insertar usuarios
db.usuario.insertMany([
  {
    usuario_alias: "sgonzales",
    nombre: "Sara",
    apellido_1: "Gonzales",
    apellido_2: "Santisteban",
    mail: "sgonzales@example.com"
  },
  {
    usuario_alias: "nenriquez",
    nombre: "Nathaly",
    apellido_1: "Enriquez",
    apellido_2: "Freire",
    mail: "nenriquez@example.com"
  },
  {
    usuario_alias: "agerena",
    nombre: "Alejandro",
    apellido_1: "Gerena",
    apellido_2: "Ricardo",
    mail: "agerena@example.com"
  }
]);

// Consultas de ejemplo
db.usuario.find();
db.usuario.find({ usuario_alias: "sgonzales" });
