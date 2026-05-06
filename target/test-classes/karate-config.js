function fn() {

  var config = {};

  var base = java.lang.System.getenv('BASE_URL');

  if (base) {
    config.baseUrl = base;
  } else {
    config.baseUrl = 'http://mpay-uat.okdollar.org';
  }

  karate.log('Base URL:', config.baseUrl);

  // ───────────────────────────────────────────────
  // Structured payment log writer
  //   File:  target/karate-logs/payments.log
  //   First call per JVM truncates; subsequent calls append.
  // ───────────────────────────────────────────────
  config.appendPaymentLog = function(text) {
    var File       = Java.type('java.io.File');
    var FileWriter = Java.type('java.io.FileWriter');
    var System     = Java.type('java.lang.System');
    var dir = new File('target/karate-logs');
    if (!dir.exists()) dir.mkdirs();
    var initKey = 'karate.payments.log.inited';
    var append  = (System.getProperty(initKey) === 'true');
    var fw = new FileWriter('target/karate-logs/payments.log', append);
    fw.write(text);
    fw.close();
    System.setProperty(initKey, 'true');
  };

  // Format an ISO-style timestamp with millis: 2026-05-05 16:30:12.123
  config.nowStamp = function() {
    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
    var JDate            = Java.type('java.util.Date');
    return new SimpleDateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(new JDate());
  };

  return config;
}
