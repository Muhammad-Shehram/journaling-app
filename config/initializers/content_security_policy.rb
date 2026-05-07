# Be sure to restart your server when you modify this file.

Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self
    policy.font_src    :self, :data
    # :https covers Cloudinary CDN image delivery; :blob for ActionText previews
    policy.img_src     :self, :https, :data, :blob
    policy.object_src  :none
    # :unsafe_inline required by Trix rich-text editor for inline styles
    policy.style_src   :self, :unsafe_inline
    # script-src uses per-request nonce (set below) — covers importmap inline script
    policy.script_src  :self
    policy.connect_src :self
    policy.media_src   :self, :https, :blob
    # Prevent this app from being embedded in iframes on other origins
    policy.frame_ancestors :none
  end

  # Attach a nonce to every inline importmap <script> tag Rails generates
  config.content_security_policy_nonce_generator = ->(request) { request.session.id.to_s }
  config.content_security_policy_nonce_directives = %w[script-src]
end
