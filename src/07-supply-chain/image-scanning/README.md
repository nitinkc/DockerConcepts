# Lab: Image Scanning & Pipeline Gates

Turn a scanner report into a deploy decision.

## Tasks

Work through `commands.sh` TODOs (solution in `solution/commands.sh`).

## What to notice

- The same app on alpine vs distroless: finding count is a direct function
  of how much OS you shipped. Small image = small CVE list — security by
  subtraction.
- `--exit-code 1` is what makes it a *gate* instead of a report nobody
  reads. In the `gitlab-spring-app-flux` pipeline this becomes a dedicated
  scan job that blocks `deploy:*`.
- `--ignore-unfixed` matters in real pipelines: you'll otherwise gate on
  CVEs that have no patch yet.

## Practice from memory

Close this file and answer: which flag gates, which flag filters severity,
which flag suppresses unfixable noise? Rebuild the gate command blind.
