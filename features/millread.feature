Feature: Redirect from /millroad to main
  In order to sign in
  As a Mill Road magazine user
  I want to be redirected to the correct page
  
  Scenario: arrive at /millroad
    When I go to the mill road page
    Then I should be on the home page