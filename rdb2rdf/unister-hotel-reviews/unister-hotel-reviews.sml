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

Prefix foaf: <http://xmlns.com/foaf/0.1/>

Prefix rev: <http://purl.org/stuff/rev#>

Prefix r: <http://ld.geoknow.eu/hotel-reviews/resource/>
Prefix o: <http://ld.geoknow.eu/hotel-reviews/ontology/>

//Prefix starRating: <http://purl.org/acco/ns/starRating#>>

Create View hotels As
  Construct {
    ?s
      a acco:Hotel ;
      o:id ?id ;
      rdfs:label ?l ;
      acco:feature ?sf ;
      geo:long ?lon ;
      geo:lat ?lat ;
      vcard:hasAddress ?a ;
      .

    ?s
      o:reviewList ?srl ;
      .

    ?a
#      vcard:country ?ctry ;
      vcard:locality ?loc ;
      vcard:postalCode ?zip ;
      vcard:streetAddress ?sa ;
      .    

    ?sf
      a acco:AccomodationFeature ;
      acco:propertyId acco:starRating ;
      acco:value ?sr ;
      .
      
  }
  With
    ?s = uri(r:, 'hotel', ?id)
    ?srl = uri(r:, 'hotel-reviews', ?id)
    ?id = typedLiteral(?id, xsd:int)
    ?l = plainLiteral(?name)
    ?sf = uri(r:, 'hotel-rating', ?id)
    ?sr = typedLiteral(?stars, xsd:int)
    ?lon = typedLiteral(?lon, xsd:decimal)
    ?lat = typedLiteral(?lat, xsd:decimal)
    ?a = uri(r:, 'hotel-address', ?id)
    ?sa = plainLiteral(?street)
    ?zip = plainLiteral(?zip)
    ?loc = plainLiteral(?city)
  From 
    geoknow_hotels



Create View reviews As
  Construct {
    ?s
      a rev:Review ;
      o:id ?id ;
      rev:reviewer ?p ;
      rdfs:label ?l ;
      o:dayOfJournay ?doj ;
      o:duration ?dur ;
      o:travelType ?tt ;
      o:travelConstellation ?tc ;
      o:trustable ?tru ;
      o:recommendation ?rec ;
      .

    ?p
      a foaf:Person ;
      rdfs:label ?pn ;
      foaf:name ?pn ;
      foaf:age ?pa ;
      o:childrenCount ?pcc ;
      .
   
    ?srl
      rev:hasReview ?s ;
      . 
  }
  With
    ?s = uri(r:, 'review', ?id)
    ?id = typedLiteral(?id, xsd:int)
    ?srl = uri(r:, 'hotel-reviews', ?hotel_id)
    ?l = plainLiteral(?title)
    ?p = uri(r:, 'person', ?id)
    ?pn = plainLiteral(?authorName)
    ?pa = typedLiteral(?authorAge, xsd:int)
    ?pcc = typedLiteral(?childrenCount, xsd:int)
    ?doj = typedLiteral(?dayOfJourney, xsd:date)
    ?dur = typedLiteral(?duration, xsd:int)
    ?tt = plainLiteral(?travelType)
    ?tc = plainLiteral(?travelConstellation)
    ?tru = typedLiteral(?trustable, xsd:boolean)
    ?rec = plainLiteral(?recommendation)
  From
    geoknow_reviews


