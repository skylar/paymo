# API Redelivery configuration values
require 'balanced'
BALANCED_CONFIG = YAML.load_file("#{Rails.root}/config/balanced.yml")[Rails.env]

#configure the key 
Balanced.configure(BALANCED_CONFIG[:key])

#initialize the marketplace
Balanced::Marketplace.my_marketplace || Balanced::Marketplace.new.save
