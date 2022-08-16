const User = require("../models/User");

var bcrypt = require("bcryptjs");

module.exports = function(app) {
    app.post("/register", function(req, res){
        //check available username/email
        User.find({
            "$or": [{"Username":req.body.Username}, {"Email":req.body.Email}]
        }, function(err, data) {
            if (data.length == 0) {
                bcrypt.getSalt(10, function(err, salt) {
                    bcrypt.hash(req.body.Password, salt, function(err){
                        if (err) {
                            res.json({"kq": 0,})
                        }
                    });
                });
            }
        });
    });
}