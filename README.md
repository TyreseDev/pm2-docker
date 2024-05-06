# Unofficial PM2 Docker Images

This repository houses unofficial Docker images for PM2, the advanced, production process manager for Node.js. These images are built as newer versions are released and the official [keymetrics/pm2](https://github.com/keymetrics/pm2-docker) repository is no longer maintained.

**Disclaimer**: This is an unofficial repository and not directly affiliated with or endorsed by the official PM2 or Keymetrics teams.

## Supported Tags and Respective Dockerfile Links

**Alpine:**
- `22`, `22-alpine`, `latest-alpine`, `latest` - [Alpine Dockerfile](https://github.com/TyreseDev/pm2-docker/tree/main/tags/22/alpine/Dockerfile)
- `20`, `20-alpine` - [Alpine Dockerfile](https://github.com/TyreseDev/pm2-docker/tree/main/tags/20/alpine/Dockerfile)
- `18`, `18-alpine` - [Alpine Dockerfile](https://github.com/TyreseDev/pm2-docker/tree/main/tags/18/alpine/Dockerfile)
- `16`, `16-alpine` - [Alpine Dockerfile](https://github.com/TyreseDev/pm2-docker/tree/main/tags/16/alpine/Dockerfile)

**Bookworm:**
- `22-bookworm`, `latest-bookworm` - [Bookworm Dockerfile](https://github.com/TyreseDev/pm2-docker/tree/main/tags/22/bookworm/Dockerfile)
- `20-bookworm` - [Bookworm Dockerfile](https://github.com/TyreseDev/pm2-docker/tree/main/tags/20/bookworm/Dockerfile)
- `18-bookworm` - [Bookworm Dockerfile](https://github.com/TyreseDev/pm2-docker/tree/main/tags/18/bookworm/Dockerfile)
- `16-bookworm` - [Bookworm Dockerfile](https://github.com/TyreseDev/pm2-docker/tree/main/tags/16/bookworm/Dockerfile)

**Slim:**
- `22-slim`, `latest-slim` - [Slim Dockerfile](https://github.com/TyreseDev/pm2-docker/tree/main/tags/22/slim/Dockerfile)
- `20-slim` - [Slim Dockerfile](https://github.com/TyreseDev/pm2-docker/tree/main/tags/20/slim/Dockerfile)
- `18-slim` - [Slim Dockerfile](https://github.com/TyreseDev/pm2-docker/tree/main/tags/18/slim/Dockerfile)
- `16-slim` - [Slim Dockerfile](https://github.com/TyreseDev/pm2-docker/tree/main/tags/16/slim/Dockerfile)

## Usage

To use these Docker images, you can pull them directly from Docker Hub and use them in your Dockerfiles or docker-compose files.

### Dockerfile Example

```Dockerfile
FROM tyrese3915/pm2:latest

# Your application's setup
COPY . /app
WORKDIR /app

# Install dependencies and build your app
RUN npm install

# Start your app using PM2
CMD ["pm2-runtime", "start", "ecosystem.config.js"]
```

### docker-compose Example

```yaml
version: '3.8'
services:
  app:
    image: tyrese3915/pm2:latest
    volumes:
      - .:/app
    working_dir: /app
    command: pm2-runtime start ecosystem.config.js
```

## Building from Source

For those interested in building their own image from this repository, you can clone the repository and build using Docker commands.

```sh
git clone https://github.com/tyrese3915/pm2-docker.git
cd pm2-docker
bash build-and-push.sh
```

## Contributing

Contributions to improve the images or add new versions are welcome! Please submit an issue or pull request with your suggestions.

## License

This project is under [MIT License](LICENSE) - see the LICENSE file for details.

## Acknowledgments

- Thanks to the PM2 team for their excellent process manager.
- This project is inspired by the official but no longer maintained [keymetrics/pm2](https://github.com/keymetrics/docker-pm2) repository.
