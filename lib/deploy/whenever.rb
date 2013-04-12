# Base Capistrano recipe for deploying applications running under passenger

Capistrano::Configuration.instance(:must_exist).load do

  namespace :whenever do

    desc "Builds the whenever cron file on the server"
    task :update_crontab, :roles => :app do
      puts "update crontab"
      _cset(:whenever_command)      { "whenever" }
      _cset(:whenever_identifier)   { fetch :application }
      _cset(:whenever_environment)  { fetch :rails_env, "production" }
      _cset(:whenever_variables)    { "environment=#{fetch :whenever_environment}" }

      run "cd #{current_path}; #{bundler} exec vendor/bundle/bin/whenever --update-crontab #{fetch :whenever_identifier} --set #{fetch :whenever_variables}"
    end

  end

  after 'deploy:cleanup', 'whenever:update_crontab'
end