.PHONY: help up down restart logs logs-follow clean build dev-up dev-down dev-build

help: ## このヘルプメッセージを表示
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

up: ## アプリケーションを起動
	docker compose up -d

down: ## アプリケーションを停止
	docker compose down

restart: ## アプリケーションを再起動
	docker compose restart

logs: ## ログを表示
	docker compose logs

logs-follow: ## ログをフォロー表示
	docker compose logs -f

clean: ## すべてのコンテナとボリュームを削除
	docker compose down -v
	@echo "すべてのデータが削除されました"

build: ## イメージを再ビルド
	docker compose build --no-cache

dev-up: ## 開発環境を起動（ソースからビルド）
	docker compose -f docker-compose.dev.yml up -d --build

dev-down: ## 開発環境を停止
	docker compose -f docker-compose.dev.yml down

dev-build: ## 開発環境のイメージを再ビルド
	docker compose -f docker-compose.dev.yml build --no-cache

status: ## コンテナの状態を確認
	docker compose ps

check-custom: ## カスタムファイルの確認
	@echo "=== Custom ディレクトリの確認 ==="
	@if [ -d custom ]; then \
		echo "✅ customディレクトリが存在します"; \
		ls -lh custom/; \
	else \
		echo "❌ customディレクトリが見つかりません"; \
	fi
