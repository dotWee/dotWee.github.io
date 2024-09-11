require 'yaml'
require 'json'
require 'digest'
require 'uri'

Jekyll::Hooks.register :site, :post_write do |site|
  yaml_path = File.join(site.source, "_data", "resume.yml")
  json_path = File.join(site.dest, "assets", "resume.json")

  if File.exist?(yaml_path)
    yaml_data = YAML.load_file(yaml_path)

    # Add additional properties from the site configuration
    yaml_data["basics"]["email"] = site.config["email"]
    yaml_data["basics"]["url"] = site.config["url"]
    yaml_data["basics"]["summary"] = site.config["description"]

    # Add image property by using the gravatar hash
    email = site.config["email"].downcase
    hash = Digest::SHA256.hexdigest(email)
    yaml_data["basics"]["image"] = "https://www.gravatar.com/avatar/#{hash}?s=600"

    # Append the site baseurl to the profile urls, if it only contains the path
    yaml_data["basics"]["profiles"].each do |profile|
      profile["url"] = File.join(site.config["url"], profile["url"]) if profile["url"].start_with?("/")
    end

    # Same for the volunteer projects
    yaml_data["volunteer"].each do |volunteer|
      volunteer["url"] = File.join(site.config["url"], volunteer["url"]) if volunteer["url"].start_with?("/")
    end

    File.open(json_path, "w") do |f|
      f.write(JSON.pretty_generate(yaml_data))
    end
    puts "Converted #{yaml_path} to #{json_path}"
  else
    puts "#{yaml_path} not found!"
  end
end
