#!/bin/bash

set -e

echo "🚀 Memochō Docker セットアップを開始します..."
echo ""

# 色の定義
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Dockerの確認
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Dockerがインストールされていません${NC}"
    echo "Docker Desktop をインストールしてください: https://www.docker.com/products/docker-desktop"
    exit 1
fi

if ! command -v docker compose &> /dev/null; then
    echo -e "${RED}❌ Docker Composeがインストールされていません${NC}"
    echo "Docker Compose をインストールしてください"
    exit 1
fi

echo -e "${GREEN}✅ Docker と Docker Compose が見つかりました${NC}"
echo ""

# .envファイルの作成
if [ ! -f .env ]; then
    echo -e "${YELLOW}📝 .env ファイルを作成しています...${NC}"
    cp .env.example .env
    echo -e "${GREEN}✅ .env ファイルを作成しました${NC}"
else
    echo -e "${YELLOW}ℹ️  .env ファイルは既に存在します${NC}"
fi
echo ""

# customディレクトリの確認
if [ -d custom ]; then
    echo -e "${GREEN}✅ custom ディレクトリが見つかりました${NC}"
    if [ ! -f custom/style.css ] || [ ! -f custom/addon.js ]; then
        echo -e "${YELLOW}⚠️  カスタムファイルが不足しています。README.mdを参照してください${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  custom ディレクトリが見つかりません${NC}"
    echo -e "${YELLOW}   Gitから正しくクローンされているか確認してください${NC}"
fi
echo ""

# Dockerイメージのpull
echo -e "${YELLOW}📦 Dockerイメージをダウンロードしています...${NC}"
docker compose pull || true
echo ""

# コンテナの起動
echo -e "${YELLOW}🔄 コンテナを起動しています...${NC}"
docker compose up -d

# 起動待機
echo ""
echo -e "${YELLOW}⏳ サービスが起動するまで待機しています...${NC}"
sleep 5

# ヘルスチェック
MAX_RETRIES=30
RETRY_COUNT=0
while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    if docker compose ps | grep -q "healthy"; then
        break
    fi
    echo -n "."
    sleep 2
    RETRY_COUNT=$((RETRY_COUNT + 1))
done
echo ""

if [ $RETRY_COUNT -eq $MAX_RETRIES ]; then
    echo -e "${RED}⚠️  サービスの起動に時間がかかっています${NC}"
    echo "ログを確認してください: docker compose logs"
else
    echo -e "${GREEN}✅ サービスが正常に起動しました！${NC}"
fi

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}🎉 セットアップが完了しました！${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "📍 アクセス: ${GREEN}http://localhost:4000${NC}"
echo ""
echo "💡 便利なコマンド:"
echo "  ログを見る:       docker compose logs -f"
echo "  停止:             docker compose down"
echo "  再起動:           docker compose restart"
echo "  完全削除:         docker compose down -v"
echo ""
echo "  または Makefile を使用:"
echo "  make logs-follow  # ログを表示"
echo "  make down         # 停止"
echo "  make restart      # 再起動"
echo "  make clean        # 完全削除"
echo ""
