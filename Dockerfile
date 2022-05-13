FROM rust:1.59 AS builder

RUN USER=root cargo new --bin rust_cdk
WORKDIR /rust_cdk

COPY ./Cargo.lock ./Cargo.lock
COPY ./Cargo.toml ./Cargo.toml

RUN cargo build --release
RUN rm src/*.rs

COPY ./src ./src

RUN rm ./target/release/deps/rust_cdk*
RUN cargo build --release

FROM debian:buster-slim

COPY --from=builder /rust_cdk/target/release/rust_cdk .
EXPOSE 8080
CMD ["./rust_cdk"]