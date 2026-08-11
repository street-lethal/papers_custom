# custom papers

## 初期化

```sh
./scripts/init.sh
```

## ビルド

```sh
docker-compose run --rm app bash
```

### ソースコードをダウンロード

(Docker 内部で実行)
```sh
./scripts/01_download_source.sh
```

### バージョン管理

(Docker 内部で実行)
```sh
./scripts/02_quilt_add.sh
```

### ソースコード修正

1. `document_view/actions.rs`
   * ```sh
     vi shell/src/document_view/actions.rs
     ```
   * 以下のメソッドを探す(L35 辺り)
     ```rust
     pub(crate) fn set_action_state(&self, name: &str, state: &glib::Variant) {
         self.document_action_group.change_action_state(name, state)
     }
     ```
   * この直後に次のメソッドを追加
     ```rust
     pub(crate) fn toggle_rtl(&self) {
         if let Some(state) = self.document_action_group.action_state("rtl") {
             let rtl = state.get::<bool>().unwrap();
             self.document_action_group
                 .change_action_state("rtl", &(!rtl).into());
         }
     }
     ```
2. `window.rs`
    * ```sh
      vi shell/src/window.rs
      ```
    * `gio::ActionEntryBuilder::new` がある `actions` 配列を探し(L367 辺り)、その配列の末尾に以下を追加
      ```rust
      gio::ActionEntryBuilder::new("rtl")
          .activate(glib::clone!(
              #[weak(rename_to = obj)]
              self,
              move |_, _, _| {
                  obj.document_view.toggle_rtl();
              }
          ))
          .build(),
      ```
3. `application.rs`
    * ```sh
      vi shell/src/application.rs
      ```
    * 以下の行を探す(L381 辺り)
      ```rust
      obj.set_accels_for_action("win.presentation", &["F5", "<Shift>F5"]);
      ```
    * その直後に以下1行を追加
      ```rust
      obj.set_accels_for_action("win.rtl", &["<Ctrl><Alt>R"]);
      ```
4. `document_view.rs`
   * ```sh
     vi shell/src/document_view.rs
     ```
   * `impl PpsDocumentView {` を探し(L869 辺り)、その直後に以下を追加
     ```rust
     pub(crate) fn toggle_rtl(&self) {
         self.imp().toggle_rtl();
     }
     ```

### 変更の適用

(Docker 内部で実行)
```sh
./scripts/03_apply_change.sh
```

### ビルド

(Docker 内部で実行)
```sh
./scripts/04_build.sh
```

## インストール

```sh
sudo apt install -y \
    ./papers_50.2-0ubuntu0.1+rtl1_amd64.deb \
    ./papers-common_50.2-0ubuntu0.1+rtl1_all.deb \
    ./libppsdocument-4.0-6_50.2-0ubuntu0.1+rtl1_amd64.deb \
    ./libppsview-4.0-5_50.2-0ubuntu0.1+rtl1_amd64.deb
```
