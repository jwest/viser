describe 'Graph', ->
    
    scope = null
    graph = null

    beforeEach(angular.mock.module('viser'))

    beforeEach angular.mock.inject ($rootScope, Graph) =>
        scope = $rootScope.$new()
        graph = Graph

    it 'should be hello world in text property', ->
