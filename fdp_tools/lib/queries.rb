NAMESPACES = "PREFIX dcat: <http://www.w3.org/ns/dcat#>
  PREFIX dct: <http://purl.org/dc/terms/>
  PREFIX fdp: <https://w3id.org/fdp/fdp-o#>
  PREFIX vcard: <http://www.w3.org/2006/vcard/ns#>
  PREFIX ftr: <https://w3id.org/ftr#>
  PREFIX dqv: <http://www.w3.org/ns/dqv#>
  PREFIX sio: <http://semanticscience.org/resource/>
  ".freeze
require 'sparql/client'
SPARQL = SPARQL::Client.new('http://dbpedia.org/sparql')

def find_tests_for_metric(endpoint:, metricid:)
  query = "
    #{NAMESPACES}
    SELECT DISTINCT ?testid WHERE
    {
     ?test sio['SIO_000233'] <#{metricid}> .
     ?testid dct:identifier ?testid .
    }
    "
  result = SPARQL.query(query).map { |result| result[:s].to_s }
end
