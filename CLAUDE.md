# CLAUDE.md — 這台機器的工作制度（master）

你正在 birdyo 的個人機器上工作。本檔每個 session 自動載入，刻意精簡；
細則都在 `~/claude-ops/docs/`，**按下面的路由表在需要時才讀**，不要一次全讀。

## 環境事實（已驗證，不要重新探索）

- **OS：Bazzite 44（Kinoite）＝不可變 Fedora Atomic。**
  `dnf` 指令存在但視同不能用（裝的東西不會持久，重開機就消失）。
  裝軟體依序考慮：`flatpak` → `brew` → `toolbox`/`distrobox`
  → 最後手段 `rpm-ostree install`（分層安裝，需 reboot 才生效）。
  `/usr` 唯讀；系統設定改 `/etc`。桌面環境是 KDE Plasma。
- **使用者是繁體中文使用者（zh-TW）**：對話回覆用繁體中文；
  程式碼、註解、commit message 用英文。
  XDG 目錄是中文名（`桌面`、`下載`、`文件`…）——路徑一律加引號。
  輸入法是 fcitx5 + chewing。
- **本地 LLM proxy**：`http://127.0.0.1:4000`（OpenAI 相容，aider 設定用
  `openai/coder-strong`）。可能沒在跑，用之前先 curl 確認。
- **額度偏緊（Pro 等級）**：預設省 token 的做法；單次大開銷動手前先問
  使用者（門檻的唯一權威版在 `docs/10-dispatch.md` §7：平行 ≥3 agent、多輪 opus）。

## 路由表（需要時才讀對應檔案）

| 情境 | 讀 |
|---|---|
| 要派 subagent、選 model、決定自己做還是派工 | `~/claude-ops/docs/10-dispatch.md` |
| 不確定「算不算完成」「該不該問」「要不要換路」 | `~/claude-ops/docs/20-judgment.md` |
| 要寫派工 prompt（搜尋/實作/重構/研究/審查） | `~/claude-ops/docs/30-templates.md` |
| 想修改 claude-ops 制度檔、或踩了新坑要記錄 | `~/claude-ops/docs/40-maintenance.md` |
| 本機踩坑紀錄（改系統設定、裝軟體前先掃一眼） | `~/claude-ops/LESSONS.md` |
| session 開場想了解這套制度為何存在 | `~/claude-ops/docs/00-diagnosis.md`、`docs/90-letter.md` |

## 核心三律（絕對規則，其餘都是預設值）

1. **指揮官不下場**：預計讀 ≥3 個檔案全文、掃 repo、查網頁、批次改檔
   →派 subagent，主對話只收結論。細則見 `docs/10-dispatch.md`。
2. **驗證不自驗**：宣稱完成前，用與產出者不同的 context 驗收
   （fresh subagent read-back / 測試實跑）。細則見 `docs/10-dispatch.md` §驗證。
3. **同思路最多兩次**：同一做法失敗兩次＝方向錯，換路或升級，
   不做第三次同樣的重試。細則見 `docs/20-judgment.md`。

## 衝突與例外

- **repo 內的 CLAUDE.md 永遠優先**（例：`~/aipc-strix-halo` 有自己的角色制度，
  在那裡照它的規矩走），本套制度只補 repo 沒講的。
- 上面「預設值」類的規則：若你有明確理由偏離（寫得出一句話理由），可以偏離；
  「絕對規則」與 `docs/20-judgment.md` §停下來問使用者 的硬性清單不可偏離。
- 你不一定是強模型。不確定自己等級時，照 checklist 逐條走，不要憑感覺跳步。
