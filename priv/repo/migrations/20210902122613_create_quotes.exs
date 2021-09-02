defmodule Quotes.Repo.Migrations.CreateQuotes do
  use Ecto.Migration

  def change do
    create table(:quotes) do
      add :username, :string
      add :text, :string
      add :likes, :integer
      add :reposts, :integer

      timestamps()
    end

  end
end
