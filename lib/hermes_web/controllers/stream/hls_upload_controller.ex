defmodule HermesWeb.Stream.HlsUploadController do
  @moduledoc """
  Module for livestreaming controllers.

  Receives playlist and ts files to save.

  m3u8_upload()

  ts_upload()
  """

  use HermesWeb, :controller

  alias Hermes.Stream.StreamManager

  @doc """
  Gets the index.m3u8 file to save or upload any existing index in path.
  """
  def m3u8_upload(conn, %{"key" => stream_key, "file_name" => _file_name}) do
    {:ok, body, _} = Plug.Conn.read_body(conn)

    with {:ok, _message} <- StreamManager.save_index(body, stream_key) do
      send_resp(conn, 400, "Error uploading m3u8 file")
    end
  end

  @doc """
  Uploads .ts files to path.
  """
  def ts_upload(conn, %{"key" => stream_key, "file_name" => file_name}) do
    {:ok, body, _} = Plug.Conn.read_body(conn)

    with {:ok, _message} <- StreamManager.save_ts(body, stream_key, file_name) do
      send_resp(conn, 200, "TS file uploaded")
    end
  end
end
