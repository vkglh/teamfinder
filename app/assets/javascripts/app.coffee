AppCtrl = ['$scope', '$http', '$timeout', '$window', '$q', ($scope, $http, $timeout, $window, $q) ->

]

HeaderCtrl = ['$scope', '$http', '$timeout', '$window', '$q', ($scope, $http, $timeout, $window, $q) ->

  $scope.user = null

  $http.get('/user').success (rsp) -> $scope.user = rsp

  $scope.signup = ->
    $http.post('/auth/signup', {form: $scope.form}).success (rsp) ->
      if rsp.success
        $window.location = '/'

  $scope.login = ->
    $http.post('/auth/signin', {form: $scope.form}).success (rsp) ->
      if rsp.success
        $window.location = '/'

]

app = angular.module('lolteam', ['ngCookies',
                                'ui.mask',
                                'ui.select2',
                                'ngSanitize',
                                'angularUtils.directives.dirPagination'])
  .controller('app', AppCtrl)
  .controller('header', HeaderCtrl)
  .config(['$httpProvider', '$compileProvider', ($httpProvider, $compileProvider) ->
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = angular.element('meta[name=csrf-token]').attr 'content'
    $compileProvider.aHrefSanitizationWhitelist /^\s*(https?|ftp|file|sms|tel):|data:image\//
  ]).filter 'reverse', -> (items) -> items.slice().reverse()

angular.element(document).on 'ready page:load', -> angular.bootstrap('body', ['lolteam'])
