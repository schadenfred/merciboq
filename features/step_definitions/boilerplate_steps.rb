Then /^(?:|I )should not see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_no_xpath('//*', :text => regexp)
  else
    assert page.has_no_xpath?('//*', :text => regexp)
  end
end

Then /^I should not see a link to "([^"]*)"$/ do |arg1|
  page.should have_no_selector 'a', :text => arg1
end

Then /^I should see "([^"]*)" in the title$/ do |arg2|
  page.should have_selector('title', :text => arg2)
end

Given /^I should see a link to "([^"]*)"$/ do |arg3|
  page.should have_selector 'a', :text => arg3
end
