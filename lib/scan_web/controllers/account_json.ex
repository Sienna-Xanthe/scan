defmodule ScanWeb.AccountJSON do
  def show(%{user: user}) do
    %{
      user_id: user.id,
      email: user.email
    }
  end

  def user_token(%{user: user, token: token}) do
    %{
      user_id: user.id,
      email: user.email,
      token: token
    }
  end
end
