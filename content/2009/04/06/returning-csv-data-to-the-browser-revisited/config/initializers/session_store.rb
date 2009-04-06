# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ttt_session',
  :secret      => 'c0fa63ee886ceb991c5ec8f98b7c2feeda67fee3771b675f1b1c91afd736c8a986a0ef2a9226cecb94d80ecd09a0e44a8f43623339058a7ec46891c86f551167'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
