use("TallerInsert");

// Utilidades para generar datos aleatorios
function randomItem() {
  const items = ["journal", "notebook", "paper", "planner", "postcard", "canvas", "sketchbook", "mat", "sketch pad", "mousepad"];
  return items[Math.floor(Math.random() * items.length)];
}

function randomTags() {
  const tags = ["red", "blank", "plain", "blue", "green"];
  return Array.from(new Set([tags[Math.floor(Math.random() * tags.length)], tags[Math.floor(Math.random() * tags.length)]]));
}

function randomDim() {
  return [parseFloat((Math.random() * 30 + 10).toFixed(2)), parseFloat((Math.random() * 30 + 10).toFixed(2))];
}

function randomSize() {
  return {
    h: parseFloat((Math.random() * 30).toFixed(2)),
    w: parseFloat((Math.random() * 30).toFixed(2)),
    uom: Math.random() > 0.5 ? "cm" : "in"
  };
}

function randomStatus() {
  const statuses = ["A", "D", "P"];
  return statuses[Math.floor(Math.random() * statuses.length)];
}

function randomWarehouse() {
  const letters = ["A", "B", "C"];
  return letters[Math.floor(Math.random() * letters.length)];
}

// Función para library_1 (tags + dim_cm)
function populateLibrary1(coleccion, num) {
  const docs = [];
  for (let i = 0; i < num; i++) {
    docs.push({
      item: randomItem(),
      qty: Math.floor(Math.random() * 100 + 1),
      tags: randomTags(),
      dim_cm: randomDim()
    });
  }
  db.getCollection(coleccion).insertMany(docs);
}

//Función para library_2 (instock con array de objetos)
function populateLibrary2(coleccion, num) {
  const docs = [];
  for (let i = 0; i < num; i++) {
    const stockCount = Math.floor(Math.random() * 3 + 1);
    const instock = [];
    for (let j = 0; j < stockCount; j++) {
      instock.push({
        warehouse: randomWarehouse(),
        qty: Math.floor(Math.random() * 100 + 1)
      });
    }
    docs.push({
      item: randomItem(),
      instock: instock
    });
  }
  db.getCollection(coleccion).insertMany(docs);
}

// Función para library_3 (size como objeto anidado)
function populateLibrary3(coleccion, num) {
  const docs = [];
  for (let i = 0; i < num; i++) {
    docs.push({
      item: randomItem(),
      qty: Math.floor(Math.random() * 100 + 1),
      size: randomSize(),
      status: randomStatus()
    });
  }
  db.getCollection(coleccion).insertMany(docs);
}

//Función para library_4 (size + instock + status)
function populateLibrary4(coleccion, num) {
  const docs = [];
  for (let i = 0; i < num; i++) {
    docs.push({
      item: randomItem(),
      status: randomStatus(),
      size: randomSize(),
      instock: [
        { warehouse: randomWarehouse(), qty: Math.floor(Math.random() * 100 + 1) }
      ]
    });
  }
  db.getCollection(coleccion).insertMany(docs);
}

//Función para library_5 (grandes lotes de variedad)
function populateLibrary5(coleccion, num) {
  const docs = [];
  for (let i = 0; i < num; i++) {
    docs.push({
      item: randomItem(),
      qty: Math.floor(Math.random() * 100 + 1),
      size: randomSize(),
      status: randomStatus()
    });
  }
  db.getCollection(coleccion).insertMany(docs);
}

//Función para books (estructura compleja con ratings y info)
function populateBooks(coleccion, num) {
  const docs = [];
  for (let i = 0; i < num; i++) {
    const ratingCount = Math.floor(Math.random() * 3 + 1);
    const ratings = [];
    for (let j = 0; j < ratingCount; j++) {
      ratings.push({
        by: `user_${Math.floor(Math.random() * 100)}`,
        rating: Math.floor(Math.random() * 5) + 1
      });
    }
    docs.push({
      item: "BOOK_" + (i + 1),
      stock: Math.floor(Math.random() * 100),
      info: {
        publisher: `${Math.floor(Math.random() * 9999)}`,
        pages: Math.floor(Math.random() * 500 + 100)
      },
      tags: ["technology", "learning", "fiction", "non-fiction"].filter(() => Math.random() > 0.5),
      ratings: ratings,
      reorder: Math.random() > 0.5
    });
  }
  db.getCollection(coleccion).insertMany(docs);
}

//Uso de las funciones
populateLibrary1("library_1_auto", 100);
populateLibrary2("library_2_auto", 100);
populateLibrary3("library_3_auto", 100);
populateLibrary4("library_4_auto", 100);
populateLibrary5("library_5_auto", 100);
populateBooks("books_auto", 100);