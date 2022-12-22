const morgan = require('morgan');

const logger = morgan((tokens, req, res) => [
  tokens.method(req, res),
  decodeURI(tokens.url(req, res)),
  tokens.status(req, res),
  tokens.res(req, res, 'content-length'), '-',
  tokens['response-time'](req, res), 'ms',
].join(' '));

module.exports = logger;
