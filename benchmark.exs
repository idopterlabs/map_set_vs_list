Mix.install([:jason, :benchee])

defmodule ListLookup do
  @bands_list File.read!("bands.json") |> Jason.decode!()

  def has_band?(band) do
    band in @bands_list
  end
end

defmodule MapSetLookup do
  @bands_map_set File.read!("bands.json") |> Jason.decode!() |> MapSet.new()

  def has_band?(band) do
    band in @bands_map_set
  end
end

Benchee.run(
  %{
    "list" => fn ->
      _has_metallica = ListLookup.has_band?("Metallica")
      _has_bananas = ListLookup.has_band?("bananas")
    end,
    "MapSet" => fn ->
      _has_metallica = MapSetLookup.has_band?("Metallica")
      _has_bananas = MapSetLookup.has_band?("bananas")
    end
  },
  time: 10,
  memory_time: 2
)
