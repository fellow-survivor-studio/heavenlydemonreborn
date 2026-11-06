#!/bin/sh
# Cloudflare Workers build for https://fellowsurvivor.com/heavenlydemonreborn/
# Copies the tracked files that GitHub Pages publishes into
# .cf-dist/heavenlydemonreborn/, so Cloudflare serves them under
# /heavenlydemonreborn/. Source, generator and internal docs are left out.
# wrangler.jsonc runs this before every deploy.
# Needs git and GNU cp (Cloudflare's Linux build image has both).
set -eu
cd "$(dirname "$0")/.."

out=.cf-dist/heavenlydemonreborn
rm -rf .cf-dist
mkdir -p "$out"

git ls-files -z -- . \
  ':!README.md' ':!content/' ':!docs/' ':!scripts/' ':!.gitignore' ':!.gitattributes' ':!wrangler.jsonc' \
  | xargs -0 cp --parents -t "$out"

echo "Cloudflare build: $(find "$out" -type f | wc -l) files in $out"
