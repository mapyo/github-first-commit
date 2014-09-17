#!/usr/bin/env ruby

require 'net/http'
require 'uri'
require 'json'

require 'pry'

repo_path = 'mapyo/android-training/'
github_api_url = 'https://api.github.com/repos/'
commits_path = 'commits/master'

github_url = 'https://github.com/'

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
  print "hoge"
end


print "The most recent commit is #{commit_message} by #{name}."


# binding.pry


