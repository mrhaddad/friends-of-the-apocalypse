require "bundler/capistrano"

set :user, 'deploy'
set :application, 'fota'

set :repository, "git@github.com:mrhaddad/friends-of-the-apocalypse.git" # Your clone URL
set :scm, "git"
set :branch, "master"
set :scm_verbose, true
set :deploy_via, :remote_cache
set :deploy_to, "/home/#{user}/#{application}"
set :use_sudo, false
set :domain, '173.255.228.96'
set :rails_env, "production"
set :whenever_environment, "production"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

role :web, domain # Your HTTP server, Apache/etc
role :app, domain # This may be the same as your `Web` server
role :db, domain, :primary => true # This is where Rails migrations will run

namespace :deploy do
  task :start do
    ;
  end
  task :stop do
    ;
  end
  task :restart, :roles => :app, :except => {:no_release => true} do
    run "cd /home/#{user}/#{application}/current && bundle exec thin restart -d -C /home/#{user}/thin/#{application}.yml"
  end
  task :symlink_uploads do
    run "ln -nfs #{shared_path}/uploads  #{release_path}/public/uploads"
  end
end

desc "Dumps target database into development db"
namespace :db do
  task :clone_to_local, roles: :db, only: {primary: true} do
    run "pg_dump -Fc --no-acl --no-owner -h #{domain} -U deploy compound_time_#{stage} > ct.dump"
    get "ct.dump", "tmp/ct.dump"
    `pg_restore --verbose --clean --no-acl --no-owner -d compound_time_development tmp/ct.dump`
  end
end


after "deploy:restart", "deploy:cleanup"
after 'deploy:update_code', 'deploy:symlink_uploads'