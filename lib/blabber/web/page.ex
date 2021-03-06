defmodule Blabber.Web.Page do
  alias Aino.Token
  alias Blabber.Web.Page.View

  alias Blabber.Repo
  import Ecto.Query
  alias Blabber.Models.Thought

  def root(token) do
    thoughts = Repo.all(from(t in Thought, order_by: [desc: t.inserted_at]))

    token
    |> Token.response_status(200)
    |> Token.response_header("Content-Type", "text/html")
    |> then(&Aino.View.render_template(View, &1, "root.html", %{thoughts: thoughts}))
  end
end

defmodule Blabber.Web.Page.View do
  require Aino.View
  import Temple
  import Blabber.Web.Components

  def simple_render("root.html", assigns) do
    temple do
      h1 class: "text-2xl", do: "Welcome to Blabber"

      div class: "border border-black" do
        form action: Blabber.Web.Handler.Routes.create_path(@token), method: "POST" do
          label do
            div do: "Author"
            c &text_input/1, name: "author", class: "text-blue-500"
          end

          label do
            div do: "Thought"
            textarea(name: "body")
          end

          div do
            input(type: "submit", value: "blab")
          end
        end
      end

      c &thought_list/1, thoughts: @thoughts do
        slot :default, %{thought: thought} do
          span do: "@#{thought.author}"

          p class: "font-semibold text-lg" do
            thought.body
          end

          p class: "text-xs" do
            "motch"
            thought.mitch
          end

          form action: Blabber.Web.Handler.Routes.delete_path(@token, id: thought.id),
               method: "POST" do
            input(type: "hidden", name: "_method", value: "delete")
            input(type: "submit", value: "Delete")
          end
        end
      end
    end
  end
end
