function fn() {

  var config = {};

  var base = java.lang.System.getenv('BASE_URL');

  if (base) {
    config.baseUrl = base;
  } else {
    config.baseUrl = 'http://mpay-uat.okdollar.org';
  }

  karate.log('Base URL:', config.baseUrl);

  return config;
}