window.app = angular.module 'viser', ['ngResource']
 
app.controller 'DashboardCtrl', ($scope, @Graph) ->

    $scope.text = 'Hello World!'
    # $scope.graph = Graph

    $scope.socket = window.io.connect('http://localhost:3000');
    $scope.socket.on 'flow', (source, target) =>
      @Graph.focus source, target