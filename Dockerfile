FROM denoland/deno:alpine-1.27.0 AS deno

FROM docker:latest
COPY --from=deno /bin/deno /usr/local/bin/deno
COPY --from=deno /usr/glibc-compat /usr/glibc-compat
COPY --from=deno /lib/* /lib/
COPY --from=deno /lib64/* /lib64/
COPY --from=deno /usr/lib/* /usr/lib/

COPY mod.ts /root/mod.ts
WORKDIR /root
CMD deno run --allow-run=docker --allow-env=PORT,SECRET,CONTAINER,IMAGE --allow-net=0.0.0.0:$PORT /root/mod.ts