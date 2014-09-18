#!/usr/bin/env ruby

require 'net/http'
require 'uri'
require 'json'

require 'pry'

repo_path = ENV['REPO_PATH'] # ex. mapyo/helloworld/
github_api_url = (ENV['GITHUB_API_URL'] || 'https://api.github.com/') + 'repos/'
github_url = (ENV['GITHUB_URL'] || 'https://github.com/')

commits_path = 'commits/master'


# repo_path check
if repo_path.nil?
  p 'Set the environment variable of REPO_PATH.'
  exit
end

api_url = github_api_url + repo_path + commits_path

uri = URI.parse(api_url)
json = Net::HTTP.get(uri)
result = JSON.parse(json)


result_commit = result['commit']

name = result_commit['committer']['name']
message = result_commit['message']

/#\d{1}/ =~ message
/\d{1}/ =~ $&
pull_number = $&


# Whether the merge log pull request
if (/^[0-9]+$/ =~ pull_number)
  pull_url = github_url + repo_path + 'pull/' + pull_number
  pull_title = message.slice(message.index("\n\n") + 2 ... message.length)
  commit_message = pull_title + " " + pull_url
else
  commit_message = message
end


print "The most recent commit is #{commit_message} by #{name}."
