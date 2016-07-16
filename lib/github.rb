require 'capybara'
require 'capybara/poltergeist'
require 'capybara/dsl'

require_relative 'cv'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, :js_errors => false)
end

Capybara.javascript_driver = :poltergeist
Capybara.run_server = false

class Github
  def initialize(no_grab=false)
    @no_grab = no_grab
    @session = Capybara::Session.new(:poltergeist)
    @visiting = nil
  end
  
  def set_username(name)
    @username = name
  end
    
  def avatar
    page = profile_page
    image = grab page, '.page-content .avatar', 'avatar'
    
    [page, image]
  end
  
  def contributions_calendar
    grab profile_page, '#contributions-calendar', 'contributions-calendar'
  end

  def bio
    page = profile_page
    image = grab page, '.column.one-fourth', 'bio'
    
    [page, image]
  end

  def commit_message(owner, repo, sha)
    page = commit_page owner, repo, sha
    image = grab page, '.full-commit', Internal::unique_id('commit-message', owner, repo, sha)
    
    [page, image]
  end
  
  def issue_first_comment(owner, repo, id)
    page = issue_page owner, repo, id
    image = grab page, '.timeline-comment-wrapper', Internal::unique_id('issue-first-comment', owner, repo, id)
    
    [page, image]
  end
  
  def popular_repos
    page = profile_page
    image = grab page, '.popular-repos', 'popular-repos'
    
    [page, image]
  end
  
  def public_news
    page = profile_activity_page
    image = grab page, '.public_news', 'public-news'
    
    [page, image]
  end
  
  def pull_request_overview(owner, repo, id)
    page = pull_request_page(owner, repo, id)
    image = grab page, '#partial-discussion-header', Internal::unique_id('pull-request-overview', owner, repo, id)
    
    [page, image]
  end
  
  def username
    raise 'username not set' if @username.nil?
    
    @username
  end

  def profile_page
    "https://github.com/#{username}"
  end
  
  private
  
  def images_directory
    "images"
  end
  
  def grab(url, selector, resource)
    filename = "#{images_directory}/#{resource}.png"
    
    unless @no_grab
      @session.visit(url) unless url == @visiting
      @session.save_screenshot filename, :selector => selector
    end
    
    filename
  end
  
  def page(resource)
    "https://github.com#{resource}"
  end
  
  def commit_page(owner, repo, sha)
    page "/#{owner}/#{repo}/commit/#{sha}"
  end
  
  def issue_page(owner, repo, id)
    page "/#{owner}/#{repo}/issues/#{id}"
  end

  def profile_repositiories_page
    "#{profile_page}?tab=repositories"
  end
    
  def profile_activity_page
    "#{profile_page}?tab=activity"
  end
  
  def project_page(name)
    page "/#{username}/#{name}"
  end
  
  def pull_request_page(owner, repo, id)
    page "/#{owner}/#{repo}/pull/#{id}"
  end
end
