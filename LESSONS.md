# LESSONS — 本機踩坑紀錄

追加格式見 `docs/40-maintenance.md` §3。改系統設定、裝軟體前先掃一眼這裡。

## L1. Bazzite 上不能用 dnf 裝套件（2026-07-03）
- 情境：需要安裝任何 CLI 工具或系統套件時
- 錯法：`dnf install foo` → 指令不存在或報 ostree 錯誤
- 對法：依序考慮 `flatpak`（GUI 軟體）→ `brew`（CLI 工具，已裝 homebrew）→
  `toolbox`/`distrobox`（開發環境）→ `rpm-ostree install foo`（最後手段，
  分層安裝且要 reboot 才生效；用過 → 見 settings.local.json 的 permission 化石）

## L2. 中文 XDG 目錄路徑要加引號（2026-07-03）
- 情境：任何 shell 指令引用 `桌面`、`下載` 等目錄
- 錯法：裸路徑進腳本，遇到工具對非 ASCII 處理不佳就爛掉；
  另外 `.claude.json` 的專案紀錄裡有 `~/桌面/aipc-strix-halo`（歷史位置，
  現已不存在），別把它當成現存路徑，現存的只有 `~/aipc-strix-halo`
- 對法：路徑一律雙引號包起來；長期工作目錄優先用 home 直下的英文路徑

## L3. 本地 LLM proxy 不保證在跑（2026-07-03）
- 情境：想用 `http://127.0.0.1:4000`（OpenAI 相容 API，aider 用它）
- 錯法：直接發請求，卡在連線逾時
- 對法：先 `curl -s -m 3 http://127.0.0.1:4000/v1/models` 確認活著再用
