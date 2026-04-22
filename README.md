# [worklt.tech](https://worklt.tech/)

Working on Lusting Technology...
- AI: Deep learning, Transformer, Stable difffusion, whisper
- Physics: Fluid Dynamics, Biophysics
- ...


## 文件目录
- 代码：[src](src)
- 推文：[_posts](_posts)
- 书籍：[_books](_books)
- 静态文件：[assets](assets) -> 包含图片等二进制文件

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
