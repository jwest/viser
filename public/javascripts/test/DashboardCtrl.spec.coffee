describe 'DashboardCtrl', ->
    
    scope = null

    beforeEach(angular.mock.module('viser'))

    beforeEach angular.mock.inject ($rootScope, $controller) =>
        scope = $rootScope.$new()
        $controller 'DashboardCtrl', {$scope: scope}

    # it 'should be hello world in text property', ->
    #     expect(scope.text).toBe "Hello World!"