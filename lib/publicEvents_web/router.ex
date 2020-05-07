defmodule PublicEventsWeb.Router do
  use PublicEventsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PublicEventsWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PublicEventsWeb.Plugs.CheckUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PublicEventsWeb do
    pipe_through :browser

    live "/event/new", LPEventLive.New
    live "/event/:page", LPEventLive
    live "/event", LPEventLive

    live "/", LPEventLive
    live "/page", PageLive
    live "/user/new", UserLive.New
    # , layout: {MyApp.AlternativeView, "app.html"}
    live "/user/page/:page", UserLive.Index
    # , :index
    live "/user", UserLive.Index
  end

  # Other scopes may use custom stacks.
  # scope "/api", PublicEventsWeb do
  #   pipe_through :api
  # end

  scope "/users", PublicEventsWeb.Users, as: :users do
    pipe_through :browser
    resources "/", UserController
  end

  scope "/auth", PublicEventsWeb do
    pipe_through :browser
    get "/signout", FedAuthController, :signout
    get "/:provider", FedAuthController, :request
    get "/:provider/callback", FedAuthController, :callback
  end

  scope "/lpe", PublicEventsWeb.LPEvents, as: :lp_events do
    pipe_through :browser
    resources "/event", LPEventController
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: PublicEventsWeb.Telemetry
    end
  end
end
