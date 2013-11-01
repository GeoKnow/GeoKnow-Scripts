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
		//from: '{ Select * { ?s o:country ?co ; o:city ?ci ; o:zipcode ?zi ; o:street ?st . } Limit 3 }'
	});

	var countryMap = {
		"A" : "Austria", //"Österreich",
		"B" : "Belgium",
		"CN" : "China",
                "D" : "Germany", //"Deutschland",
		"E" : "England",
		"H" : "Hungaria", //"Hungaria",
		"IN" : "India",
		"KOR" : "Korea",
		"NL" : "Netherlands", //"Nederland",
		"PL" : "Poland", //"Polska",
		"SK" : "Slovakia", //"Slovakei",
		"SLO" : "Slovenia" //"Slovenija"
	};

        store.addresses.find().asList().done(function(items) {
		_(items).each(function(item) {
			var v = countryMap[item.country];
			item.country = v ? v : item.country;
		});


		_.map(items, function(item) {
			var queryString = item.street + ' ' + item.city + ' ' + item.zip + ' ' + item.country;

			var req = doLookup(queryString);
			req.done(function(data) {
				console.log(item.id + '\t' + queryString + '\tsuccess\t' + JSON.stringify(data));
			}).fail(function(err) {
				console.log(item.id + '\t' + queryString + '\tfail\t' + JSON.stringify(err));
			});
		});
	});


	var doLookup = function(queryString) {
		var service = "http://open.mapquestapi.com/nominatim/v1/search";
		// http://nominatim.openstreetmap.org/search
		var uri = service + "?format=json&q=" + encodeURIComponent(queryString);

		//console.log('Requesting: ', uri);

		var result = $.ajax({url: uri, dataType: 'json'});
		return result;
	};

