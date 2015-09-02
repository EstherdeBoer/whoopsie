Rails.application.routes.draw do
  post "/errors", to: "errors#create"
  get  "/bang",   to: "errors#bang"
  get  "/ping",   to: "errors#ping"
end
