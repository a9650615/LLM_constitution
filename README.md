# claude-ops — 這台機器的 AI 工作制度

2026-07-03 由 Fable 5 建立。目的：把高階模型的判斷力外化成制度，
讓之後任何等級的模型 session 都能照著跑。緣起與依據見 `docs/00-diagnosis.md`。

## 檔案地圖

| 檔案 | 內容 |
|---|---|
| `CLAUDE.md` | master 制度檔：環境事實＋路由表＋核心三律（每 session 載入）|
| `docs/00-diagnosis.md` | harness 三大病灶診斷（整套制度的依據）|
| `docs/10-dispatch.md` | 模型調度守則：派工、model/effort、升降級、驗證 |
| `docs/20-judgment.md` | 判斷 rubric：升級/完成/提問/換路/品質底線，各附正反例 |
| `docs/30-templates.md` | 派工 prompt 模板 ×5（搜尋/實作/重構/研究/審查）|
| `docs/40-maintenance.md` | 維護協議：誰能改什麼、備份、教訓格式、精簡門檻 |
| `docs/90-letter.md` | 給未來 session 的信：背景知識＋退化模式與預防 |
| `LESSONS.md` | 本機踩坑紀錄（可追加）|
| `agents/` | 自訂 subagent 定義（scout、verifier），部署到 `~/.claude/agents/` |
| `backups/` | 改檔前的備份（見維護協議 §1）|

## 部署狀態與程序

部署 = 讓所有目錄的 session 都吃到這套制度。步驟：

1. 全域路由：`~/.claude/CLAUDE.md` 寫入指向本目錄的精簡路由
   （不存在則直接建立；存在則先備份再改）。
2. agent 定義：`cp ~/claude-ops/agents/*.md ~/.claude/agents/`。
3. 驗證：新開一個 session 問「你的環境規則是什麼」，應能答出核心三律。

- [x] 已部署（2026-07-03，由建檔 session 完成）

若上面顯示未勾選，代表建檔 session 在部署前中斷：請先向使用者確認，
再執行上述步驟。
