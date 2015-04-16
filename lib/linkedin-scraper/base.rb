# -*- coding: utf-8 -*-
module Linkedin

  class Base

    USER_AGENTS = ['Windows IE 6', 'Windows IE 7', 'Windows Mozilla', 'Mac Safari', 'Mac FireFox', 'Mac Mozilla', 'Linux Mozilla', 'Linux Firefox', 'Linux Konqueror']

    attr_reader :page, :linkedin_url

    def initialize(url, options={})
      @linkedin_url = url
      @options      = options
      @page         = http_client.get(url)
    end

    private

    def parse_date(date)
      date = "#{date}-01-01" if date =~ /^(19|20)\d{2}$/
      Date.parse(date)
    end

    def http_client
      Mechanize.new do |agent|
        agent.user_agent_alias = USER_AGENTS.sample

        unless @options.empty?
          agent.set_proxy(@options[:proxy_ip], @options[:proxy_port])
        end
        
        agent.max_history = 0
      end
    end

    def get_linkedin_company_url(link)
      http = %r{http://www.linkedin.com/}
      https = %r{https://www.linkedin.com/}
      if http.match(link) || https.match(link)
        link
      else
        "http://www.linkedin.com/#{link}"
      end
    end
  end
end
