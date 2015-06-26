lock '3.4.0'

set :default_env,   { mix_env: "prod", port: 3000}

set :application, 'elixir.stream'
set :repo_url, 'git@github.com:janjiss/elixir-stream-phoenix.git'

set :deploy_to, '/var/www/elixirstreamphoenix'

set :log_level, :info
set :keep_releases, 3

# Setup Phoenix Secrets & Assets
set :linked_files, %w{
    config/prod.secret.exs
  }

set :linked_dirs, %w{
    deps
    node_modules
    rel
    _build
  }

namespace :dependencies do

  # --force is used to try and force the install.
  # If this 'takes too long' try manually first on server as deploy.
  task :phoenix do
    on roles(:app) do |host|
      within(release_path) do
        execute(:mix, "deps.get", "--force")
      end
    end
  end

  task :npm do
    on roles(:app) do |host|
      within(release_path) do
        execute(:npm, "install")
      end
    end
  end
end

namespace :phoenix do

task :brunch do
  on roles(:app) do |host|
    within(release_path) do
      execute(:brunch, "build", "--production")
    end
  end
end

  task :digest do
    on roles(:app) do |host|
      within(release_path) do
        execute(:mix, "phoenix.digest")
      end
    end
  end

  #Requires use of exrm!
  task :release do
    on roles(:app) do |host|
      within(release_path) do
        execute(:mix, "release")
      end
    end
  end

  #requires use of exrm!
  task :cleanup do
    on roles(:app) do |host|
      within(release_path) do
        execute(:mix, "deps.clean", "--all")
      end
    end
  end

  task :migrations do
  on roles(:app) do |host|
    within(release_path) do
      execute(:mix, "ecto.migrate")
    end
  end
end

  task :serve do
    on roles(:app) do |host|
      invoke("phoenix:stop")
      invoke("phoenix:start")
    end

  end

  task :ping do
    on roles(:app) do |host|
      within("#{current_path}/rel/elixir_stream/bin") do
        execute("./elixir_stream", "ping")
      end
    end
  end

  task :stop do
    on roles(:app) do |host|
      within("#{current_path}/rel/elixir_stream/bin") do
        begin
          execute("./elixir_stream", "stop")
        rescue
          puts "?"*25
          puts "#{host} was not serving Phoenix |> sad"
          puts "-"*25
        end
      end
    end
  end

  task :start do
    on roles(:app) do |host|
      within("#{current_path}/rel/elixir_stream/bin") do
        begin
          execute("./elixir_stream", "start")
        rescue
          puts "!"*25
          puts "#{host} didn't start serving Phoenix |> concern"
          puts "-"*25
        end
      end
    end
  end
end


namespace :deploy do

  task :build do
    invoke("dependencies:phoenix")
    invoke("dependencies:npm")
    invoke("phoenix:brunch")
    invoke("phoenix:digest")
    invoke("phoenix:release")
  end


  before :publishing, :build

  #Restart, hopefully not a restart in the future.
  after :published, 'phoenix:serve'

  #cleandups
  after :finishing, 'phoenix:cleanup'

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

