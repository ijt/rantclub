defmodule RantclubWeb.PageLive do
  use RantclubWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, redirect(socket, to: Routes.chat_index_path(socket, :index))}
  end

end
