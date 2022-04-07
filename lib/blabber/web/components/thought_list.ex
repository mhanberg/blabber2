defmodule Blabber.Web.Components.ThoughtList do
  import Temple.Component

  render do
    for thought <- @thoughts do
      div class: "border border-black" do
        slot :default, thought: Map.merge(thought, %{mitch: "was here"})
      end
    end
  end
end
