Capistrano::Configuration.instance(:must_exist).load do

  namespace :ssl do    
    desc "create csr and key for ssl certificates"
    task :create, :roles => :app, :except => {:no_release => true} do
      sudo "mkdir -p /data/ssl/"
      set(:length) { Capistrano::CLI.ui.ask("key length (1024 or 2048): ") }
      set(:country) { Capistrano::CLI.ui.ask("Country Code (2 letters): ") }
      set(:state) { Capistrano::CLI.ui.ask("State/Province: ") }
      set(:city) { Capistrano::CLI.ui.ask("City: ") }
      set(:domain) { Capistrano::CLI.ui.ask("Common Name (domain): ") }
      set(:organization) { Capistrano::CLI.ui.ask("Organization: ") }
      set(:email) { Capistrano::CLI.ui.ask("Email Address: ") }
      run "cd /data/ssl && #{sudo} openssl req -new -nodes -days 365 -newkey rsa:#{length} -subj '/C=#{country}/ST=#{state}/L=#{city}/CN=#{domain}/O=#{organization}/emailAddress=#{email}' -keyout #{domain}.key -out #{domain}.csr"
    end   
  end
end
