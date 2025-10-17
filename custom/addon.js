/*
 * Memochō カスタムスクリプト
 * 
 * このファイルでMemochōの動作をカスタマイズできます。
 * 変更後は docker compose restart memocho で反映されます。
 */

/*
 * 例: 文字数カウンター
 * 以下のコメントを外して使用してください
 */

/*
window.addEventListener('load', function() {
    console.log('Memochō カスタムスクリプト読み込み完了');
    
    // 文字数カウンター
    const textarea = document.querySelector('.textarea');
    if (textarea && textarea.tagName === 'TEXTAREA') {
        // カウンター表示用の要素を作成
        const counter = document.createElement('div');
        counter.id = 'char-counter';
        counter.style.position = 'fixed';
        counter.style.bottom = '40px';
        counter.style.right = '20px';
        counter.style.padding = '10px';
        counter.style.background = 'rgba(0, 0, 0, 0.7)';
        counter.style.color = '#eee';
        counter.style.borderRadius = '5px';
        counter.style.fontSize = '12px';
        counter.style.zIndex = '1000';
        document.body.appendChild(counter);
        
        // カウント更新関数
        function updateCount() {
            const charCount = textarea.value.length;
            const lineCount = textarea.value.split('\n').length;
            counter.textContent = `${charCount} 文字 / ${lineCount} 行`;
        }
        
        // 初期表示
        updateCount();
        
        // 入力時に更新
        textarea.addEventListener('input', updateCount);
    }
});
*/

/*
 * 例: カスタムキーボードショートカット
 * 以下のコメントを外して使用してください
 */

/*
document.addEventListener('keydown', function(e) {
    // Ctrl + Shift + C でクリア
    if (e.ctrlKey && e.shiftKey && e.key === 'C') {
        const textarea = document.querySelector('.textarea');
        if (textarea && textarea.tagName === 'TEXTAREA') {
            if (confirm('内容をクリアしますか？')) {
                textarea.value = '';
                e.preventDefault();
            }
        }
    }
    
    // Ctrl + Shift + T でタイムスタンプ挿入
    if (e.ctrlKey && e.shiftKey && e.key === 'T') {
        const textarea = document.querySelector('.textarea');
        if (textarea && textarea.tagName === 'TEXTAREA') {
            const timestamp = new Date().toISOString();
            const start = textarea.selectionStart;
            const end = textarea.selectionEnd;
            const text = textarea.value;
            textarea.value = text.substring(0, start) + timestamp + text.substring(end);
            textarea.selectionStart = textarea.selectionEnd = start + timestamp.length;
            e.preventDefault();
        }
    }
});
*/

// ここにカスタムスクリプトを追加
console.log('Memochō カスタムスクリプト読み込み');
