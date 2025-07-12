Dir.glob(File.dirname(__FILE__) + '/*.rb').reject { _1 == __FILE__ }.each { require _1 }
