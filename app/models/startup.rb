# Build the following methods on the Startup class
# Startup#name
# returns a string that is the startup's name
# Startup#founder
# returns a string that is the founder's name
# Once a startup is created, the founder cannot be changed.
# Startup#domain
# returns a string that is the startup's domain
# Once a startup is created, the domain cannot be changed.
# Startup#pivot
# given a string of a domain and a string of a name, change the domain and name of the startup
# Startup.all
# should return all of the startup instances
# Startup.find_by_founder
# given a string of a founder's name, returns the first startup whose founder's name matches
# Startup.domains
# should return an array of all of the different startup domains


# Startup
# Startup#sign_contract
# given a venture capitalist object, type of investment (as a string), and the amount invested (as a float), creates a new funding round and associates it with that startup and venture capitalist.
# Startup#num_funding_rounds
# Returns the total number of funding rounds that the startup has gotten
# Startup#total_funds
# Returns the total sum of investments that the startup has gotten
# Startup#investors
# Returns a unique array of all the venture capitalists that have invested in this company
# Startup#big_investors
# Returns a unique array of all the venture capitalists that have invested in this company and are in the Trés Commas club

require 'pry'

class Startup
    attr_accessor :name
    attr_reader :founder, :domain
    @@all = []

    def self.all
        @@all
    end

    def initialize(name, founder, domain)
        self.name = name
        @founder = founder
        @domain = domain
        @@all << self
    end

    def pivot(domain, name)
        @domain = domain
        self.name = name
    end

    def self.find_by_founder(founder)
        self.all.find {|startup| startup.founder == founder}
    end

    def self.domains
        self.all.map {|startup| startup.domain}.uniq
    end

    def sign_contract(vc, type, investment)
        FundingRound.new(self, vc, type, investment)
    end 

    def num_funding_rounds 
        FundingRound.all.select {|fr| fr.startup == self}.length
    end 

    def total_funds 
       FundingRound.all.select {|fr| fr.startup == self}.inject(0){|sum, fundingRound| sum + fundingRound.investment}
    end

    def investors
        FundingRound.all.select {|fr| fr.startup == self}.map {|startup| startup.venture_capitalist}.uniq
    end

    def big_investors
        self.investors.select {|vc| vc.total_worth > 1000000000}
    end


end

