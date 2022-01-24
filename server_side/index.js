const express = require("express");
var http = require("http");
const app = express();
const port = process.env.PORT || 5000;
var server = http.createServer(app);
var io = require("socket.io")(server);

//middlewre
app.use(express.json());
var clients = {};

io.on("connection", (socket) => {
    console.log("connetetd success !!");
    // console.log('socket connected with id = ', socket.id, );
    /// signIn user
    socket.on("/signIn", (id) => {
        console.log('signin user by id ', id);
        // clients[id] = socket;
        // console.log(clients);
    });
    /// on msg
    socket.on("message", (msg) => {
        console.log(msg);
        let targetId = msg.targetId;
        if (clients[targetId]) clients[targetId].emit("message", msg);
    });
});

///
server.listen(port, "0.0.0.0", () => {
    console.log("server started", port);
});