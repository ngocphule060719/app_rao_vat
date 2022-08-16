var express = require("express");
var app = express();
app.set("view engine", "ejs");
app.set("views", "./views");
app.use(express.static("public"));
app.listen(3000);

//Mongoose
const mongoose = require('mongoose');
mongoose.connect('mongodb+srv://ngocphule:DwNdZLvZ2nj8PKX6@appraovat.bnwjkr6.mongodb.net/?retryWrites=true&w=majority', function(err){
    if (err) {
        console.log("Mongodb connected error: " + err);
    } else {
        console.log("Mongodb connected successfully!");
    }
});

//body-parser
require("./routes/fileManager")(app);
require("./routes/account")(app);