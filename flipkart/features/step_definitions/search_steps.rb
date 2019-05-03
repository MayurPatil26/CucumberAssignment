require 'watir'
require 'rspec/expectations'
require 'test/unit'
include Test::Unit::Assertions

Given("I have entered {string} into the query.") do |term|
  @browser ||= Watir::Browser.new :chrome
  @browser.goto 'flipkart.com'
  @browser.button(text: '✕').click
  @browser.text_field(:name => 'q').set term
end

When("I click {string}") do |button_name|
  @browser.button.click
end

Then("I should see {string} Product in results") do |searched|
product_details= {}
output ={}
for product in 1..10
  product_names = @browser.div(class: '_3wU53n', :index => product)
  product_price = @browser.div(class: /1vC4OE/, :index => product)
  name = product_names.text
  price = product_price.text
  product_details.store(name, price)
end
output = product_details.sort_by { |name, price| price }
output.each do |name, price|
  assert(name.downcase.include?(searched.downcase),"Test Failed")
end
@browser.close
end
