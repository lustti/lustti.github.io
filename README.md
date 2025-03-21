# [worklt.tech](https://worklt.tech/)

Working on Loving Technology...
- AI: Deep learning, Transformer, Stable difffusion, whisper
- Physics: Fluid Dynamics, Biophysics
- ...


## 文件目录
- 代码：[src](src)
- 推文：[_posts](_posts)
- 书籍：[_books](_books)
- 静态文件：[assets](assets) -> 包含图片等二进制文件

## Workflow（Start from branch `main`）
> - branch `main`: New and edit Markdown files content branch.
> - branch `build`: You Jekyll theme or others generattor code branch.
> - branch `pages`: Generated original website results.

```mermaid
---
config:
  maxHeight: 100%
---
flowchart TD
    Main-1(New or Edit Markdown Files in *main*)-->Main-2[Commit and push]
    Main-2-->|Switch to branch *build*| Build-1(cherry-pick from *main*)
    Build-1 -->|Update Markdown Files| Build-2{Is new article?}
    Build-2 -->|Yes| Build-3[Modify markdown files to fit jekyll theme]
    Build-2 -->|Not| Build-4[Update the same markdown file]
    Build-3 --> Build-5
    Build-4 --> Build-5[Test: <br>*bundle exec jekyll s -l* <br>to preview and check the changes]
    Build-5 --> Build-6{Is the preview correct?}
    Build-6 -->|Yes| Build-7[Commit and push]
    Build-6 -->|Not| Build-4
    Build-7 --> Build-8[Build: <br>*bundle exec jekyll b* <br>to build the website]
    Build-8 --> |*cd _site* <br>go into branch *pages* in directory *_site*| Pages-1{check the changes, <br>is it correct ?}
    Pages-1 --> |Yes| Build-4
    Pages-1 --> |Yes| Pages-2[Commit and push]
    Pages-2 --> Pages-3[Check the changes on the *worklt.tech*]
    Pages-3 --> Pages-4{Is the view correct?}
    Pages-4 -->|Not| Build-4
    Pages-4 -->|Yes| N(Done)
```
