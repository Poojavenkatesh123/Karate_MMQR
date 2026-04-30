function fn() {

  var env = karate.env || 'uat';   // default = uat
  karate.log('Running in environment:', env);

  var config = {};

  if (env === 'dev') {
    config.baseUrl = 'http://dev-url.com';
  } else if (env === 'uat') {
    config.baseUrl = 'http://mpay-uat.okdollar.org';
  } else if (env === 'prod') {
    config.baseUrl = 'https://prod-url.com';
  }

  karate.log('Base URL:', config.baseUrl);

  return config;
}