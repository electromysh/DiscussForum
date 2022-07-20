defmodule DiscussWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :discuss

  @session_options [
    store: :cookie,
    key: "_discuss_key",
    signing_salt: "qGehHxjp"
  ]

  socket "/socket", DiscussWeb.UserSocket

  plug Plug.Static,
    at: "/",
    from: :discuss,
    gzip: false,
    only: ~w(assets fonts images favicon.ico robots.txt)

  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :discuss
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug DiscussWeb.Router
end
