<!-- markdownlint-disable-next-line -->
<div align="center">

  <!-- markdownlint-disable-next-line -->
  # [Chirpy Jekyll Theme](docs/README.md)

  A minimal, responsive, and feature-rich Jekyll theme for technical writing.

  ![Devices Mockup](/docs/images/devices-mockup.png)

</div>

---

## Manual

Tutorial
- [Getting Started](docs/manual//2019-08-09-getting-started.md)
- [Customize the Favicon](docs/manual//2019-08-11-customize-the-favicon.md)
- [Writing a New Post](docs/manual//2019-08-08-write-a-new-post.md)

Showcase
- [Text and Typography](docs/manual//2019-08-08-text-and-typography.md)

## Makefile

`DEST = _site`

- `install`: Install dependencies (Gemfile)
- `serve`: Start local preview server (includes drafts)
- `build`: Build static files to the $(DEST) directory
- `clean`: Remove build cache and generated files
- `deploy`: Build and push to production environment
