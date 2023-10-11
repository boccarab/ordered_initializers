namespace :ordered_initializers do
  desc "Moves files from config/initializers to config/ordered_initializers and generates config/initializers.yml"
  task :install do
    def from_dir
      Rails.root.join('config/initializers')
    end

    def to_dir
      Rails.root.join('config/ordered_initializers').tap do |path|
        Dir.mkdir(path) unless Dir.exists?(path)
      end
    end

    def rails_initializers_yml_path
      Rails.root.join('config/initializers.yml')
    end

    def existing_initializer_files_path
      YAML.load_file(Rails.root.join(rails_initializers_yml_path)) || []
    rescue
      []
    end

    def all_initializer_files_path
      Dir[to_dir + '*'].map { |path| to_relative_path(path) }
    end

    def to_relative_path(path)
      path.sub(/#{Rails.root}\//, '')
    end

    def move_initializers!
      ::Kernel.warn("Moving all existing initializers from #{to_relative_path(from_dir)} to #{to_relative_path(to_dir)}")

      Dir[from_dir + '*'].each do |old_dest|
        next if old_dest.to_s.match(/0_placeholder.rb/)
        new_dest = old_dest.to_s.gsub(from_dir.to_s, to_dir.to_s)
        FileUtils.mv(old_dest, new_dest)
      end
    end

    # Keep the already existing initializers path and append the new ones at the end
    def update_initializers_yml!
      if File.exists?(rails_initializers_yml_path)
        ::Kernel.warn("Updating #{to_relative_path(rails_initializers_yml_path)}")
      else
        ::Kernel.warn("Creating #{to_relative_path(rails_initializers_yml_path)}")
      end

      new_initializer_files_path = all_initializer_files_path - existing_initializer_files_path
      initializer_files_path = existing_initializer_files_path + new_initializer_files_path

      File.open(rails_initializers_yml_path, 'w') do |f|
        f.puts '# this file have been generated using `rake ordered_initializers:install`'
        f.puts '# you can reorder the initializers path as you see fit'
        f.write initializer_files_path.to_yaml
      end

      ::Kernel.warn('The initializers will be load in the following order:')
      initializer_files_path.each do |path|
        ::Kernel.warn("- #{to_relative_path(path)}")
      end
      ::Kernel.warn('You can reorder the initializers path as you see fit.')
    end

    def add_placeholder
      ::Kernel.warn('Generating config/initializers/0_placeholder.rb')

      File.open(from_dir.join('0_placeholder.rb'), 'w') do |f|
        f.puts '# All the files from this folder were moved to config/ordered_initializers folder using `rake ordered_initializers:install`'
        f.puts '# You can still add files to this folder. They will be loaded alphabetically after the ones in config/ordered_initializers.'

        f.puts <<EOF

return if Gem::Specification.all_names.any? { |gem_name| gem_name.match(/ordered_initializers/) }

abort('`ordered_initializers` gem could not be found.
You need to either reinstall the gem, or move to this folder all the files from config/ordered_initializer then delete config/initializers.yml as well as this file.')
EOF
      end
    end

    move_initializers!
    add_placeholder
    update_initializers_yml!
  end
end

task environment: %w[ordered_initializers:install]
