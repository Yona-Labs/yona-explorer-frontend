FROM node:24-trixie-slim AS base

ENV PNPM_VERSION=10.23.0

RUN corepack enable pnpm



FROM base AS deps

WORKDIR /build

COPY package*.json pnpm-lock.yaml* .npmrc* ./

RUN pnpm i --frozen-lockfile



FROM base AS builder

ARG NEXT_PUBLIC_MAINNET_RPC_URL="https://api.mainnet-beta.solana.com" \
    NEXT_PUBLIC_TESTNET_RPC_URL="https://api.testnet.solana.com" \
    NEXT_PUBLIC_DEVNET_RPC_URL="http://v01.ll.yona.network:8899"

ENV NEXT_PUBLIC_MAINNET_RPC_URL=${NEXT_PUBLIC_MAINNET_RPC_URL} \
    NEXT_PUBLIC_TESTNET_RPC_URL=${NEXT_PUBLIC_TESTNET_RPC_URL} \
    NEXT_PUBLIC_DEVNET_RPC_URL=${NEXT_PUBLIC_DEVNET_RPC_URL}

WORKDIR /build

COPY --from=deps /build/node_modules ./node_modules

COPY . .

RUN pnpm run build \
    && rm -rf /build/.next/cache


FROM base AS app

WORKDIR /app

ENV HOME=/app \
    PORT=3000 \
    NODE_OPTIONS="--max-old-space-size=2048"

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=deps /build/package.json ./
COPY --from=deps /build/node_modules ./node_modules
COPY --from=builder /build/public ./public
COPY --from=builder --chown=nextjs:nodejs /build/.next ./.next

RUN chown nextjs:nodejs /app

USER nextjs

EXPOSE $PORT

CMD ["pnpm", "start"]
