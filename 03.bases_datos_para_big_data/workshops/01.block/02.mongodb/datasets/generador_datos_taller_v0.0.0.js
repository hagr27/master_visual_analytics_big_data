use("TallerInsert");

// Limpieza previa
db.library_1.drop();
db.library_2.drop();
db.library_3.drop();
db.library_4.drop();
db.library_5.drop();
db.books.drop();

// Ejemplo 1 – Array simple con campos básicos y arrays planos
db.library_1.insertMany([
   { item: "journal", qty: 25, tags: ["blank", "red"], dim_cm: [14, 21] },
   { item: "notebook", qty: 50, tags: ["red", "blank"], dim_cm: [14, 21] },
   { item: "paper", qty: 100, tags: ["red", "blank", "plain"], dim_cm: [14, 21] },
   { item: "planner", qty: 75, tags: ["blank", "red"], dim_cm: [22.85, 30] },
   { item: "postcard", qty: 45, tags: ["blue"], dim_cm: [10, 15.25] }
]);

// Ejemplo 2 – Array de objetos anidados (instock con warehouse y qty)
db.library_2.insertMany([
   { item: "journal", instock: [ { warehouse: "A", qty: 5 }, { warehouse: "C", qty: 15 } ] },
   { item: "notebook", instock: [ { warehouse: "C", qty: 5 } ] },
   { item: "paper", instock: [ { warehouse: "A", qty: 60 }, { warehouse: "B", qty: 15 } ] },
   { item: "planner", instock: [ { warehouse: "A", qty: 40 }, { warehouse: "B", qty: 5 } ] },
   { item: "postcard", instock: [ { warehouse: "B", qty: 15 }, { warehouse: "C", qty: 35 } ] }
]);

// Ejemplo 3 – Objeto anidado con múltiples campos y status
db.library_3.insertMany([
   { item: "journal", qty: 25, size: { h: 14, w: 21, uom: "cm" }, status: "A" },
   { item: "notebook", qty: 50, size: { h: 8.5, w: 11, uom: "in" }, status: "A" },
   { item: "paper", qty: 100, size: { h: 8.5, w: 11, uom: "in" }, status: "D" },
   { item: "planner", qty: 75, size: { h: 22.85, w: 30, uom: "cm" }, status: "D" },
   { item: "postcard", qty: 45, size: { h: 10, w: 15.25, uom: "cm" }, status: "A" }
]);

// Ejemplo 4 – Mezcla de objeto anidado y array de objetos
db.library_4.insertMany([
   { item: "journal", status: "A", size: { h: 14, w: 21, uom: "cm" }, instock: [ { warehouse: "A", qty: 5 } ] },
   { item: "notebook", status: "A", size: { h: 8.5, w: 11, uom: "in" }, instock: [ { warehouse: "C", qty: 5 } ] },
   { item: "paper", status: "D", size: { h: 8.5, w: 11, uom: "in" }, instock: [ { warehouse: "A", qty: 60 } ] },
   { item: "planner", status: "D", size: { h: 22.85, w: 30, uom: "cm" }, instock: [ { warehouse: "A", qty: 40 } ] },
   { item: "postcard", status: "A", size: { h: 10, w: 15.25, uom: "cm" }, instock: [ { warehouse: "B", qty: 15 }, { warehouse: "C", qty: 35 } ] }
]);

// Ejemplo 5 – Lote de productos más variado, con múltiples combinaciones
db.library_5.insertMany([
   { item: "canvas", qty: 100, size: { h: 28, w: 35.5, uom: "cm" }, status: "A" },
   { item: "journal", qty: 25, size: { h: 14, w: 21, uom: "cm" }, status: "A" },
   { item: "mat", qty: 85, size: { h: 27.9, w: 35.5, uom: "cm" }, status: "A" },
   { item: "mousepad", qty: 25, size: { h: 19, w: 22.85, uom: "cm" }, status: "P" },
   { item: "notebook", qty: 50, size: { h: 8.5, w: 11, uom: "in" }, status: "P" },
   { item: "paper", qty: 100, size: { h: 8.5, w: 11, uom: "in" }, status: "D" },
   { item: "planner", qty: 75, size: { h: 22.85, w: 30, uom: "cm" }, status: "D" },
   { item: "postcard", qty: 45, size: { h: 10, w: 15.25, uom: "cm" }, status: "A" },
   { item: "sketchbook", qty: 80, size: { h: 14, w: 21, uom: "cm" }, status: "A" },
   { item: "sketch pad", qty: 95, size: { h: 22.85, w: 30.5, uom: "cm" }, status: "A" }]);

// Ejemplo 6 – Estructura para libros con ratings y arrays de objetos anidados
db.books.insertMany([
  {
    _id: 1,
    item: "TBD",
    stock: 0,
    info: { publisher: "1111", pages: 430 },
    tags: [ "technology", "computer" ],
    ratings: [ { by: "ijk", rating: 4 }, { by: "lmn", rating: 5 } ],
    reorder: false
  },
  {
    _id: 2,
    item: "XYZ123",
    stock: 15,
    info: { publisher: "5555", pages: 150 },
    tags: [],
    ratings: [ { by: "xyz", rating: 5 } ],
    reorder: false
  }
]);
