// Use: node benchmark.js
// checkout https://www.npmjs.org/package/api-benchmark for option configuration
// please do not reinstall api-benchmarks - I made some hacks to allow testing random GET requests
//
// Added maxLines to settings - max number of lines in file

var options = { debug: true, minSamples: 10000, maxTime: 100, maxConcurrentRequests: 100, runMode: 'parallel',
maxLines: 26803296 };

var apiBenchmark = require('api-benchmark');
var fs = require('fs');

var dataFunc = function(){
  return 'http://localhost:4567/lines/'.concat(Math.floor(Math.random()*options['maxLines'])+1)
};

var routes = {
  route1: {
    method: 'get',
    route: dataFunc
  }
};

var service = {
  server1: "http://localhost:4567/"
};

apiBenchmark.measure(service, routes, options, function(err, results){
  apiBenchmark.getHtml(results, function(error, html){
    fs.writeFile("results.html", html, function(err) {
        if(err) {
            console.log(err);
        } else {
            console.log("The file was saved!");
        }
    });
  });
});
