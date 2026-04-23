# frozen_string_literal: true

class Rack::Attack
  # Throttle login attempts by IP: 5 per 20 seconds
  throttle("login/ip", limit: 5, period: 20.seconds) do |req|
    req.ip if req.path == "/users/sign_in" && req.post?
  end

  # Throttle login attempts by email: 5 per 20 seconds
  throttle("login/email", limit: 5, period: 20.seconds) do |req|
    if req.path == "/users/sign_in" && req.post?
      req.params.dig("user", "email").to_s.downcase.strip.presence
    end
  end

  # Throttle password reset requests by IP: 5 per 20 minutes
  throttle("password_reset/ip", limit: 5, period: 20.minutes) do |req|
    req.ip if req.path == "/users/password" && req.post?
  end

  # Throttle account registration by IP: 10 per hour
  throttle("registrations/ip", limit: 10, period: 1.hour) do |req|
    req.ip if req.path == "/users" && req.post?
  end

  # Return a plain 429 for throttled requests
  self.throttled_responder = lambda do |_env|
    [
      429,
      { "Content-Type" => "text/html; charset=utf-8" },
      ["<html><body><h2>Too many requests</h2><p>Please wait a moment and try again.</p></body></html>"]
    ]
  end
end
