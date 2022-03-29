defmodule Issuex.Github.Issues do
  @user_agent {"User-agent", "Elixir tyyagoosantos@gmail.com"}
  @github_url Application.get_env(:issuex, :github_url)

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get([@user_agent])
    |> handle_response()
  end

  @spec issues_url(String.t(), String.t()) :: String.t()
  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  @spec handle_response({:ok, HTTPoison.Response.t()} | {:error, HTTPoison.Error.t()}) ::
          {:ok | :error, HTTPoison.body()} | {:error, any}
  defp handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, Jason.decode!(body)}
  end

  defp handle_response({:ok, %{body: body}}) do
    {:error, Jason.decode!(body)}
  end

  defp handle_response({:error, %{reason: reason}}) do
    {:error, reason}
  end
end
