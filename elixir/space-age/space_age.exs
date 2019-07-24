defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float

  @earth_year 31_557_600
  @planet_age %{
    mercury: 0.2408467,
    venus: 0.61519726,
    mars: 1.8808158,
    jupiter: 11.862615,
    saturn: 29.447498,
    uranus: 84.016846,
    neptune: 164.79132
  }
  def age_on(planet, seconds) do
    planet
    |> age_on_planet(seconds)
    |> Float.round(2)
  end

  defp age_on_planet(:earth, seconds), do: (seconds / @earth_year)
  defp age_on_planet(planet, seconds) do
    age_on_planet(:earth, seconds) / @planet_age[planet]
  end
end
