/*global $,cyberDojo*/

var cyberDojo = (function(cd, $) {
  "use strict";

  cd.makeNavigateButtons = function() {

	var makeNavigateButton = function(name) {
	  var size = 30;
	  if (name === 'first' || name === 'last')
		size = 20;

	  return '' +
		'<button class="triangle button"' +
			 'id="' + name + '_button">' +
		  '<img src="/images/triangle_' + name + '.gif"' +
			  ' alt="move to ' + name + ' diff"' +
			  ' width="' + size + '"' +
			  ' height="' + size + '" />' +
		'</button>';
	};

	return '' +
		'<table id="navigate-buttons">' +
		  '<tr>' +
			cd.td(makeNavigateButton('first')) +
			cd.td(makeNavigateButton('prev')) +
			cd.td(makeNavigateButton('next')) +
			cd.td(makeNavigateButton('last')) +
		  '</tr>' +
		'</table>';
  };

  return cd;
})(cyberDojo || {}, $);
