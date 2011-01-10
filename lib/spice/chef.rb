module Spice
  class Chef
    attr_accessor :host, :client_name, :key_file, :port, :path, :scheme, :connection
    

    def initialize(options={})
      @client_name = options[:client_name] || Spice.client_name
      @key_file    = options[:key_file]    || Spice.key_file
      @host        = options[:host]        || Spice.host        
      @port        = options[:port]        || Spice.port
      @scheme      = options[:scheme]      || Spice.scheme
      @connection  = Connection.new(
                       :url => "#{@scheme}://#{@host}:#{@port}", 
                       :client_name => options[:client_name], 
                       :key_file => options[:key_file]
                     )                     || Spice.connection
      
      
      @default_headers = options[:headers] || {}
      @sign_on_redirect, @sign_request = true, true       
    end
    
    def connection
      @connection || Spice.connection
    end
    
    def self.connection
      @connection || Spice.connection
    end
    
    class << self
      def clients
        Client.list
      end
    
      def nodes
        Node.list
      end
    
      def data_bags
        DataBag.list
      end
    end
  end
end

