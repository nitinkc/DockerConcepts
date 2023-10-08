const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  console.log('Default / api called ' + req);
  res.send('Express Server UP and RUNNING !!');
});

app.get('/health', (req, res) => {
  console.log('/health api called ' + req);
  res.send('Health is OK!!');
});


app.listen(port, () => {
  console.log(`Listening on port ${port}`);
});