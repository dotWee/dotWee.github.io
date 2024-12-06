require 'yaml'
require 'json'
require 'digest'
require 'uri'

Jekyll::Hooks.register :site, :post_write do |site|
  yaml_path = File.join(site.source, "_data", "resume.yml")
  json_path = File.join(site.dest, "assets", "resume.json")

  if File.exist?(yaml_path)
    yaml_data = YAML.load_file(yaml_path)

    # Append the site baseurl to the profile urls, if it only contains the path
    yaml_data = append_baseurl_to_yaml(yaml_data, site.config["url"])

    # Add additional properties from the site configuration
    yaml_data["basics"]["email"] = site.config["email"]
    yaml_data["basics"]["url"] = site.config["url"]
    yaml_data["basics"]["summary"] = site.config["description"]

    # Add image property by using the gravatar hash, if property image not defined
    if not defined?(yaml_data["basics"]["image"])
      yaml_data["basics"]["image"] = get_gravatar_url(site.config["email"])
    end

    File.open(json_path, "w") do |f|
      f.write(JSON.pretty_generate(yaml_data))
    end
    puts "Converted #{yaml_path} to #{json_path}"
  else
    puts "#{yaml_path} not found!"
  end
end


# Appends a base URL to relative URL paths in a YAML string
#
# This function takes a YAML string and a base URL, then processes all string
# values in the YAML data structure. It appends the base URL to any string
# that appears to be a relative URL path (i.e., start with '/').
# The function handles nested structures (hashes and arrays) within the YAML.
#
# @param yaml_string [String] The input YAML string to be processed
# @param baseurl [String] The base URL to be prepended to relative paths
#
# @return [String] A new YAML string with modified URL paths
#
# @example
#   yaml_str = "
#   site:
#     url: /home
#   pages:
#     - url: /about
#     - url: https://example.com/contact
#   "
#   baseurl = 'https://mywebsite.com'
#   result = append_baseurl_to_yaml(yaml_str, baseurl)
#   puts result
#   # Output:
#   # ---
#   # site:
#   #   url: https://mywebsite.com/home
#   # pages:
#   # - url: https://mywebsite.com/about
#   # - url: https://example.com/contact
#
# @note This function modifies all string values that start with '/'.
#       Be cautious when using it on YAML that may contain non-URL string values.
def append_baseurl_to_yaml(yaml_obj, baseurl) # recursive function to process nested structures
  case yaml_obj
  when Hash
    yaml_obj.transform_values! { |v| append_baseurl_to_yaml(v, baseurl) }
  when Array
    yaml_obj.map! { |v| append_baseurl_to_yaml(v, baseurl) }
  when String
    if yaml_obj.start_with?("/")
      File.join(baseurl, yaml_obj)
    else
      yaml_obj
    end
  else
    yaml_obj
  end
end


# Returns the Gravatar URL for a given email address
#
# This function takes an email address and returns the Gravatar URL for the email.
# The URL is constructed using the Gravatar hash of the email address.
# The function also accepts an optional size parameter for the image size.
# The default size is 600 pixels.
# 
# @param email [String] The email address to generate the Gravatar URL
# @param size [Integer] The size of the Gravatar image (default: 600)
# 
# @return [String] The Gravatar URL for the email address
def get_gravatar_url(email, size=600) # get the gravatar url for the email, with a default size of 600
  email = email.downcase
  hash = Digest::SHA256.hexdigest(email)
  return "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
end
