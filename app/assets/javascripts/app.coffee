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

  $scope.rankHash = ->
    {
      minimumResultsForSearch: -1
      data: [{id: 0, text: 'Bronze'},{id: 1, text: 'Silver'},{id: 2, text: 'Gold'},{id: 3, text: 'Platinum'},{id: 4, text: 'Diamond'},{id: 5, text: 'Challenger'}]
      initSelection: (el, cb) -> {id: 0, text: 'Bronze'}
    }

  $scope.roleHash = ->
    {
      minimumResultsForSearch: -1
      data: [{id: 0, text: 'ADC'},{id: 1, text: 'Support'},{id: 2, text: 'Mid'},{id: 3, text: 'Top'},{id: 4, text: 'Jungle'}]
      initSelection: (el, cb) -> {id: 0, text: 'ADC'}
    }

  $scope.timezoneHash = ->
    {
      initSelection: (el, cb) ->
      data: []
      ajax:
        url: $window.location.href + '/timezones'
        quietMillis: 400
        data: (term) -> { term: term }
        results: (data) -> { results: _(data.zones).map (zone, i) -> { id: i, text: zone } }
    }

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
