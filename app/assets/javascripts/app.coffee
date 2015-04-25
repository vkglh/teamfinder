AppCtrl = ['$scope', '$http', '$timeout', '$q', ($scope, $http, $timeout, $q) ->

]

app = angular.module('lolteam', ['ngCookies',
                                'ui.mask',
                                'ui.select2',
                                'ngDialog',
                                'ngSanitize',
                                'angularFileUpload',
                                'angularUtils.directives.dirPagination'])
  .controller('app', AppCtrl)
  .config(['$httpProvider', '$compileProvider', ($httpProvider, $compileProvider) ->
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = angular.element('meta[name=csrf-token]').attr 'content'
    $compileProvider.aHrefSanitizationWhitelist /^\s*(https?|ftp|file|sms|tel):|data:image\//
  ]).filter 'reverse', -> (items) -> items.slice().reverse()

angular.element(document).on 'ready page:load', -> angular.bootstrap('body', ['lolteam'])
