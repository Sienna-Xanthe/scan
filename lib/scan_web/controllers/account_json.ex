defmodule ScanWeb.AccountJSON do
  def show(%{user: user}) do
    %{
      user_id: user.id,
      email: user.email
    }
  end
end
