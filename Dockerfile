FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    pkg-config \
    libssl-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN sh -c "$(curl -sSfL https://release.solana.com/stable/install)"

ENV PATH="/root/.local/share/solana/install/active_release/bin:${PATH}"

EXPOSE 8899

ENTRYPOINT ["sh", "-c", "\
RPC_URL='https://api.mainnet-beta.solana.com'; \
echo 'Starting Solana validator using mainnet...'; \
exec solana-test-validator \
  --url \"$RPC_URL\" \
  --rpc-port 8899 \
  --bind-address 0.0.0.0 \
"]