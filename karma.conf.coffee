module.exports = (config) ->
  config.set
    basePath: '.'

    frameworks: ['jasmine']

    files: [
      #'public/javascripts/lib/*/*.min.js'
      #'public/javascripts/lib/*.js'
      'public/javascripts/lib/angular/angular.min.js'
      'public/javascripts/lib/angular-route/angular-route.min.js'
      'public/javascripts/lib/angular-mocks/angular-mocks.js'
      {pattern: 'public/javascripts/*.coffee', included: true}
      {pattern: 'public/javascripts/test/*.spec.coffee', included: true}
    ]

    exclude: []

    preprocessors:
      '**/*.coffee': ['coffee']

    reporters: ['dots']

    port: 9876

    colors: true

    logLevel: config.LOG_INFO

    autoWatch: false

    browsers: ["PhantomJS"]

    captureTimeout: 60000

    singleRun: true

    reportSlowerThan: 500