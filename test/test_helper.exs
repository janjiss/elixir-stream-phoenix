# Create the database, run migrations, and start the test transaction.
Mix.Task.run "ecto.create", ["--quiet"]
Mix.Task.run "ecto.migrate", ["--quiet"]
ExUnit.start
