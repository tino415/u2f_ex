defmodule Example.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Example.Repo

  alias Example.Users.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  alias Example.Users.U2FKey
  alias U2FEx.KeyMetadata

  @spec create_u2f_key(user_id :: any(), KeyMetadata.t()) :: {:ok, U2FKey.t()} | {:error, any()}
  def create_u2f_key(user_id, %KeyMetadata{} = key_metadata) do
    attrs = %{
      public_key: key_metadata.public_key,
      key_handle: key_metadata.key_handle,
      version: Map.get(key_metadata, :version, nil),
      app_id: key_metadata.app_id,
      user_id: user_id
    }

    %U2FKey{}
    |> U2FKey.changeset(attrs)
    |> Repo.insert()
  end
end
