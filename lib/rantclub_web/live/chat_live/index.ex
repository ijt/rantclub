defmodule RantclubWeb.ChatLive.Index do
  use RantclubWeb, :live_view

  alias Rantclub.Chats
  alias Rantclub.Chats.Chat

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :chats, list_chats())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Chat")
    |> assign(:chat, Chats.get_chat!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Chat")
    |> assign(:chat, %Chat{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Chats")
    |> assign(:chat, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    chat = Chats.get_chat!(id)
    {:ok, _} = Chats.delete_chat(chat)

    {:noreply, assign(socket, :chats, list_chats())}
  end

  @impl true
  def handle_event("send-chat", %{"msg" => msg, "username" => username}, socket) do
    {:ok, c} = Chats.create_chat(%{username: username, body: msg})
    cs = socket.assigns.chats
    cs = cs ++ [c]
    socket = assign(socket, :chats, cs)
    {:noreply, socket}
  end

  defp list_chats do
    Chats.list_chats()
  end
end
