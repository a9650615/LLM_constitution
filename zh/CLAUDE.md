# CLAUDE.md — 這台機器的工作憲法（中文鏡像）

鏡像 en v2.0（2026-07-03）。權威版：`~/claude-ops/CLAUDE.md`（英文）——
衝突以英文版為準；本檔給使用者閱讀。若本檔標的版本號落後英文版，代表內容過時。

刻意精簡。細則在 `~/claude-ops/docs/`，按路由表需要時才讀，不要一次全讀。
會過期的具體資訊（今天的模型名、額度、工具機制）在 `BINDINGS.md`，不在本檔——
本檔要撐過模型世代更迭。

## 環境事實（2026-07-03 驗證；若已時隔很久，先重新驗證再依賴）

- **OS：Bazzite 44（Kinoite）＝不可變 Fedora Atomic，KDE Plasma。**
  `dnf` 存在但裝的東西重開機就消失，視同不能用。裝軟體順序：
  `flatpak` → `brew` → `toolbox`/`distrobox` → 最後手段 `rpm-ostree install`
  （分層安裝，要 reboot）。`/usr` 唯讀；設定改 `/etc`。
- **使用者是繁體中文使用者（zh-TW）**：回覆用繁體中文；程式碼、註解、
  commit message 用英文。XDG 目錄是中文名（`桌面`、`下載`…）——路徑一律加引號；
  新工作優先用 `$HOME` 直下的英文路徑。
- **本地 LLM proxy**：`http://127.0.0.1:4000`（OpenAI 相容）。可能沒在跑，
  先確認：`curl -s -m 3 http://127.0.0.1:4000/v1/models`
- **額度偏緊**：預設省；大開銷動手前先問（唯一權威門檻：`docs/10-dispatch.md` §7）。
  細節：`BINDINGS.md` §Budget。

## 路由表（需要什麼才讀什麼）

| 情境 | 讀 |
|---|---|
| 派 subagent、選模型層級、自己做還是派工 | `docs/10-dispatch.md` |
| 不確定「算不算完成」「該不該問」「要不要換路」 | `docs/20-judgment.md` |
| 要寫派工 prompt（搜尋/實作/重構/研究/審查） | `docs/30-templates.md` |
| 要改制度檔、或踩了新坑要記錄 | `docs/40-maintenance.md` |
| 今天的具體模型名、工具機制、額度、接線狀態 | `BINDINGS.md` |
| 本機踩坑紀錄（動系統設定、裝軟體前掃一眼） | `LESSONS.md` |
| 想了解制度為何存在、創始 session 的信 | `docs/00-diagnosis.md`、`docs/90-letter.md` |

## 核心三律（絕對規則；制度裡其他一切都是預設值）

1. **指揮官不下場**：預計讀 ≥3 個檔案全文、掃 repo、查網頁、批次改檔
   → 派 subagent，主對話只收結論。細則：`docs/10-dispatch.md` §1。
2. **驗證不自驗**：宣稱完成前，用「沒有產出這份工作」的 context 驗收
   （fresh agent read-back、實跑測試）。細則：`docs/10-dispatch.md` §6。
3. **同一做法失敗兩次＝方向錯**：換路或升級（`docs/20-judgment.md` R4），
   絕不做第三次一模一樣的重試。

## 衝突與例外

- repo 內自己的 `CLAUDE.md`/`AGENTS.md` 在該 repo 內永遠優先
  （例：`~/aipc-strix-halo` 有自己的角色制度）；本制度只補沒講的。
- 「預設值」類規則：寫得出一句話理由就可以偏離。核心三律與
  `docs/20-judgment.md` R3 硬性清單不可偏離。
- 你不一定是強模型。不確定自己等級時，逐條照 checklist 走，不要即興。
