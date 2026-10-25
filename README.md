<h1 align=center>Dockette / Copybara</h1>

<p align=center>
   <a href="https://github.com/dockette/copybara/actions"><img src="https://github.com/dockette/copybara/actions/workflows/docker.yml/badge.svg" alt="GitHub Actions"></a>
   <a href="https://hub.docker.com/r/dockette/copybara"><img src="https://img.shields.io/docker/pulls/dockette/copybara.svg" alt="Docker Hub pulls"></a>
   <a href="https://github.com/sponsors/f3l1x"><img src="https://img.shields.io/badge/sponsor-GitHub%20Sponsors-ea4aaa" alt="GitHub Sponsors"></a>
   <a href="https://github.com/orgs/dockette/discussions"><img src="https://img.shields.io/badge/support-discussions-6f42c1" alt="Support/Discussions"></a>
</p>

<p align=center>
   Docker image for <a href="https://github.com/google/copybara">Google Copybara</a>.
</p>

-----

[Google Copybara](https://github.com/google/copybara) moves code between repositories. This image ships the prebuilt
weekly snapshot jar, as upstream recommends.

## Features

- Copybara `v20260921` (weekly snapshot)
- Java 25, git, Mercurial, Quilt, OpenSSH client, buildifier, buildozer
- Same `COPYBARA_*` environment variables as the upstream Docker wrapper
- Default command is `copybara migrate copy.bara.sky`; your config file must be inside `/usr/src/app`

## Usage

```sh
# Run the default command
docker run --rm -it -v "$(pwd)":/usr/src/app dockette/copybara:latest

# Run Copybara with your own arguments
docker run --rm -it -v "$(pwd)":/usr/src/app dockette/copybara:latest validate copy.bara.sky

# Or use environment variables
docker run --rm -it \
  -e COPYBARA_SUBCOMMAND=validate \
  -e COPYBARA_CONFIG=copy.bara.sky \
  -e COPYBARA_WORKFLOW=default \
  -v "$(pwd)":/usr/src/app \
  dockette/copybara:latest
```

## Configuration

Supported variables: `COPYBARA_SUBCOMMAND`, `COPYBARA_CONFIG`, `COPYBARA_WORKFLOW`, `COPYBARA_SOURCEREF`,
`COPYBARA_OPTIONS`.

If the origin or destination uses SSH, mount your git config, SSH directory and SSH agent socket:

```sh
docker run --rm -it \
  -v ~/.gitconfig:/root/.gitconfig:ro \
  -v ~/.ssh:/root/.ssh \
  -v ${SSH_AUTH_SOCK}:${SSH_AUTH_SOCK} \
  -e SSH_AUTH_SOCK=${SSH_AUTH_SOCK} \
  -v "$(pwd)":/usr/src/app \
  dockette/copybara:latest
```

## Versions

| Version | Release |
|---------|---------|
| `dockette/copybara:v20260921-YYYY.MM.DD` | release `YYYY.MM.DD`; pin this one |
| `dockette/copybara:v20260921` | latest release |
| `dockette/copybara:YYYY.MM.DD` | release `YYYY.MM.DD` |
| `dockette/copybara:latest` | latest build of `master` |

All versions ship Copybara `v20260921`. Releases are listed on [GitHub](https://github.com/dockette/copybara/releases).
To upgrade Copybara, change `COPYBARA_VERSION` and `COPYBARA_SHA256` in `latest/Dockerfile` and `VERSION`.

## Development

```sh
make build          # build the image for linux/amd64 and linux/arm64
make test           # check Java and the default command
make run            # run Copybara on the current directory
make version        # print VERSION
make release        # set today's date in VERSION
```

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to
[support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
