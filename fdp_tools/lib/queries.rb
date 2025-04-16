NAMESPACES = "PREFIX dcat: <http://www.w3.org/ns/dcat#>
  PREFIX dct: <http://purl.org/dc/terms/>
  PREFIX fdp: <https://w3id.org/fdp/fdp-o#>
  PREFIX vcard: <http://www.w3.org/2006/vcard/ns#>
  PREFIX ftr: <https://w3id.org/ftr#>
  PREFIX dqv: <http://www.w3.org/ns/dqv#>
  PREFIX sio: <http://semanticscience.org/resource/>
  ".freeze

def find_tests_for_metric(metricid:)
  spq = SPARQL::Client.new(ENV['FDP_INDEX'])
  query = "
    #{NAMESPACES}
    SELECT DISTINCT ?testid WHERE
    {
     ?test sio:SIO_000233 <#{metricid}> .
     ?test dct:identifier ?testid .
    }
    "
  warn query
  spq.query(query).map { |result| result[:testid].to_s }
end
