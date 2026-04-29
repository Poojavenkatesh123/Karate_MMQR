function fn() {

  var env = karate.env;
  if (!env) env = 'uat';

  var config = {};

  if (env === 'uat') {
    config.baseUrl = 'http://mpay-uat.okdollar.org';
  } 
  
  else if (env === 'Prod') {
    config.baseUrl = 'http://mpay-prod.okdollar.org';   // ✅ correct prod URL
  }

  return config;
}