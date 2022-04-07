defmodule Blabber.Web.Thoughts do
  alias Aino.Token
  alias Blabber.Models.Thought
  alias Blabber.Repo

  def create(token) do
    result =
      %Thought{}
      |> Thought.changeset(token.params)
      |> Repo.insert()

    case result do
      {:ok, _thought} ->
        IO.puts(IO.ANSI.green() <> "Successfully blabbed!" <> IO.ANSI.reset())

      {:error, changeset} ->
        IO.inspect(changeset, label: "changeset")
        IO.puts(IO.ANSI.red() <> "Failed to blab!!!" <> IO.ANSI.reset())
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
