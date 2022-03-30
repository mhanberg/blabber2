defmodule Example.Config do
  use Vapor.Planner

  dotenv()

  config :application,
         env([
           {:environment, "DEPLOY_ENV", default: "development"},
           {:port, "PORT", default: 4000, map: &String.to_integer/1},
           {:host, "HOST", default: "localhost"}
         ])
end
