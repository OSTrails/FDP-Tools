module FdpTools
  class FDP
    attr_accessor :graph, :address, :called, :toptype, :suffix

    DCATSTRUCTURE = { 'Resource' => 'http://www.w3.org/ns/dcat#resource',
                      'DataService1' => 'http://www.w3.org/ns/dcat#service',
                      'Catalog' => 'http://www.w3.org/ns/dcat#catalog',
                      'Dataset' => 'http://www.w3.org/ns/ldp#dataset',
                      'Distribution' => 'http://www.w3.org/ns/ldp#distribution',
                      'DataService2' => 'http://www.w3.org/ns/ldp#accessService' }

    def initialize(address:)
    end

    def self.get_tests_for_metric(metricid:)
      # the logic here is to find the "highest level" DCAT object
      # e.g. Catalog is higher than Dataset
      query = SPARQL.parse('SELECT distinct ?type WHERE { ?s a ?type }') # this is called for every objecgt type in the DCAT record
      types = query.execute(@graph).map { |result| result[:type].to_s }
      warn 'toplevel results', types
      toptype = nil

      if types.include?('https://w3id.org/fdp/fdp-o#FAIRDataPoint')
        toptype = 'FDP'
      elsif types.include?('http://www.w3.org/ns/dcat#Catalog')
        toptype = 'Catalog'
      elsif types.include?('http://www.w3.org/ns/dcat#Dataset')
        toptype = 'Dataset'
      elsif types.include?('http://www.w3.org/ns/dcat#Disgtribution')
        toptype = 'Distribution'
      elsif types.include?('http://www.w3.org/ns/dcat#DataService')
        toptype = 'DataService'
      end
      warn 'final TOP type', toptype
      toptype
    end
  end
end
