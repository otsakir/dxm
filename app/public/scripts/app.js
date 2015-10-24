angular.module('dxm', [
	'ngRoute',
	'ngResource',
	'ui.bootstrap',
	'uiGmapgoogle-maps'
]);

angular.module('dxm').config(function($routeProvider, $locationProvider) {
	$routeProvider
	.when('/', {
		templateUrl: 'templates/home.html',
		controller: 'homeCtrl'
	})
	.when('/browse', {
		templateUrl: 'templates/browse.html',
		controller: 'browseCtrl'
	})	
	.when('/profile', {
		templateUrl: 'templates/profile.html',
		controller: 'profileCtrl',
		controllerAs: 'ctrl'
	})		
	.otherwise({
		redirectTo: "/"
	});
});

angular.module('dxm').config(function(uiGmapGoogleMapApiProvider) {
    uiGmapGoogleMapApiProvider.configure({
        key: 'AIzaSyBxPZxYYs6Vh9gaQtV0k0yfSHO33ixBsy4 ',
        v: '3.20', //defaults to latest 3.X anyhow
        libraries: 'weather,geometry,visualization'
    });
})
