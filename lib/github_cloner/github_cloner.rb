require 'fileutils'
module GithubCloner
  class GithubUtils
    class << self
      # List all repositories
      def list_all(opts = {})
        repos = []
        begin
          args = {
            per_page: opts[:per_page] || 100,
            all_repos: opts[:all_repos]
          }.merge!(opts)

          # If we are using :org then we must delete :user from the options
          if args[:org]
            args.merge!(org: opts[:org])
            args.delete(:user)
          else
            args.merge!(user: opts[:user])
            args.delete(:org)
          end

          # require this for only with org and with private repos
          args.merge!(oauth_token: args[:oauth_token]) if args[:oauth_token]
          ##puts "FYI: your options #{args}"

          # Only required if we use oauth_token which allow use to list private repositories
          github = Github.new(args)

          # List all repositories
          page = 1
          loop do
            args.merge!(page: page)

            list = github.repos.list(args)

            break if list.empty?
            page += 1
            repos << list.select do |r|
              if !args[:fork]
                r if !r['fork']
              else
                r
              end
            end
          end
          repos.flatten!
        rescue => e
          puts "Error getting getting repository for user/org #{e}"
          exit(1)
        end
      end

      # Clone list of repos of the following forms
      #
      def clone_all(projects, args = {})
        base_path = File.expand_path(args[:base_dir])

        if args[:clone_repos]
          FileUtils.mkdir_p(base_path)
        else
          puts "FYI: dry-run only, no action taken!!" unless args[:clone_repos]
        end

        projects.each_with_index do |project, i|
          org_name, language, repo_name = project.split(File::SEPARATOR)

          # Note: need to cleanup the language like 'Emacs Lisp' to 'Emacs_Lisp' or 'emacs_lisp'
          language = FilenameCleaner.sanitize(language, '_', false)

          if args[:group_by_user]
            output_path = [base_path, org_name, language, repo_name].join(File::SEPARATOR)
          else
            output_path = [base_path, language, org_name, repo_name].join(File::SEPARATOR)
          end

          puts "Process #{i+1} of #{projects.size} : git clone git@#{args[:repo_host]}:#{[org_name, repo_name].join(File::SEPARATOR)}.git #{output_path}"

          if args[:clone_repos]
            system("git clone git@#{args[:repo_host]}:#{[org_name, repo_name].join(File::SEPARATOR)}.git #{output_path} 2> /dev/null")
          end
        end
      end

      def repos_as_list(repos)
        # Store the result in this list
        list = []
        repos.each do |k,v|
          v.each do |i|
            user_name, repo_name = i.split(File::SEPARATOR)
            list << [user_name, k, repo_name].join(File::SEPARATOR)
          end
        end
        list
      end

      # Map of repository by language
      #
      # Map language to list of repository
      # @return [Hash<String, Array<String>>] map of language to repos
      def repos_by_language(repos, languages)
        hash = {}
        languages.each do |l|
          hash[l] = repos.collect { |r| r['full_name'] if r['language'] == l }.compact
        end
        hash
      end
    end
  end
end
