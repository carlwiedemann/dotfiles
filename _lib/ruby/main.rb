Dir.glob(File.dirname(__FILE__) + '/*.rb').each { _1 == __FILE__ || (require _1) }
