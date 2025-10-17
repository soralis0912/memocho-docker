# Custom ディレクトリ

このディレクトリでMemochōの見た目と動作をカスタマイズできます。

## ファイル説明

### style.css
カスタムCSSスタイル。Memochōのデフォルトスタイルを上書きできます。

### addon.js
カスタムJavaScriptコード。追加機能やキーボードショートカットを実装できます。

## 使い方

1. `style.css` または `addon.js` を編集
2. コンテナを再起動して変更を反映:
   ```bash
   docker compose restart memocho
   ```
3. ブラウザをリロードして確認

## サンプル機能

各ファイルにサンプルコードがコメントアウトされています。
使用したい機能のコメントを外して使用してください。

### style.css のサンプル
- ダークテーマのカスタマイズ
- 配色の変更
- ハイライトカラーの変更

### addon.js のサンプル
- 文字数・行数カウンター
- カスタムキーボードショートカット（クリア機能）
- タイムスタンプ挿入機能

## カスタマイズ例

### 例1: フォントサイズを変更

```css
/* style.css */
code, #snippet {
    font-size: 14pt !important;
}
```

### 例2: テーマカラーを変更

```css
/* style.css */
:root {
    --primary-color: #ff6b6b;
}

#name-label {
    color: var(--primary-color) !important;
}

.submit:active {
    background: var(--primary-color) !important;
}
```

### 例3: 自動保存機能を追加

```javascript
// addon.js
let autoSaveTimer;
window.addEventListener('load', function() {
    const textarea = document.querySelector('.textarea');
    if (textarea && textarea.tagName === 'TEXTAREA') {
        textarea.addEventListener('input', function() {
            clearTimeout(autoSaveTimer);
            autoSaveTimer = setTimeout(function() {
                console.log('自動保存...');
                localStorage.setItem('memocho_draft', textarea.value);
            }, 1000);
        });
        
        // ページロード時に復元
        const draft = localStorage.getItem('memocho_draft');
        if (draft && !textarea.value) {
            textarea.value = draft;
        }
    }
});
```

## 注意事項

- CSSで `!important` を使用すると、デフォルトスタイルを確実に上書きできます
- JavaScriptでDOM操作を行う場合は、要素が存在するか確認してください
- 変更後は必ずブラウザをリロードしてください
- 大きな変更を行う前にバックアップを取ることをお勧めします

## トラブルシューティング

### 変更が反映されない

1. コンテナを再起動
   ```bash
   docker compose restart memocho
   ```

2. ブラウザのキャッシュをクリア
   - Chrome/Edge: `Ctrl+Shift+Delete`
   - Firefox: `Ctrl+Shift+Delete`
   - Safari: `Cmd+Option+E`

3. ハードリロード
   - Chrome/Firefox: `Ctrl+Shift+R` (Mac: `Cmd+Shift+R`)
   - Safari: `Cmd+Option+R`

### JavaScriptエラーが発生する

1. ブラウザの開発者ツール（F12）でコンソールを確認
2. エラーメッセージを確認して修正
3. 構文エラーがないか確認

### ファイルが読み込まれない

1. ファイル名が正しいか確認
   - `style.css` (sではなくstyle)
   - `addon.js` (addonsではなくaddon)

2. ファイルのパーミッションを確認
   ```bash
   ls -la custom/
   chmod 644 custom/*.css custom/*.js
   ```

3. Dockerボリュームマウントを確認
   ```bash
   docker compose exec memocho ls -la /usr/src/app/custom/
   ```

## 参考リンク

- [Memochō 公式リポジトリ](https://github.com/SitiSchu/memocho)
- [CSS リファレンス (MDN)](https://developer.mozilla.org/ja/docs/Web/CSS)
- [JavaScript リファレンス (MDN)](https://developer.mozilla.org/ja/docs/Web/JavaScript)
