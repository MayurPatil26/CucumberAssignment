Feature: Users must be able to search for product using Flipkart.

Scenario Outline: Search for a product.
Given I have entered "<Product>" into the query.
When I click "search"
Then I should see "<Product>" Product in results

Examples:
    | Product  |
    | Poco F1 |
    | Apple iPhone 6s |
    | Samsung Galaxy S |
