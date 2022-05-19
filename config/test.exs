import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :dot_viz, DotVizWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "cwaSDEn8DbLdInr4ZVs+l/h9JqMD57UKIaW1/GX9a8F8ke1Pkm+UBvbak9xzB9Y5",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
