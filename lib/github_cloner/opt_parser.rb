require 'optparse'
require 'ostruct'
module GithubCloner
  # See: http://ruby-doc.org/stdlib-2.3.0/libdoc/optparse/rdoc/OptionParser.html
  class OptParser
    # Return a structure describing the options.
    def self.parse(args)
      # The options specified on the command line will be collected in *options*.
      options = OpenStruct.new

      # Set the sensible default for the options explicitly
      options.base_dir      = "."
      options.all_repos     = false
      options.group_by_user = false
      options.clone_repos   = false
      options.languages     = []

      opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: github-cloner [options]"

        opts.separator ""
        opts.separator "Specific options:"

        # Mandatory argument
        opts.on("-b", "--base-dir BASE_DIR",
                "where BASE_DIR is the directory where the repositories will be cloned to (mandatory)",
                "If not specified, current directory will be used") do |dir|
          options.base_dir = dir
        end

        opts.on("-u", "--user USER",
                "The Github USER that will be cloned from (mandatory)") do |user|
          options.user = user
        end

        opts.on("-o", "--org [ORG]",
                "The Github's organization name to be used if specified (optional)",
                "where ORG is the organization that the user belongs to") do |org|
          options.org = org
        end

        opts.on("-t", "--oauth-token [OAUTH_TOKEN]",
                "The Github's oauth_token for authentication (optional - only required to list/clone private repositories)",
                "where OAUTH_TOKEN is from the user's Github setting") do |token|
          options.oauth_token = token
        end

        opts.on("-l", "--languages 'LANG1,LANG2,..,LANGn'",
                Array,
                "Clone all repos that in the list of languages") do |langs|
          options.languages = langs
        end

        # Boolean switch.
        opts.on("-a", "--[no-]all-repos",
                "All repository only (optional)",
                "default to original/non-forked repositories only") do |all_repos|
          options.all_repos = all_repos
        end

        opts.on("-g", "--[no-]group-by-user",
                "Group the output by {BASE_DIR}/{USER}/{LANG}",
                "default to {BASE_DIR}/{LANG}/{USER}") do |gbu|
          options.group_by_user = gbu
        end

        opts.on( "-c", "--[no-]clone",
                "Clone the repositories to the path specified (optional)",
                "default to --no-clone e.g. dry-run only") do |c|
          options.clone_repos = c
        end

        opts.separator ""
        opts.separator "Common options:"

        # No argument, shows at tail.  This will print an options summary.
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          puts ""
          puts "Example Usage:"
          puts ""
          puts "1) List all repositories by a given user (dry-run)"
          puts "$github-cloner -u awesome_user"
          puts ""
          puts "2) List all 'Emacs Lisp' repositories for a given user (dry-run)"
          puts "$github-cloner -b ~/Desktop/projects -u awesome_user -l 'Emacs Lisp'"
          puts ""
          puts "3) List all 'JavaScript' and 'Emacs Lisp' repositories for a given user (dry-run)"
          puts "$github-cloner -b ~/Desktop/projects -u awesome_user -l 'JavaScript,Emacs Lisp'"
          puts ""
          puts "4) Clone all 'JavaScript' and 'Emacs Lisp' repositories for a given user (note: --clone or -c option)"
          puts "$github-cloner -b ~/Desktop/projects -u awesome_user -l 'JavaScript,Emacs Lisp' -c"
          puts ""
          puts "5) Clone all 'JavaScript' and 'Emacs Lisp' repositories for a given organization where a given user belongs to (include private repos)"
          puts "$github-cloner -b ~/Desktop/projects -u awesome_user -o awesome_company -l -t GITHUB_TOKEN -l 'JavaScript,Emacs Lisp' -c"
          puts ""
          exit
        end
      end

      opt_parser.parse!(args)
      options
    end
  end
end

# options = GithubCloner::OptParser.parse(ARGV)
# puts options
# puts ARGV
