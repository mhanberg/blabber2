defmodule Blabber.Web.Components do
  import Temple

  def text_input(assigns) do
    temple do
      input type: "text", name: @name, class: assigns[:class]
    end
  end

  def thought_list(assigns) do
    temple do
      for thought <- @thoughts do
        div class: "border border-black" do
          slot :default, thought: Map.merge(thought, %{mitch: "was here"})
        end
      end
    end
  end
end
