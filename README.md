<h1 align=center>Dockette / Copybara</h1>

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

## Development

See [how to contribute](https://contributte.org/contributing.html) to this package.

-----

Consider to [support](https://github.com/sponsors/f3l1x) **f3l1x**. Also thank you for using this package.
