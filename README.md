# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

# Baccaruby

  Baccarat implementation in ruby.

  ```ruby
  n_decks = 6
  cards = (Deck.new(BaccaratRules::CARD_VALUES).cards * n_decks).shuffle
  b = Baccarat.new(cards)
  b.play
  b.print
  ```

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
