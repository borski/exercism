# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []), do: Agent.start(fn -> %{next_id: 1, plots: []} end, opts)

  def list_registrations(pid), do: Agent.get(pid, fn %{plots: p} -> p end)

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn %{plots: p, next_id: id} ->
      new_plot = %Plot{plot_id: id, registered_to: register_to}
      {new_plot, %{plots: [new_plot | p], next_id: id + 1}}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn state ->
      %{state | plots: Enum.reject(state.plots, &(&1.plot_id == plot_id))}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn %{plots: p} ->
      Enum.find(p, {:not_found, "plot is unregistered"}, &(&1.plot_id == plot_id))
    end)
  end
end
