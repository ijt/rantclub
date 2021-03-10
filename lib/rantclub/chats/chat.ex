defmodule Rantclub.Chats.Chat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chats" do
    field :body, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(chat, attrs) do
    chat
    |> cast(attrs, [:username, :body])
    |> validate_required([:username, :body])
  end
end
