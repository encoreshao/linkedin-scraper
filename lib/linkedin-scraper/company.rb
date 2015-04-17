# -*- coding: utf-8 -*-

require File.expand_path('../base', __FILE__)

module Linkedin

  class Company < Base

    ATTRIBUTES = %w(
    id
    name
    universal_name
    company_type
    founded_year
    employees
    number_of_employees
    specialties
    num_followers
    industries
    website_url
    top_image_url
    logo_url
    locations
    description
    company_employees
    also_viewed
    )

    def self.fetch(url)
      new(url)
    rescue => e
      puts e
    end

    def id
      linkedin_id = (@page.at("a.feed-show-more").attr('href').match(/companyId=\d+/)[0].gsub('companyId=', '') if @page.at("a.feed-show-more"))

      @id ||= if linkedin_id.nil?
        (@page.at("div.company-employees > a:first").attr('href').match(/f_CC=\d+/)[0].gsub('f_CC=', '') if @page.at("div.company-employees > a:first"))
      else
        linkedin_id
      end
    end

    def universal_name
      @universal_name ||= (@page.at('div.header > a').attr('href').gsub(/\/company\//, '').gsub(/\?trk=company_logo/, '') if @page.at('div.header > a'))
    end

    def name
      @name ||= (@page.at('h1.name span').text.strip if @page.at('h1.name span'))
    end

    def specialties
      @specialties ||= (@page.at('div.specialties p').text.strip if @page.at('div.specialties p'))
    end

    def industries
      @industries ||= (@page.at('li.industry p').text.strip if @page.at('li.industry p'))
    end

    def company_type
      @company_type ||= (@page.at('li.type p').text.strip if @page.at('li.type p'))
    end

    def website_url
      @website_url ||= (@page.at('li.website p a').text.strip if @page.at('li.website p a'))
    end

    def num_followers
      @num_followers ||= (@page.at('p.followers-count strong').text.gsub(',', '').strip.to_i if @page.at('p.followers-count strong'))
    end

    def number_of_employees
      @number_of_employees ||= (@page.at('a.employee-count').text.gsub(',', '').strip.to_i if @page.at('a.employee-count'))
    end

    def employees
      @employees ||= (@page.at("li.company-size p").text.strip if @page.at('li.company-size p'))
    end

    def founded_year
      @founded_year ||= (@page.at("li.founded p").text.strip if @page.at('li.founded p'))
    end

    def end_year
      @end_year ||= nil
    end

    def description
      @description ||= (@page.at("div.text-logo p").text.strip if @page.at('div.text-logo p'))
    end

    def logo_url
      @logo_url ||= (@page.at('div.image-wrapper img').attr('src').strip if @page.at('div.image-wrapper img'))
    end

    def top_image_url
      @top_image_url ||= (@page.at('div.top-image img').attr('src').strip if @page.at('div.top-image img'))
    end

    # def skills
    #   @skills ||= (@page.search('.skill-pill .endorse-item-name-text').map { |skill| skill.text.strip if skill.text } rescue nil)
    # end
    # 
    
    def locations
      @locations ||= if @page.at('li.vcard p')
        if @page.at('li.vcard p').children.length > 0
          h_options = {}
          h_options = h_options.merge({ street_address1: @page.at('li.vcard p span.street-address:first').text }) if @page.at('li.vcard p span.street-address:first')
          h_options = h_options.merge({ street_address2: @page.at('li.vcard p span.street-address:last').text }) if @page.at('li.vcard p span.street-address:last')
          h_options = h_options.merge({ locality: @page.at('li.vcard p span.locality').text }) if @page.at('li.vcard p span.locality')
          h_options = h_options.merge({ region: @page.at('li.vcard p abbr.region').text }) if @page.at('li.vcard p abbr.region')
          h_options = h_options.merge({ postal_code: @page.at('li.vcard p span.postal-code').text }) if @page.at('li.vcard p span.postal-code')
          h_options = h_options.merge({ country: @page.at('li.vcard p span.country-name').text }) if @page.at('li.vcard p span.country-name')
          h_options
        else
          @page.at('li.vcard p').text.strip
        end
      end
    end

    def company_employees
      @company_employees ||= (@page.search('.discovery-panel li a.discovery-photo').map { |u| 
        u.attr('href').gsub('?trk=biz_employee_pub', '') if u 
      } rescue nil)
    end

    def also_viewed
      @also_viewed ||= (@page.search('.also-viewed li a').map { |u| 
        "https://www.linkedin.com/" + u.attr('href').gsub('?trk=extra_biz_viewers_viewed', '') if u 
      } rescue nil)
    end

    def to_json
      require 'json'

      ATTRIBUTES.reduce({}){ |hash,attr| hash[attr.to_sym] = self.send(attr.to_sym);hash }.to_json
    end

  end
end
