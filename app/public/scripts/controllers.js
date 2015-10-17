angular.module("dxm").controller("MainCtrl",function ($scope) {
	$scope.hello = "Hello World!";
});

angular.module("dxm").controller("homeCtrl",function ($scope) {
	$scope.map = { center: { latitude: 45, longitude: -73 }, zoom: 8 };
});

angular.module("dxm").controller("browseCtrl",function ($scope) {
	$scope.map = { center: { latitude: 45, longitude: -73 }, zoom: 8 };
});

