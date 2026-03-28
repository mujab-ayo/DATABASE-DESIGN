
db.createCollection("users");
db.createCollection("categories");
db.createCollection("items");
db.createCollection("orders");
db.createCollection("orderItems");


db.users.insertMany([
  {
    _id: 1,
    name: "Admin User",
    email: "abdul.admin@mail.com",
    role: "admin",
    password: "123455",
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: 2,
    name: "Normal User",
    email: "furqan.user@mail.com",
    role: "visitor",
    password: "123455",
    createdAt: new Date(),
    updatedAt: new Date(),
  },
]);

db.categories.insertMany([
  {
    _id: 1,
    name: "Electronics",
    description: "Electronic items",
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: 2,
    name: "Clothing",
    description: "Wearable items",
    createdAt: new Date(),
    updatedAt: new Date(),
  },
]);


db.items.insertMany([
  {
    _id: 1,
    name: "Laptop",
    price: 1500,
    size: "medium",
    categoryID: 1,
    isAvailable: true,
    quantityAvailable: 10,
    description: "High performance laptop",
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: 2,
    name: "T-Shirt",
    price: 25,
    size: "large",
    categoryID: 2,
    isAvailable: true,
    quantityAvailable: 50,
    description: "Cotton t-shirt",
    createdAt: new Date(),
    updatedAt: new Date(),
  },
]);


db.orders.insertOne({
  _id: 1,
  userID: 2,
  status: "pending",
  orderDescription: "First order",
  createdAt: new Date(),
  updatedAt: new Date(),
});


db.orderItems.insertMany([
  {
    _id: 1,
    itemID: 1,
    orderID: 1,
    unitQuantity: 1,
    totalAmount: 1500,
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    _id: 2,
    itemID: 2,
    orderID: 1,
    unitQuantity: 2,
    totalAmount: 50,
    createdAt: new Date(),
    updatedAt: new Date(),
  },
]);


db.categories.find();


db.orders.aggregate([
  {
    $lookup: {
      from: "users",
      localField: "userID",
      foreignField: "_id",
      as: "user",
    },
  },
]);


db.items.aggregate([
  {
    $lookup: {
      from: "categories",
      localField: "categoryID",
      foreignField: "_id",
      as: "category",
    },
  },
]);


db.orders.updateMany({ userID: 2 }, { $set: { status: "approved" } });


let category = db.categories.findOne({ name: "Electronics" });

db.items.updateMany({ categoryID: category._id }, { $inc: { price: 100 } });


db.orders.deleteMany({ userID: 2 });

db.items.deleteMany({ categoryID: 1 });
