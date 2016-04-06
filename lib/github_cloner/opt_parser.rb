require 'optparse'
require 'ostruct'
module GithubCloner
  class OptParser
    # Return a structure describing the options.
    def self.parse(args)
      # The options specified on the command line will be collected in *options*.
      options = OpenStruct.new

      # Set the sensible default for the options explicitly
      options.base_dir = "."
      options.all_repos = false
      options.group_by_user = false
      options.clone_repos = false

      # The parser
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

        opts.on("-l", "--language [LANG]",
                "Clone only project of type LANG (optional)",
                "where LANG is main language as shown on Github") do |lang|
          options.language = lang
        end

        # Boolean switch.
        opts.on("-a", "--[no-]all-repos",
                "All repository only (optional)",
                "default to original/non-forked repositories only") do |a|
          options.all_repos = a
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
          puts "a) List the 'JavaScript' repositories for a given user (dry-run)"
          puts "github-cloner -b ~/Desktop/projects -u awesome_user -l JavaScript"
          puts ""
          puts "b) Clone the 'JavaScript' repositories for a given user (note: --clone or -c option)"
          puts "github-cloner -b ~/Desktop/projects -u awesome_user -l JavaScript -c"
          puts ""
          exit
        end
      end

      opt_parser.parse!(args)
      options
    end
  end
end
