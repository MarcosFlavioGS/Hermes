defmodule HermesWeb.Files.FilesController do
  @moduledoc """
    This module is responsable for controllers for uploading files to the S3 Bucket.
  """

  use HermesWeb, :controller

  alias Hermes.Video

  @doc """
  Gets a video file and uploads to s3 using the waffle module
  """
  def upload(conn, %{"video" => %Plug.Upload{} = file}) do
    case Video.store(file) do
      {:ok, response} ->
        conn
        |> put_status(:ok)
        |> json(%{message: "file uploaded", file: response})

      {:error, message} ->
        conn
        |> put_status(:bad_request)
        |> json(%{message: "error sending file to S3: #{message}"})
    end
  end
end
