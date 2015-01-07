Prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
Prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
Prefix xsd: <http://www.w3.org/2001/XMLSchema#>
Prefix geo: <http://www.w3.org/2003/01/geo/wgs84_pos#>
Prefix skos: <http://www.w3.org/2004/02/skos/core#>

Prefix dbo: <http://dbpedia.org/ontology/>

Prefix o: <http://example.org/ontology/>
Prefix r: <http://example.org/resource/>

Create View Region As
  Construct {
    ?s
      a o:Region ;
      rdfs:label ?l ;
      geo:long ?x ;
      geo:lat ?y ;
      dbo:population ?p ;
      o:hotelCount ?c
  }
  With
    ?s = uri(r:region, ?id)
    ?l = plainLiteral(?name)
    ?x = typedLiteral(?lon, xsd:double)
    ?y = typedLiteral(?lat, xsd:double)
    ?p = typedLiteral(?population, xsd:integer)
    ?c = typedLiteral(?hotelCount, xsd:integer)
  From
    Region


Create View RegionAlternateNames As
  Construct {
    ?s
      skos:altLabel ?l
  }
  With
    ?s = uri(r:region, ?region_id)
    ?l = plainLiteral(?name)
  From
    RegionAlternateNames


Create View RegionPerimeter As
  Construct {
    ?r
      o:perimeter ?s .

    ?s
      a o:Perimeter ;
      geo:long ?x ;
      geo:lat ?y ;
      dbo:perimeter ?p
  }
  With
    ?r = uri(r:region, ?region_id)
    ?s = uri(r:perimeter, ?region_id)
    ?x = typedLiteral(?lon, xsd:double)
    ?y = typedLiteral(?lat, xsd:double)
    ?p = typedLiteral(?perimeter, xsd:integer)
  From
    RegionPerimeter

Create View RegionHierarchyClosure As
  Construct {
    ?s
      a o:RegionHierarchyClosure ;
      o:tree ?t ;
      o:parent ?p ;
      o:child ?c ;
      o:distance ?d

  }
  With
    ?s = uri(r:regionHierarchyClosure, ?regionTree_id, '-', ?region_id, '-', ?parent_region_id)
    ?t = uri(r:regionTreeId, ?regionTree_id)
    ?p = uri(r:region, ?parent_region_id)
    ?c = uri(r:region, ?region_id)
    ?d = typedLiteral(?distance, xsd:integer)
  From 
    RegionHierarchyClosure

