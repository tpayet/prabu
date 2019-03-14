require 'logger'
require 'git'
require 'gitlab'
require 'httparty'

require_relative 'slack'

logger = Logger.new(STDOUT)

# Update repo & create pull request
repo = ENV['REPO_NAME']
repo_http = "https://oauth2:#{ENV['GITLAB_API_PRIVATE_TOKEN']}@gitlab.com/#{repo}"
tmp_dir = "prabu_tmp_#{Time.now.to_i}"

logger.info 'git clone'
g = Git.clone(
  "#{repo_http}.git",
  tmp_dir,
  path: '/tmp'
)
Dir.chdir(g.dir.path)
g.config('user.name', 'Meili Prabu')
g.config('user.email', 'prabu@meilisearch.com')

logger.info   'bundle install'
install = `bundle install --quiet`
abort "#{install}" unless $?.exitstatus.zero?

logger.info 'bundle update'
update = `bundle update --quiet`
abort "#{update}" unless $?.exitstatus.zero?

branch_name = "bundle-update-#{Time.now.to_i}"
logger.info 'create branch & checkout'
g.branch(branch_name).checkout

logger.info 'git add'
g.add(:all=>true)

logger.info "git commit #{g.commit("Upd dependancies with bundle update")}"

logger.info "git push origin #{branch_name}"
push = g.push(g.remote('origin'), branch_name)
abort "#{push}" unless $?.exitstatus.zero?

logger.info 'delete tmp dir'
FileUtils.remove_dir(Dir.pwd) if File.directory?(Dir.pwd)


# Ask for merge request
logger.info 'merge request to gitlab'
merge_request = Gitlab.create_merge_request(
  repo,
  'Prabu automatic bundle update',
  source_branch: branch_name,
  target_branch: 'master'
)

notifier = SlackNotifier.new(ENV['SLACK_WEBHOOK'])
notifier.send "Bundle update on #{repo} - <#{merge_request.web_url}|merge request>"
