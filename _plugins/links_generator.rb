# frozen_string_literal: true

module LinksGenerator
  class LinkPageGenerator < Jekyll::Generator
    safe true
    priority :highest

    def generate(site)
      links_data = site.data['links']
      links_data.each do |link|
        site.pages << LinkPage.new(site, link)
      end
    end
  end

  # Subclass of `Jekyll::Page` with custom method definitions.
  class LinkPage < Jekyll::Page
    def initialize(site, link)
      @site = site             # the current site instance.
      @base = site.source      # path to the source directory.
      @dir  = 'links'          # the directory the page will reside in.

      @basename = link["name"]             # filename without the extension.
      @ext      = '.html'                   # the extension.
      @name     = "#{link["name"]}.html"  # basically @basename + @ext.

      if link['categories']
        @tags   = link['categories']
      end

      # Initialize data hash with a key pointing to all posts under current category.
      # This allows accessing the list in a template via `page.linked_docs`.
      @data = {
        'title' => link['title'],
        'layout' => 'redirect',
        'redirect' => {
          'to' => link['redirect_to']
        },
        'sitemap' => false,
        'permalink' => "/#{@dir}/#{@basename}",
      }
    end
  end
end 