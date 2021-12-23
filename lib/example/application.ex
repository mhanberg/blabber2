defmodule Example.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Aino,
       callback: Example.Web.Handler,
       port: 4000,
       host: "localhost",
       otp_app: :example,
       environment: "development"}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Example.Supervisor]
    Supervisor.start_link(children, opts)
  end

    def watchers("development") do
    [
      [
        command: "node_modules/yarn/bin/yarn",
        args: ["build:css:watch"],
        directory: "assets/"
      ]
    ]
  end

  def watchers(_), do: []
end
