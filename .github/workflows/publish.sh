on:
  push:
    branches:
      - master

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - uses: octokit/request-action@v2.x
        id: publish-changes
        with:
          route: POST /repos/{owner}/{repo}/dispatches
          owner: xibosignageltd
          repo: docs-builder
          event_type: build-docs
        env:
          GITHUB_TOKEN: ${{ secrets.CI_TOKEN }}
