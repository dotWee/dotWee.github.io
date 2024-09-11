require 'yaml'
require 'json'

Jekyll::Hooks.register :site, :post_write do |site|
  yaml_path = File.join(site.source, "_data", "resume.yml")
  json_path = File.join(site.dest, "assets", "resume.json")

  if File.exist?(yaml_path)
    yaml_data = YAML.load_file(yaml_path)
    File.open(json_path, "w") do |f|
      f.write(JSON.pretty_generate(yaml_data))
    end
    puts "Converted #{yaml_path} to #{json_path}"
  else
    puts "#{yaml_path} not found!"
  end
end
