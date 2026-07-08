# 90 — 給未來 session 的信

寫於 2026-07-03，Fable 5 唯一一次 session。使用者的原始委託：把判斷力轉成
制度，讓之後每個較弱模型的 session 都因此變強。你就是那個「之後的 session」。

## 使用者沒問、但你該知道的三件事

### 1. 這台機器在建「多模型協作」工作流，Claude 不是唯一的 agent

`~/aipc-strix-halo` 是使用者的核心專案（AI PC 建置腳本），它的 CLAUDE.md
已有一套成熟的角色制度（大哥/副官/執行兵），且明確寫給多種工具讀
（OpenCode、Aider、Goose、本地 Qwen…）。aider 設定指向本地 proxy
（`127.0.0.1:4000`）。這代表：
- 在那個 repo 工作時，**角色與 commit 規矩照它的**，本套制度只補調度技巧
  （model/effort 實際可用值、派工模板）。
- 你寫的任何規範類產出，盡量讓非 Claude 工具也讀得懂（AGENTS.md 慣例、
  少用只有 Claude Code 才有的術語而不解釋）。
- 使用者對 agent 調度有品味也有經驗——回報時講重點，不用解釋什麼是 subagent。

### 2. Harness 不會救你：危險操作的防線只剩制度

`~/.claude/settings.json` 設了 `skipDangerousModePermissionPrompt: true`。
`docs/20-judgment.md` R3 的硬性清單是唯一防線，沒有第二層。另外
settings 的 model 是 `claude-fable-5[1m]`——Fable 額度用完後你可能是
fallback 模型：**開場先搞清楚自己是誰**（系統提示會寫），是弱模型就老實
照 checklist 走，這套制度就是為這個情境設計的。

### 3. Memory 幾乎是空的，病灶一會復發，除非你養成寫的習慣

2026-07-03 之前這台機器零 memory、零 CLAUDE.md（見 `docs/00-diagnosis.md`）。
本 session 已種下初始 memory 與本套檔案，但制度只解決「已知的坑」；
新的使用者偏好、新的跨專案事實，要當場寫進 memory（機器坑寫 `LESSONS.md`，
分工見 `docs/40-maintenance.md` §3）。額度緊，**最省錢的單一習慣是：
開場信任 CLAUDE.md 的環境事實，不要重新探索**。

## 這套制度最可能的退化方式（按危險排序）與預防

### 退化 A：靜默繞過（最危險，因為沒有立即後果）

症狀：嫌麻煩，不派 verifier、不備份、跳過 read-back，「這次很簡單應該沒事」。
每次繞過都相安無事，直到某次不是。
預防：回報合約強制寫「驗證到什麼程度」——沒驗就得白紙黑字寫「未驗證」，
說謊比照做更難。使用者可以偶爾抽查「這次驗收是誰做的」。

### 退化 B：規則通脹

症狀：每次小事故就往 CLAUDE.md 加一條規則，兩個月後長到 300 行，
弱模型讀不完，等於沒有規則。
預防：CLAUDE.md 硬上限 80 行（`docs/40-maintenance.md` §4）；加規則前先問
「這是一次性事故還是重複模式」——一次性的進 LESSONS.md，模式才進 docs。

### 退化 C：LESSONS.md 變垃圾場

症狀：低價值心得（「今天學到 grep 有 -r 參數」）稀釋高價值教訓，
掃一眼的成本超過收益，於是沒人掃，等於沒有教訓。
預防：格式門檻（必須有「錯法＋對法」才算教訓）＋40 條/250 行觸發精簡。

### 退化 D：事實過時反而誤導

症狀：環境變了（proxy 換 port、換 OS、目錄改名）但文件沒跟上，
弱模型信了假事實，比沒有文件更糟。
預防：每條環境事實都附驗證方法（可實跑的指令）；`docs/40-maintenance.md`
§2 明文允許「附證據修正錯誤事實」不用先問——修正事實的門檻刻意設低。

## 追記（2026-07-04，同一個創始 session）：v2.0 憲法化改版

使用者加碼要求「憲法等級、能用好幾年」＋英文版＋非 Claude 模型版。已完成：
- **分層防腐**：不會過期的原則留在 CLAUDE.md 與 docs/（改用 cheap/standard/
  strong 抽象層級）；會過期的（模型名、額度、本地模型陣容、接線）全數移入
  `BINDINGS.md`，明文允許憑證據自行更新。
- **英文為權威版**（省每次載入的 token），`zh/` 放中文鏡像（標鏡像版本號，
  落後看得見）。語言政策：`docs/40-maintenance.md` §6–7。
- **`AGENTS.md`**：給非 Claude agent（aider/OpenCode/goose/本地 GLM/Qwen/Gemma）
  的七律精簡憲法；已接線 aider（`read:`）與 OpenCode（symlink）。
- `~/claude-ops` 轉為 git repo（v1 中文原版有完整快照，維護改用 git 流程）。
- 另：使用者在 session 中途裝了 mem0 記憶插件（狀態見 `BINDINGS.md`）。
- 使用者開了 GitHub repo（`a9650615/LLM_constitution`，遠端已接、push 已預授權
  ——僅限本 repo，見 `docs/40-maintenance.md` §5），並要求整套做成 plugin 形態
  （`.claude-plugin/` manifest＋`commands/`＋`skills/`；安裝與 marketplace 接線
  刻意未做，等使用者決定）。第二輪對抗審查（14 findings）已修正並升版 v2.1。

## 本次 session 交接狀態（2026-07-03）

- 已完成：診斷（00）、CLAUDE.md、調度（10）、判斷（20）、模板（30）、
  維護（40）、本信（90）、LESSONS 種子、scout/verifier agent 定義。
- 部署狀態：見 `~/claude-ops/README.md`（若不存在，代表 session 在部署前
  中斷——請按 README 一節的計畫完成：全域 `~/.claude/CLAUDE.md` 路由＋
  複製 `agents/*.md` 到 `~/.claude/agents/`，動全域前先問使用者一聲）。

## 勘誤（2026-07-06）

上文「第二輪對抗審查（14 findings）」應為 13 findings（依 commit `1d83dda`
訊息「fix 13 adversarial-review findings」）。本檔 append-only，原文不改，以此
勘誤為準。另：本檔各節依寫入先後排列，非依標題日期排序。

## 搬遷記錄（2026-07-08）

本檔自 `docs/` 遷至 `archive/`，理由同 `archive/00-diagnosis.md` 檔尾註記。
內文未改；文中機器事實為 2026-07-03 時代快照，現行權威在 `BINDINGS.md`。
文中所指 `docs/00-diagnosis.md` 亦已於同次搬遷移至 `archive/00-diagnosis.md`，
原文依 append-only 不改，以此註記為準。
