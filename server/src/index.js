const qs = require('qs');
const express = require('express');
const cors = require('cors');
const logger = require('./middleware/logger');

const app = express();

// Enable CORS
app.use(cors());

app.options('*', (req, res) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS');
  res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization, Content-Length, X-Requested-With, Access-Control-Allow-Headers, Content-Range');
  res.sendStatus(200);
});
// Init middleware
app.use(logger);


app.get('/', (req, res) => {
  res.render('index', {
    title: 'Employee App',
  });
});
// Body Parser Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use('/api/employees', require('./routes/api/employees'));

const port = process.env.PORT || 8080;

app.listen(port, () => console.log(`Listening on port ${port}...`));
