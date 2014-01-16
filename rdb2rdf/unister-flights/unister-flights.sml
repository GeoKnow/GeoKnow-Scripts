/**
 * Sparqlification Mapping Language file for
 * the Hotel Review dataset.
 *
 * This artifact is part of the GeoKnow Project 2013
 *
 * ---------------------------------------------------------------------------
 * Contributors
 * 
 * - Claus Stadler
 *
 * ---------------------------------------------------------------------------
 * Todos
 *
 * - Clarify how to represent star rating
 * - Get rid of the ad-hoc namespaces o: and r:
 *
 * ---------------------------------------------------------------------------
 * Changelog
 * 
 * - v0.9.0
 *   Initial version
 *
 */

Prefix xsd: <http://www.w3.org/2001/XMLSchema#>

Prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
Prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
Prefix owl: <http://www.w3.org/2002/07/owl#>

Prefix geo: <http://www.w3.org/2003/01/geo/wgs84_pos#>

Prefix gr: <http://purl.org/goodrelations/v1#>
Prefix acco: <http://purl.org/acco/ns#>
Prefix vcard: <http://www.w3.org/2006/vcard/ns#>

Prefix rev: <http://purl.org/stuff/rev#>

Prefix foaf: <http://xmlns.com/foaf/0.1/>

Prefix country: <http://downlode.org/rdf/iso-3166/countries#>
//Prefix airport: <http://ld.geoknow.eu/flights/resource/airport#>
Prefix airport: <http://ld.geoknow.eu/airports/resource/>

Prefix r: <http://ld.geoknow.eu/flights/resource/>
Prefix o: <http://ld.geoknow.eu/flights/ontology/>

#Prefix starRating: <http://purl.org/acco/ns/starRating#>>

Prefix dbpedia-owl: <http://dbpedia.org/ontology/>

/*

  -- SELECT "airportFrom", "airportTo", "departureDate", Count(*) FROM geoknow_flights GROUP BY "airportFrom", "airportTo", "departureDate" HAVING COUNT(*) > 1;

-- Adds a primary key
ALTER TABLE "geoknow_flights" ADD COLUMN "id" SERIAL PRIMARY KEY;

CREATE INDEX "idx_geoknow_flights_aiportFrom" ON "geoknow_flights"("airportFrom");
CREATE INDEX "idx_geoknow_flights_aiportTo" ON "geoknow_flights"("airportTo");
--CREATE VIEW "airport_codes" AS SELECT DISTINCT "airportFrom" FROM "geoknow_flights" UNION SELECT DISTINCT "airportTo" FROM "geoknow_flights";
CREATE VIEW "airport_codes"("airportCode") AS SELECT "airportFrom" FROM "geoknow_flights" UNION SELECT "airportTo" FROM "geoknow_flights";

-- CREATE INDEX "idx_geoknow_flights_labels" ON "geoknow_flights"(CONCAT('Flight from ' + ));
*/

Create View aiport_codes As
  Construct {
    ?s
      a dbpedia-owl:Airport ;
      dbpedia-owl:iataLocationIdentifier ?iata
  }
  With
    ?s = uri(airport:, ?airportCode)
    ?iata = plainLiteral(?airportCode)
  From
    airport_codes
/*
Create View geoknow_flights As
  Construct {
    ?s
      a o:Flight ;
      o:from ?af ;
      o:to ?at ;
      o:bookingDate ?bd ;
      o:departureDate ?dd ;
      o:returnDate ?rd; 
      o:price ?p ;
      o:cabinClass ?cc ;
      o:traveltype ?tt ;
      o:participants ?par ;
      o:salutation ?sal ;
      foaf:mbox_sha1sum ?mbox ;
      o:country ?country .
  }
  With
    //?s = uri(r:, 'flight', ?airportFrom, '-', ?airportTo, '-', ?bookingDate, '-', departureDate)
    ?s = uri(r:, 'flight', ?id)
    ?af = uri(airport:, ?airportFrom)
    ?at = uri(airport:, ?airportTo)
    ?bd = typedLiteral(?bookingDate, xsd:dateTime)
    ?dd = typedLiteral(?departureDate, xsd:dateTime)
    ?rd = typedLiteral(?returnDate, xsd:dateTime)
    ?p = typedLiteral(?price, xsd:decimal)
    ?cc = uri(r:, 'cabinClass-', ?cabinClass)
    ?tt = uri(r:, 'travelType-', ?traveltype)
    ?par = typedLiteral(?participants, xsd:int)
    ?sal = plainLiteral(?salutation)
    ?mbox = plainLiteral(?email)
    ?country = uri(country:, ?country)
  From
    geoknow_flights
    //[[SELECT * FROM "geoknow_flights" LIMIT 10]]
*/

