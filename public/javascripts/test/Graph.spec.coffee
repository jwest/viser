describe 'Graph', ->
    
    scope = null
    graph = null

    beforeEach(angular.mock.module('App'))

    beforeEach angular.mock.inject ($rootScope, Graph) =>
        scope = $rootScope.$new()
        console.log Graph
        graph = Graph

    it 'should be hello world in text property', ->
