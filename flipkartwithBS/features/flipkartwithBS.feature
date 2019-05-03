Feature: flipkart Search Functionality

Background:
  Given I am on "https://www.flipkart.com/"

Scenario Outline: Can find product results
  When I have entered "<Product>" into the search bar.
  And I submit
  Then I should see "<Product>" Product in results
Examples:
      | Product  |
      | Poco F1 |
      | Apple iPhone 6s |
      | Samsung Galaxy S |
