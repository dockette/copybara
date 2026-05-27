<h1 align=center>Dockette / Copybara</h1>

<p align=center>
   <a href="https://github.com/dockette/copybara/actions"><img src="https://github.com/dockette/copybara/actions/workflows/docker.yml/badge.svg" alt="GitHub Actions"></a>
   <a href="https://hub.docker.com/r/dockette/copybara"><img src="https://img.shields.io/docker/pulls/dockette/copybara.svg" alt="Docker Hub pulls"></a>
   <a href="https://github.com/sponsors/f3l1x"><img src="https://img.shields.io/badge/sponsor-GitHub%20Sponsors-ea4aaa" alt="GitHub Sponsors"></a>
   <a href="https://github.com/orgs/dockette/discussions"><img src="https://img.shields.io/badge/support-discussions-6f42c1" alt="Support/Discussions"></a>
</p>

<p align=center>
   Docker image for <a href="https://github.com/google/copybara">Google Copybara</a>.
   Uses upstream weekly snapshot releases and keeps the default Docker workflow simple.
</p>

-----

## Usage

```bash
docker run --rm -it \
  -v "$(pwd)":/usr/src/app \
  dockette/copybara:latest
```

This runs the default command:

```bash
copybara migrate copy.bara.sky
```

## Documentation

### Included tools

Java 21, Copybara, git, Mercurial, Quilt, OpenSSH client, buildifier, buildozer.

### Override command

Run Copybara directly with your own arguments:

```bash
docker run --rm -it \
  -v "$(pwd)":/usr/src/app \
  dockette/copybara:latest validate copy.bara.sky
```

### Environment variables

The image supports the same `COPYBARA_*` environment variables as the upstream Docker wrapper.

```bash
docker run --rm -it \
  -e COPYBARA_SUBCOMMAND=validate \
  -e COPYBARA_CONFIG=copy.bara.sky \
  -e COPYBARA_WORKFLOW=default \
  -v "$(pwd)":/usr/src/app \
  dockette/copybara:latest
```

Supported variables:

- `COPYBARA_SUBCOMMAND`
- `COPYBARA_CONFIG`
- `COPYBARA_WORKFLOW`
- `COPYBARA_SOURCEREF`
- `COPYBARA_OPTIONS`

### Git and SSH credentials

If your origin or destination uses SSH, mount your git config, SSH directory, and SSH agent socket:

```bash
docker run --rm -it \
  -v ~/.gitconfig:/root/.gitconfig:ro \
  -v ~/.ssh:/root/.ssh \
  -v ${SSH_AUTH_SOCK}:${SSH_AUTH_SOCK} \
  -e SSH_AUTH_SOCK=${SSH_AUTH_SOCK} \
  -v "$(pwd)":/usr/src/app \
  dockette/copybara:latest
```

### Notes

- The image follows upstream guidance and ships the prebuilt weekly snapshot jar.
- Copybara expects your config file, such as `copy.bara.sky`, to be available inside `/usr/src/app`.
- Snapshot versions can be updated by changing `COPYBARA_VERSION` and `COPYBARA_SHA256` in `latest/Dockerfile`.

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to [support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
