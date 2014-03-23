require "bundler/capistrano"

server "rajewska.asia", :web, :app, :db, primary: true

set :application, "planer"
set :user, "asia"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:rajaaa92/planer.git"
set :branch, "master"


default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  task :restart, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /opt/nginx/conf/sites-available/#{application}.conf"
    sudo "ln -s /opt/nginx/conf/sites-available/#{application}.conf /opt/nginx/conf/sites-enabled/#{application}.conf"
    sudo "/opt/nginx/sbin/nginx -s reload"
    sudo "service nginx reload"
    run "mkdir -p #{shared_path}/config"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/mongoid.yml #{release_path}/config/mongoid.yml"
    run "ln -nfs #{shared_path}/config/secrets.yml #{release_path}/config/secrets.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  task :cleanup, :except => {:no_release => true} do
    count = fetch(:keep_releases, 5).to_i
    run "ls -1dt #{releases_path}/* | tail -n +#{count + 1} | #{try_sudo} xargs rm -rf"
  end

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end
