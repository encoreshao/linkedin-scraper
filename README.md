Linkedin Scraper
================

Linkedin-scraper is a gem for scraping linkedin public profile/company.
Give the Linkedin URL, return the corresponding profile/company data


##Installation

Install the gem from RubyGems:

    gem 'linkedin-scraper', github: 'encoreshao/linkedin-scraper'

##Usage


Initialize a scraper instance

    profile = Linkedin::Profile.get_profile("http://www.linkedin.com/in/jeffweiner08")

    company = Linkedin::Company.get_profile("http://www.linkedin.com/company/linkedin")


The gem also comes with a binary and can be used from the command line to get a json response of the scraped data. It takes the url as the first argument.

    linkedin-scraper http://www.linkedin.com/in/jeffweiner08

    linkedin-scraper http://www.linkedin.com/company/linkedin

You're welcome to fork this project and send pull requests
