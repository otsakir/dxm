angular.module("dxm").controller("MainCtrl",function ($scope) {
	$scope.hello = "Hello World!";
});

angular.module("dxm").controller("homeCtrl",function ($scope) {
	$scope.map = { center: { latitude: 45, longitude: -73 }, zoom: 8 };
});

angular.module("dxm").controller("browseCtrl",function ($scope, $resource) {
	var Locations = $resource("api/locations");
	$scope.locations = Locations.query();
	// 37.9908996, 23.7032341 - athens
	$scope.map = { center: { latitude: 37.9908996, longitude: 23.7032341 }, zoom: 4 };
});

