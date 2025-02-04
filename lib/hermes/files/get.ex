defmodule Hermes.Files.Get do
  @moduledoc """
  ...

  Module to retrieve from s3
  """

  alias Hermes.Video
  alias ExAws.S3

  @doc """
  ...

  Gets the file url from the s3 bucket
  """
  def get_url(file) do
    Video.url(file, :original)
  end

  @doc """
  ...

  Gets the file from s3

  ## params

  - file_key: String
  """
  def get_file(file_key) do
    case S3.get_object(System.get_env("BUCKET"), "uploads/#{file_key}") |> ExAws.request() do
      {:ok, %{body: body}} ->
        {:ok, body}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
