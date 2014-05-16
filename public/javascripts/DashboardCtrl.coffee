window.app = angular.module 'viser', ['ngResource']
 
app.controller 'DashboardCtrl', ($scope, @Graph) ->

  $('.dviz-content svg').height $(window).height()

  $scope.text = 'Hello World!'

  createTimeLine = ->
    chart = new SmoothieChart
    chart.addTimeSeries data,
      strokeStyle: 'rgba(0, 255, 0, 1)'
      fillStyle: 'rgba(0, 255, 0, 0.1)'
      lineWidth: 3
    chart.streamTo document.getElementById("chart"), 500

  $('#chart')
    .attr('width', $(window).width())
    .attr('height', 50)

  data = new TimeSeries
  createTimeLine()

  $scope.socket = window.io.connect window.location.origin
  $scope.socket.on 'flow', (source, target) =>
    now = new Date().getTime()
    data.append now - 1, 0
    data.append now, 1
    data.append now + 1, 0
    @Graph.focus source, target
