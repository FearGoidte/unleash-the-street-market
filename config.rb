Time.zone = 'London'

###
# Page options, layouts, aliases and proxies
###

# Markdown settings
set :markdown_engine, :redcarpet
set :markdown, xhtml: true

# Activate directory indices and remove file extensions from urls
activate :directory_indexes
set :index_file, 'index.xhtml'
set :trailing_slash, true

# Per-page layout changes:


# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  blog.prefix = "articles"
  blog.permalink = "{title}.xhtml"
  # Matcher for blog source files
  blog.sources = "{year}-{month}-{day}-{title}.xhtml"
  blog.taglink = "tags/{tag}.xhtml"
  blog.layout = "article"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  blog.year_link = "{year}.xhtml"
  blog.month_link = "{year}/{month}.xhtml"
  blog.day_link = "{year}/{month}/{day}.xhtml"
  blog.default_extension = ".markdown"
  blog.tag_template = "tag.xhtml"
  blog.calendar_template = "calendar.xhtml"
  blog.new_article_template = File.expand_path('../blank_article.erb', __FILE__)
  # Enable pagination
  blog.paginate = true
  blog.per_page = 5
  blog.page_link = "page/{num}"
end

# Reload the browser automatically whenever files change
# configure :development do
#	activate :livereload
# end

# Relative links
set :relative_links, true
activate :relative_assets

# Asset hashes so that cache times can be increased
activate :asset_hash, exts: ['.css',
                             '.eot',
                             '.gif',
                             '.ico',
                             '.jpeg',
                             '.jpg',
                             '.js',
                             '.otf',
                             '.map',
                             '.png',
                             '.svg',
                             '.svgz',
                             '.ttf',
                             '.webp',
                             '.woff',
                             '.woff2']

# Markdown settings
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true,
               input: 'GFM',
               layout_engine: :erb,
               with_toc_data: true,
               xhtml: true

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Build-specific configuration
configure :build do
  # Ignore Google owner verification file
  activate :gzip, exts: ['.css',
                         '.htm',
                         '.html',
                         '.js',
                         '.svg',
                         '.txt',
                         '.xhtml',
                         '.xml'],
                  ignore: ['google*.html']
  activate :minify_html, remove_quotes: false
  activate :minify_css
end

# Copy files to build folder after build
after_build do
  print 'After_build fixes … '
  system("cp \licence.txt #{config[:build_dir] + '/licence.txt'}")
  system("cp \README.markdown #{config[:build_dir] + '/README.markdown'}")
  puts 'done.'
end

# Deploy to GitHub
activate :deploy do |deploy|
  deploy.deploy_method = :git
  deploy.remote = 'git@github.com:FearGoidte/unleash-the-street-market.git'
  deploy.branch = 'gh-pages'
  deploy.build_before = true
end
