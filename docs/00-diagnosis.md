# 00 — Harness 快速診斷（2026-07-03，由 Fable 5 建檔）

本檔是整套制度的依據。後面每份文件的規則都對應這裡的某個病灶。
讀者：未來在這台機器上運作的任何 Claude 模型（含 Haiku 等級）。

## 病灶一（漏 token 最兇）：環境知識不落地，每個 session 從零重新推導

**證據**：2026-07-03 之前這台機器沒有任何全域 CLAUDE.md、沒有 memory 檔案。
每個新 session 都要重新發現：這是 Bazzite（不可變 Fedora）、`dnf install` 不能用、
中文 XDG 目錄名（`桌面`、`下載`）、fcitx5 輸入法、本地 LLM proxy 等事實。
`~/.claude/settings.local.json` 的 permission 清單就是化石證據——裡面全是
rpm-ostree / fcitx5 / localectl 的一次性探索指令。

**代價**：每次重新探索花 10–30 次工具呼叫，而且探索過程可能重犯同樣的錯
（例如在 ostree 系統上跑 `dnf install`）。

**修法**（已實施）：
1. 環境事實寫死在 `~/claude-ops/CLAUDE.md`（每 session 自動載入）。
2. 踩到新坑 → 按 `docs/40-maintenance.md` 寫進 `LESSONS.md`，不重複踩。
3. 跨 session 的使用者偏好寫進 memory（見維護協議 §memory）。

## 病灶二（最容易失焦）：主對話自己下場做工人活

**症狀**：主模型自己連續 grep / cat 十幾個檔案、自己掃 repo、自己讀長網頁，
把原始內容全部灌進主 context。之後主 context 塞滿低價值原文，
接近上限時被摘要（compact），任務目標和使用者的原始要求最先被稀釋。
弱模型尤其嚴重：它們傾向「多讀一點比較保險」。

**判準**（何時算下場）：預計要讀 3 個以上檔案的完整內容、或任何一次
repo 級掃描、網頁研究、批次改檔——這些就是工人活。

**修法**（已實施）：`docs/10-dispatch.md` 的「指揮官不下場」規則＋回報合約
（subagent 只回結論與 `檔案:行號`，長產物落檔傳路徑）。

## 病灶三（最容易出錯）：自己改、自己驗、原地重試

**症狀**：模型改完程式碼後只用「再讀一次自己的 diff」當驗證；測試失敗後
在同一個思路上重試三、四次，每次改動越來越大，最後把能動的東西也改壞。
寫檔後不 read-back，宣稱完成但檔案其實沒落地或內容被截斷。

**根因**：產生答案的 context 帶著產生錯誤的同一批偏見。自驗 = 用同一個
偏見檢查同一個偏見。

**修法**（已實施）：`docs/10-dispatch.md` §驗證不自驗（fresh-context 驗收）＋
`docs/20-judgment.md` 的「方向錯了的訊號」（兩次同思路失敗 = 換路，不是第三次重試）。

## 次要病灶（順手記錄，修法在各檔）

- **`skipDangerousModePermissionPrompt: true`**（`~/.claude/settings.json`）：
  危險模式不再提示。制度上的補償：`docs/20-judgment.md` §何時停下來問使用者
  對「不可逆動作」設了硬性清單，不依賴 harness 提示。
- **`~/aipc-strix-halo` 有自己的 CLAUDE.md**（大哥/副官/執行兵角色制）。
  衝突規則：**repo 內的 CLAUDE.md 優先於本套全域制度**；本套只補 repo 沒講的。
- **settings.json 的 model 是 `claude-fable-5[1m]`**：Fable 額度用完或下架後
  session 會 fallback 或報錯。未來 session 不要假設自己是 Fable——先確認自己
  的身分再選角色（強模型可多留判斷，弱模型照 checklist 走）。
- **專案紀錄（`.claude.json`）裡有 `~/桌面/aipc-strix-halo` 的歷史位置**，
  實際已不存在（2026-07-03 核實），現存的是 `~/aipc-strix-halo`。
  中文目錄路徑（`桌面`）容易被工具或腳本弄壞編碼。規則：引用路徑一律加引號，
  優先用 home 直下的英文路徑。

2026-07-06 補記：以上所述之 repo-local 檔案優先權，現從屬於十條基本法
（`docs/05-ten-laws.md`）；repo 檔案僅能覆寫「作業性規章」（operational
statutes），不能覆寫基本法本身。
