const express = require('express');
const exphbs = require('express-handlebars');
const logger = require('./middleware/logger');
const { all } = require('./routes/api/employees');


const app = express();

// Init middleware
app.use(logger);


app.get('/', (req, res) => {
    res.render('index', {
        title: 'Employee App'
    });
});
//Body Parser Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: false }));


app.use('/api/employees', require('./routes/api/employees'));

const port = process.env.PORT || 8080;

app.listen(port, () => console.log(`Listening on port ${port}...`));