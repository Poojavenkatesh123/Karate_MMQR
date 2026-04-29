function fn() {

  var env = karate.env;
  if (!env) env = 'uat';

  var config = {};

  if (env === 'uat') {
    config.baseUrl = 'http://mpay-uat.okdollar.org';
  } else if (env === 'prod') {
    config.baseUrl = 'http://mpay-prod.okdollar.org';
  }

  return config;
}