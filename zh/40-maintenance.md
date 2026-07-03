# 40 — 維護協議（中文鏡像）

鏡像 en v2.0（2026-07-03）。權威版：`docs/40-maintenance.md`（英文），衝突以英文版為準。
讀者：未來任何等級的模型。這套檔案的價值在「穩定累積」，最大風險是被好意的
修改慢慢改爛（退化模式：`docs/90-letter.md`）。

## 1. 改之前：快照

`~/claude-ops` 是 git repo。改任何既有檔案前：

```bash
cd ~/claude-ops && git add -A && git commit -m "pre-edit snapshot" -q
```

改完並通過驗證（§5）後，再用描述真實變更的 message commit 一次。
git 不可用時退回：`mkdir -p ~/claude-ops/backups && cp "{檔}" backups/"{名}.$(date +%Y%m%d-%H%M%S).bak"`
（`backups/` 超過 20 檔刪最舊的 `.bak`——唯一免問的刪除。）

## 2. 權限分級

### 可自行改（改完派 verifier read-back，事後告知使用者）

- **往 `LESSONS.md` 追加**教訓（格式 §3）。最常見也最歡迎的維護。
- **修正已證實錯誤的事實**（路徑失效、指令改名、環境變了）。
  條件：附驗證證據（實跑輸出），只改該事實本身。
- **更新 `BINDINGS.md`**（模型改名、工具介面變了）——這檔案就是設計來吸收
  過期的。更新「last verified」日期，留證據。
- **模板加空格或範例**（`docs/30-templates.md`），不動既有段落結構。

### 動之前先問使用者（附「現行內容 → 提議內容＋理由」）

- 改或刪 **核心三律**（CLAUDE.md）、**R3 硬性清單**（`docs/20-judgment.md`）。
- 改 `docs/10-dispatch.md` 的**門檻數字**（派工門檻、重試次數、層級預設）——
  刻意校準過，單一 session 的體驗不足以推翻。
- **刪除**任何規則（加限制免問，放寬要問）。
- 改全域 `~/.claude/CLAUDE.md` 或 `~/.claude/agents/`（影響所有 session）。
- 大規模重組檔案結構。

## 3. 教訓寫哪、什麼格式

**機器／環境的坑** → 追加 `~/claude-ops/LESSONS.md`：

```markdown
## L{n}. {一句話結論}（{YYYY-MM-DD}）
- Situation: 做什麼時踩到
- Wrong way: 當時怎麼做、什麼症狀
- Right way: 正確步驟（盡量可直接照抄）
```

新條目建議用英文（token 便宜），中文也可——格式比語言重要。
**使用者偏好、跨專案長期事實** → memory 機制，不塞 LESSONS。
**單一 repo 的坑** → 該 repo 自己的 CLAUDE.md，不塞這裡。

## 4. 何時精簡

- `LESSONS.md` 超過 **40 條或 250 行** → 提議精簡（合併重複、刪過時、
  反覆出現的升格進對應 docs 檔後刪原條目）。精簡＝刪規則 → 先問使用者。
- 任何 docs 檔超過 **250 行** → 同上提議。
- `CLAUDE.md`（master）永遠 **≤80 行**：新內容進 docs/，master 只加路由行。

## 5. 改完之後

1. 派 `verifier` read-back：檔案完整、引用的路徑與名稱全部仍存在。
2. 告知使用者改了什麼（一行即可）。
3. 改動影響交叉引用（改檔名、改段落編號）→ Grep `~/claude-ops/` 同 session 全改。
4. Commit（§1）。

## 6. 語言政策（權威版 vs 鏡像）

- **權威版＝英文檔**：`CLAUDE.md`、`docs/10–40`、`BINDINGS.md`、`AGENTS.md`。
  所有內容修改先落英文版；衝突英文版贏。
- **`zh/` 鏡像**給使用者閱讀。改完權威版：順手就同 session 更新鏡像；
  不順手就只升權威版版本號——鏡像標頭寫著它鏡的版本，落後看得見。
  **絕不單獨改 zh 鏡像。** 使用者隨時可叫任何 session 從權威版重生鏡像。
- `docs/00-diagnosis.md`、`docs/90-letter.md` 是中文存檔：只准追加
  （交接註記），不翻譯、不改寫。

## 7. 版本戳記

每個權威檔標頭帶 `Version: X.Y (date)`。內容一改就升版（修正／增補 +0.1；
結構性變更＝要問使用者那類 +1.0）。鏡像標頭寫「鏡像 en vX.Y」。
鏡像版本號落後權威版＝定義上過時——信英文檔。
