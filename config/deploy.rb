# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'Creditumv3'
set :repo_url, 'https://github.com/luelher/creditumv3'

# Default branch is :master
set :branch, 'master'

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/admin/creditumv3'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :rvm_ruby_string, :local              # use the same ruby as used locally for deployment
set :rvm_autolibs_flag, "read-only"


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      run "mkdir -p #{release_path}/tmp" unless test("[ -d #{release_path}/tmp ]")
      execute :touch, release_path.join('tmp/restart.txt')
      execute "sudo service apache2 restart"
    end
  end

  desc "link config files"
  task :link_config_files do
    on roles(:app) do
      if test("[ -f #{shared_path}/database.yml ]")
        execute :ln, '-s', "#{shared_path}/database.yml", "#{release_path}/config/database.yml"
      else
        puts "No existe archivo database.yml en #{shared_path}"
      end
      if test("[ -f #{shared_path}/secret_token.rb ]")
        execute :ln, '-s', "#{shared_path}/secret_token.rb", "#{release_path}/config/initializers/secret_token.rb"
      else
        puts "No existe archivo database.yml en #{shared_path}"
      end
      # if test("[ -d #{shared_path}/assets ]")
      #   execute :ln, '-s', "#{shared_path}/assets", "#{release_path}/public/assets"
      # else
      #   puts "No existe archivo database.yml en #{shared_path}"
      # end
    end
  end

  desc "Check that we can access everything"
  task :check_write_permissions do
    on roles(:all) do |host|
      if test("[ -w #{fetch(:deploy_to)} ]")
        puts "#{fetch(:deploy_to)} is writable on #{host}"
      else
        error "#{fetch(:deploy_to)} is not writable on #{host}"
      end
    end
  end

  before :deploy, 'rvm1:install:ruby' # install Ruby and create gemset, OR:
  # before :deploy, 'rvm1:install:gems' # only create gemset
  before :compile_assets, :link_config_files
  after :publishing, :restart

end
