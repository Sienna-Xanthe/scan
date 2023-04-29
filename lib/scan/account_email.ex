defmodule Scan.AccountEmail do
  import Swoosh.Email
  alias Scan.Mailer

  def deliver_confirmation_instructions(user, url) do
    template_params = [
      header: "Hi #{user.email},",
      body: "You can confirm your account by visiting the url below:",
      url: url,
      footer: "If you didn't create an account with us, please ignore this."
    ]

    deliver(user.email, "Account confirmation", template_params) |> IO.inspect()
  end

  defp deliver(to, subject, template_params) do
    new()
    |> from("joeywdz@gmail.com")
    |> to(to)
    |> subject(subject)
    |> text_body(Mailer.text_template(template_params))
    |> html_body(Mailer.html_template(template_params))
    |> Mailer.deliver()
  end
end
