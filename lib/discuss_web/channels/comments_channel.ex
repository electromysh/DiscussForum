defmodule DiscussWeb.CommentsChannel do
  use DiscussWeb, :channel
  alias Discuss.Discussions.{Topic, Comment}

  @impl true
  def join("comments:" <> topic_id, _params, socket) do
    topic_id = String.to_integer(topic_id)
    topic = Discuss.Repo.get(Topic, topic_id)

    {:ok, %{}, assign(socket, :topic, topic)}
  end

   @impl true
   def handle_in(name, %{"content" => content}, socket) do
    topic = socket.assigns.topic

    changeset = topic
      |> Ecto.build_assoc(:comments)
      |> Comment.changeset(%{content: content})

    case Discuss.Repo.insert(changeset) do
      {:ok, comment} ->
        {:reply, :ok, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
   end

  # # Add authorization logic here as required.
  # defp authorized?(_payload) do
  #   true
  # end
end
