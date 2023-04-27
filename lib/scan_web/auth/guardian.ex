defmodule ScanWeb.Auth.Guardian do
  use Guardian, otp_app: :scan
  alias Scan.Accounts

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_id, _claims) do
    {:error, :id_not_provided}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_resource_by_id(id) do
      nil ->
        {:error, :resource_not_found}

      resource ->
        {:ok, resource}
    end
  end

  def resource_from_claims(_claims) do
    {:error, :resource_not_found}
  end

  def authenticate(email, password) do
    with {:ok, user} <- Accounts.get_user_by_email(email),
         true <- validate_password(password, user.hash_password),
         {:ok, token, _claims} <- encode_and_sign(user, %{}, token_options(:access)) do
      {:ok, user, token}
    else
      _error -> {:error, :unauthorized}
    end
  end

  def authenticate(token) do
    with {:ok, claims} <- decode_and_verify(token),
         {:ok, user} <- resource_from_claims(claims),
         {:ok, _old_token, {new_token, _claims}} <- refresh(token, token_options(:reset)) do
      {:ok, user, new_token}
    end
  end

  defp token_options(type) do
    case type do
      :access -> [token_type: "access", ttl: {2, :hour}]
      :reset -> [token_type: "reset", ttl: {30, :minute}]
    end
  end

  def validate_password(password, hash_password)
      when is_binary(hash_password) and byte_size(password) > 0 do
    Bcrypt.verify_pass(password, hash_password)
  end

  def validate_password(_password, _hash_password) do
    Bcrypt.no_user_verify()
    false
  end

  ### Guardian DB
  def after_encode_and_sign(resource, claims, token, _options) do
    with {:ok, _} <- Guardian.DB.after_encode_and_sign(resource, claims["typ"], claims, token) do
      {:ok, token}
    end
  end

  def on_verify(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_verify(claims, token) do
      {:ok, claims}
    end
  end

  def on_refresh({old_token, old_claims}, {new_token, new_claims}, _options) do
    with {:ok, _, _} <- Guardian.DB.on_refresh({old_token, old_claims}, {new_token, new_claims}) do
      {:ok, {old_token, old_claims}, {new_token, new_claims}}
    end
  end
end
