function stubFn() {
	function fn() {
		fn.was_called = true;
		fn.args = arguments;
	}
	fn.was_called = false;
	return fn;
}

function stubAjax(htmlReturned) {
	function fn(options) {
		fn.ajaxOptions = options;
		options.success(htmlReturned);
	}
	fn.ajaxOptions = {};
	return fn;
}
