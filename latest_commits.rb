#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'open-uri'

repo_path = ENV['REPO_PATH'] # ex. mapyo/helloworld/
github_url = (ENV['GHE_URL'] || 'https://github.com/')

if ENV['GHE_URL'].nil?
  github_api_url = 'https://api.github.com/repos/'
else
  github_api_url = ENV['GHE_URL'] + 'api/v3/' + 'repos/'
end

token = ENV['TOKEN']

commits_path = 'commits/master'


# repo_path check
if repo_path.nil?
  p 'Set the environment variable of REPO_PATH.'
  exit
end

api_url = github_api_url + repo_path + commits_path



if token.nil?
  res = open(api_url).read
else
  res = open(api_url, 'Authorization' => "token #{token}").read
end


result = JSON.parse(res)

result_commit = result['commit']


name = result_commit['committer']['name']

message = result_commit['message']
match_string = message.match(/#(\d+)/)
pull_number = match_string[1]


# Whether the merge log pull request
if pull_number.nil?
  commit_message = message
else
  pull_url = github_url + repo_path + 'pull/' + pull_number
  pull_title = message.slice(message.index("\n\n") + 2 ... message.length)
  commit_message = pull_title + " " + pull_url
end


print "The most recent commit is #{commit_message} by #{name}."
