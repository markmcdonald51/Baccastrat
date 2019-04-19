#json.partial! "simulations/simulation", simulation: @simulation

#json.array! @simulation.games, :id, :winner, remote: true
