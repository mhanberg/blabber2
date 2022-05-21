defmodule Blabber.Web.Thoughts do
  alias Aino.Token
  alias Blabber.Models.Thought
  alias Blabber.Repo
  require Logger

  def create(token) do
    result =
      %Thought{}
      |> Thought.changeset(token.params)
      |> Repo.insert()

    case result do
      {:ok, _thought} ->
        Logger.info("Successfully blabbed!")

      {:error, changeset} ->
        Logger.error("Failed to blab! #{inspect(changeset)}")
    end

    token
    |> Token.Response.redirect("/")
  end

  def delete(token) do
    thought = Repo.get!(Thought, token.params["id"])

    Repo.delete!(thought)

    token
    |> Token.Response.redirect("/")
  end
end
