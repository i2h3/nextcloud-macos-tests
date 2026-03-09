#  Nextcloud Desktop Client End-to-End Tests on macOS

This is an experiment for now.
It uses macOS accessibility features to automatically control the client and Finder which runs against a live Nextcloud test server.

## Scope

- These tests assume that there is one client app bundle to test at `/Applications/Nextcloud.app` and only verifies that its version equals the expected version specified through an argument or environment variable
- These tests assume that there is one Nextcloud server to run against which is specified through an argument or an environment variable, including the account details

Managing different Nextcloud server versions or client versions is out of scope.
That is responsibility of a higher layer project which uses this one to run different client versions against different server versions on different macOS releases.
Though, that layer still needs to be implemented, so it might also end up as part of this repository.
I will see.

## License
 
 See [LICENSE](LICENSE).
