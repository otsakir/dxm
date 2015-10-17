angular.module('dxm', [
	'ngRoute',
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
	.otherwise({
		redirectTo: "/"
	});
});

angular.module('dxm').config(function(uiGmapGoogleMapApiProvider) {
    uiGmapGoogleMapApiProvider.configure({
        //    key: 'your api key',
        v: '3.20', //defaults to latest 3.X anyhow
        libraries: 'weather,geometry,visualization'
    });
})
