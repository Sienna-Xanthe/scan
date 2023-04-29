defmodule Scan.Accounts.UserToken do
  use Ecto.Schema
  # import Ecto.Changeset

  # @hash_algorithm :sha256
  @rand_size 32

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "user_tokens" do
    field :context, :string
    field :sent_to, :string
    field :token, :binary
    field :user_id, :binary_id

    timestamps()
  end

  def build_email_token(user, context) do
    build_hashed_token(user, context, user.email)
  end

  defp build_hashed_token(user, context, sent_to) do
    token = Phoenix.Token.encrypt(ScanWeb.Endpoint, "user_token", user.email)

    {token,
     %Scan.Accounts.UserToken{
       token: token,
       context: context,
       sent_to: sent_to,
       user_id: user.id
     }}

    # token = :crypto.strong_rand_bytes(@rand_size)
    # hashed_token = :crypto.hash(@hash_algorithm, token)

    # {Base.url_encode64(token, padding: false),
    #  %Scan.Accounts.UserToken{
    #    token: hashed_token,
    #    context: context,
    #    sent_to: sent_to,
    #    user_id: user.id
    #  }}
  end
end
