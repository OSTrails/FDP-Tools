require_relative './queries'

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
      tests = find_tests_for_metric(metricid: metricid)
      warn 'found tests', tests
      tests
    end
  end
end
