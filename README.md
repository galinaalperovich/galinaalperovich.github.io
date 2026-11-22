# galinaalperovich.github.io

Personal site of Galina Alperovich: https://galinaalperovich.github.io

Built with [al-folio](https://github.com/alshedivat/al-folio) (MIT) and deployed by GitHub Actions (`.github/workflows/deploy.yml`) to the `gh-pages` branch.

## Adding a post

Create `_posts/YYYY-MM-DD-short-name.md`:

```yaml
---
layout: post
title: "Post title"
date: 2026-11-20
description: One or two sentences shown in the post lists.
tags: [ai-agents]
thumbnail: assets/img/posts/short-name.png   # picture shown in the lists (3:2 works best, e.g. 1200x800)
redirect: https://example.com/post            # optional: link to a post hosted elsewhere
read_time: 15                                 # optional: minutes, overrides the estimate
---
```

## Comments

Posts hosted on this site get a [giscus](https://giscus.app) comment box (set in `_config.yml`, on for all posts). Comments are stored in this repo's GitHub Discussions, category "Announcements". The giscus GitHub app must be installed on this repo: https://github.com/apps/giscus

## Changes to the al-folio starter

- `_includes/latest_posts.liquid` overrides the theme's version: the home page's "latest posts" list shows each post's `thumbnail` and `description`.
- `_pages/blog.md` accepts `read_time:` and uses the post title as the picture's alt text.
- The demo content, the extra workflows and the theme's own docs and tests were removed.
