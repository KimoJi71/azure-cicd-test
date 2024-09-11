const express = require('express');
const serveStatic = require('serve-static');

// 壓縮中間件;
const compression = require('compression');

const app = express();
const port = process.env.PORT || 8082;

app.use(compression()); // Compress all routes

// 傳遞一個包含靜態資源的目錄dist給express.static中間件
app.use(serveStatic(__dirname + '/dist/spa'));

// 發送頁面道域名，使得輸入服務器地址後就是這個頁面
// app.get(/.*/, (req, res) => {
app.get(/.*/, (req, res) => {
  res.sendFile(__dirname, './dist/spa/index.html');
});

// 創建一個端口號為port的服務器並監聽
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}/`);
});
