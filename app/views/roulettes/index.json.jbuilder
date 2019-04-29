json.set! :data do
  json.array! @roulettes do |roulette|
    json.partial! 'roulettes/roulette', roulette: roulette
    json.url  "
              #{link_to 'Show', roulette }
              #{link_to 'Edit', edit_roulette_path(roulette)}
              #{link_to 'Destroy', roulette, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end