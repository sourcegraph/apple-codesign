FROM sourcegraph/alpine-3.14:204508_2023-03-07_4.5-e6f3babaa521@sha256:b326853131976f34993bc11ed2117879237194c974802b8ecd86f0bd63bc56c3 as downloader

WORKDIR /downloads

# # Arm
# RUN echo "f3ddaccfd8f796455503edb8743e18a8a7c4f446e0211cc4ed5330bcd9d4ef7b  apple-codesign-0.22.0-aarch64-unknown-linux-musl.tar.gz" >expected_hash && \
# curl -fsSLO 'https://github.com/indygreg/apple-platform-rs/releases/download/apple-codesign/0.22.0/apple-codesign-0.22.0-aarch64-unknown-linux-musl.tar.gz' && \
# sha256sum -c expected_hash && \
# tar -xzf apple-codesign-0.22.0-aarch64-unknown-linux-musl.tar.gz && \
# chmod 555 apple-codesign-0.22.0-aarch64-unknown-linux-musl/rcodesign

# # Intel
RUN echo "f6382c5e6e47bc4f6f02be2ad65a4fc5120b3df75aa520647abbadbae747fbcc  apple-codesign-0.22.0-x86_64-unknown-linux-musl.tar.gz" >expected_hash && \
curl -fsSLO 'https://github.com/indygreg/apple-platform-rs/releases/download/apple-codesign%2F0.22.0/apple-codesign-0.22.0-x86_64-unknown-linux-musl.tar.gz' && \
sha256sum -c expected_hash && \
tar -xzf apple-codesign-0.22.0-x86_64-unknown-linux-musl.tar.gz && \
chmod 555 apple-codesign-0.22.0-x86_64-unknown-linux-musl/rcodesign

FROM sourcegraph/alpine-3.14:204508_2023-03-07_4.5-e6f3babaa521@sha256:b326853131976f34993bc11ed2117879237194c974802b8ecd86f0bd63bc56c3

# # Arm
# COPY --from=downloader /downloads/apple-codesign-0.22.0-aarch64-unknown-linux-musl/rcodesign /bin/rcodesign

# Intel
COPY --from=downloader /downloads/apple-codesign-0.22.0-x86_64-unknown-linux-musl/rcodesign /bin/rcodesign

ENTRYPOINT ["/bin/rcodesign"]
