defmodule Rantclub.Repo.Migrations.CreateChats do
  use Ecto.Migration

  def change do
    create table(:chats) do
      add :username, :string
      add :body, :string

      timestamps()
    end

  end
end
