#!/usr/bin/env sh

set -eu

# 날짜 고정용
d="2021-12-04T00:00:00+09:00"

# 브랜치 체크
current=$(git symbolic-ref --short -q HEAD || true)
if [ "$current" != "686a" ]; then
  echo "Error: on branch '${current:-detached HEAD}', expected default branch" >&2
  exit 1
fi

cd "$(git rev-parse --show-toplevel)"

git add -A
git reset --soft "$(git rev-list --max-parents=0 HEAD)"
GIT_AUTHOR_DATE="$d" GIT_COMMITTER_DATE="$d" git commit --amend --reset-author -q -m "🔮"
git push --force-with-lease origin 686a

