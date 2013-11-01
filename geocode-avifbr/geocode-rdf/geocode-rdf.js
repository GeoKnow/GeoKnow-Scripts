/*
 * Boilerplate setup
 * TODO Get rid of it / hide it as much as possible
 *
 */

var XMLHttpRequest = require("xmlhttprequest").XMLHttpRequest;

$ = require('jquery');

require('prototype');

_ = require('underscore');
_.str = require('underscore.string');

_.mixin(_.str.exports());

var Jassa = require('jassa');
//console.log(JSON.stringify(Jassa));
var sponate = Jassa.sponate;


$.support.cors = true;
$.ajaxSettings.xhr = function () {
    return new XMLHttpRequest;
}

/*
 * Actual script starts here
 */

	var prefixes = {
		'dbpedia-owl': 'http://dbpedia.org/ontology/',
		'dbpedia': 'http://.org/resource/',
		'rdfs': 'http://www.w3.org/2000/01/rdf-schema#',
		'foaf': 'http://xmlns.com/foaf/0.1/',
		'o': 'http://geoknow.eu/wp5/ontology#'
	};

	var service = sponate.ServiceUtils.createSparqlHttp('http://localhost:8812/sparql');	
	var store = new sponate.StoreFacade(service, prefixes);

	store.addMap({
		name: 'addresses',
		template: [{
			id: '?s',
			country: '?co',
			city: '?ci',
			zip: '?zi',
			street: '?st'
		}],
		from: '?s o:country ?co ; o:city ?ci ; o:zipcode ?zi ; o:street ?st .'
	});

        store.addresses.find().asList().done(function(items) {
//		_.map(items, function(item) {
			var queryString = 'Augustusplatz 10 Leipzig 04109 Deutschland';
			var req = doLookup(queryString);
			req.done(function(x) {
				console.log(JSON.stringify('Response for ' + queryString + ': ' + JSON.stringify(x)));
			}).fail(function(err) {
				console.log('Fail: ' + JSON.stringify(err));
			});
//		});

		//console.log(JSON.stringify(items));
	});


	var doLookup = function(queryString) {
		var service = "http://open.mapquestapi.com/nominatim/v1/search";
		// http://nominatim.openstreetmap.org/search
		var uri = service + "?format=json&q=" + encodeURIComponent(queryString);

		console.log('Requesting: ', uri);

		var result = $.ajax({url: uri, dataType: 'json'});
		return result;
	};

