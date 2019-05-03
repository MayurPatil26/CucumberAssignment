require 'yaml'
require 'rubygems'
require 'selenium-webdriver'
require 'capybara/cucumber'
require 'rspec/expectations'
require 'test/unit'
include Test::Unit::Assertions

$username = your_username # you hvae to set Access Username here
$access_key = your_access_key # you hvae to set Access Key here
# Input capabilities
caps = Selenium::WebDriver::Remote::Capabilities.new
caps['browser'] = 'Chrome'
caps['browser_version'] = '62.0'
caps['os'] = 'Windows'
caps['os_version'] = '10'
caps['resolution'] = '1024x768'


Given("I am on {string}") do |string|
  @driver = Selenium::WebDriver.for(:remote,:url => "http://#{$username}:#{$access_key}@hub-cloud.browserstack.com/wd/hub",
    :desired_capabilities => caps)
  @driver.navigate.to string
  @driver.find_element(:xpath, '//button[@class="_2AkmmA _29YdH8"]').click
  @element = @driver.find_element(:name, 'q')
end

When("I have entered {string} into the search bar.") do |product|
  @element.send_keys product
end

When("I submit") do
  @element.submit
end

Then("I should see {string} Product in results") do |searched|
  product_details= {}
  output ={}
  names = Array[]
  prices = Array[]
  wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  wait.until {@driver.find_element(:xpath, '//div[@class="_1joEet"]').displayed?}
  @driver.find_elements(:xpath, '//div[@class="_3wU53n"]').each do |name|
    names.push(name.text)
  end
  @driver.find_elements(:xpath, '//div[@class="_1vC4OE _2rQ-NK"]').each do |price|
  prices.push(price.text)
  end
  @driver.quit
  product_details = Hash[names.zip(prices.map {|i| i.split /, /})]
  output = product_details.sort_by { |name, price| price }
  puts output
  output.each do |name, price|
    assert(name.downcase.include?(searched.downcase),"Test Failed")
  end
end
