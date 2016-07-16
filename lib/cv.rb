require_relative 'github.rb'

no_grab = ! ENV['CV_NO_GRAB'].nil?
$github = Github.new(no_grab)

PRETTY_ELEMENT = 'pretty'

module Internal
  def self.unique_id(*components)
    components.join '-'
  end

  def self.img(id, src, options)
      classes = if options.has_key? :classes and !options[:classes].empty?
        "image #{options[:classes].join(' ')}"
      else
        "image"
      end
      
      img_element = "<img id=\"#{id}\" class=\"#{classes}\" src=\"#{src}\">"
      
      if options.has_key? :link
        "<a href=\"#{options[:link]}\">#{img_element}</a>"
      else
        img_element
      end
  end
end

module Config
  def self.set_username(name)
    raise 'please set your username at the top of index.html' if 'YOUR_USERNAME' == name

    $github.set_username(name)
  end
end

module Bare
  def self.username
    $github.username
  end

  def self.avatar(classes=[])
    page, src = $github.avatar
    
    Internal::img 'avatar', src, :link => page, :classes => classes
  end

  def self.bio(classes=[])
    page, src = $github.bio
    
    Internal::img 'bio', src, :link => page, :classes => classes
  end

  def self.commit_message(owner, repo, sha, classes=[])
    id = Internal::unique_id 'commit-message', owner, repo, sha
    page, src = $github.commit_message owner, repo, sha
    
    Internal::img id, src, :link => page, :classes => classes
  end
  
  def self.contributions_calendar(classes=[])
    src = $github.contributions_calendar
    
    Internal::img 'contributions_calendar', src, :classes => classes
  end

  def self.issue_first_comment(owner, repo, issue_id, classes=[])
    id = Internal::unique_id 'issue-first-comment', owner, repo, issue_id
    page, src = $github.issue_first_comment owner, repo, issue_id
    
    Internal::img id, src, :link => page, :classes => classes
  end

  def self.popular_repos(classes=[])
    page, src = $github.popular_repos
    
    Internal::img 'popular_repos', src, :link => page, :classes => classes
  end

  def self.public_news(classes=[])
    page, src = $github.public_news
    
    Internal::img 'public_news', src, :link => page, :classes => classes
  end

  def self.pull_request_overview(owner, repo, pull_request_id, classes=[])
    id = Internal::unique_id 'pull-request', owner, repo, pull_request_id
    page, src = $github.pull_request_overview owner, repo, pull_request_id
    
    Internal::img id, src, :link => page, :classes => classes
  end
end

#
# Pretty convenience methods
#

def username_link
  "<a href=\"#{profile_url}\">@#{Bare::username}</a>"
end

def profile_url
  $github.profile_page
end

def avatar
  Bare::avatar [PRETTY_ELEMENT]
end

def bio
  Bare::bio [PRETTY_ELEMENT]
end

def commit_message(owner, repo, sha)
  Bare::commit_message(owner, repo, sha, [PRETTY_ELEMENT])
end

def contributions_calendar
  Bare::contributions_calendar [PRETTY_ELEMENT]
end

def issue_first_comment(owner, repo, issue_id)
  Bare::issue_first_comment(owner, repo, issue_id, [PRETTY_ELEMENT])
end

def popular_repos
  Bare::popular_repos [PRETTY_ELEMENT]
end

def public_news
  Bare::public_news [PRETTY_ELEMENT]
end

def popular_repos
  Bare::popular_repos [PRETTY_ELEMENT]
end

def pull_request_overview(owner, repo, pull_request_id)
  Bare::pull_request_overview(owner, repo, pull_request_id, [PRETTY_ELEMENT])
end
