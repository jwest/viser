module.exports = function(config){
    
config.set({
    
    basePath : '.',

    files : [
      './public/javascripts/lib/jquery/jquery.min.js',
      './public/javascripts/lib/dviz.js',
      './public/javascripts/lib/opt_graph.js',
      './public/javascripts/lib/angular/angular.js',
      './public/javascripts/lib/angular-mocks/angular-mocks.js',
      './public/javascripts/lib/angular-resource/angular-resource.js',
      './**/*.coffee',
      './**/*.js'
    ],

    preprocessors: {
      './**/*.coffee': ['coffee']
    },

    coffeePreprocessor: {
      options: {
        bare: true,
        sourceMap: true //false
      },
      transformPath: function(path) {
        return path.replace(/\.js$/, '.coffee');
      }
    },

    autoWatch : true,

    frameworks: ['jasmine'],
    browsers : ['PhantomJS'],

    plugins : [
            // STEP 3: Add 'karma-coffee-preprocessor' to this list:
            'karma-coffee-preprocessor',
//            'karma-junit-reporter',
            'karma-chrome-launcher',
            'karma-firefox-launcher',
            'karma-phantomjs-launcher',
            'karma-jasmine'
            ],

    // junitReporter : {
    //   outputFile: 'test_out/unit.xml',
    //   suite: 'unit'
    // }

})}