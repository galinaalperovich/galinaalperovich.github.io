# Adds the Google Tag Manager container to every rendered HTML page: the loader right after <head>,
# and the no-JavaScript fallback right after <body>. The container ID is `google_tag_manager` in _config.yml;
# leave it empty to turn this off. Google Analytics itself is set up inside the container, so the theme's own
# `analytics.google` setting stays empty (setting both would count every visit twice).
module GoogleTagManager
  MARK = "<!-- Google Tag Manager -->".freeze

  def self.inject(item)
    id = item.site.config["google_tag_manager"].to_s.strip
    return if id.empty? || item.output_ext != ".html" || item.output.nil? || item.output.include?(MARK)

    head = <<~HTML
      #{MARK}
      <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
      new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
      j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
      'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
      })(window,document,'script','dataLayer','#{id}');</script>
      <!-- End Google Tag Manager -->
    HTML
    body = %(<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=#{id}" height="0" width="0" ) +
           %(style="display:none;visibility:hidden"></iframe></noscript>)

    out = item.output.sub(/<head(\s[^>]*)?>/i) { |m| "#{m}\n#{head}" }
    out = out.sub(/<body(\s[^>]*)?>/i) { |m| "#{m}\n#{body}" }
    item.output = out
  end
end

# :documents covers posts and every other collection; :pages covers the rest (home, blog list, redirects).
Jekyll::Hooks.register [:pages, :documents], :post_render do |item|
  GoogleTagManager.inject(item)
end
