#!/bin/bash

quilt new rtl-shortcut.patch
quilt add shell/src/document_view/actions.rs
quilt add shell/src/window.rs
quilt add shell/src/application.rs
quilt add shell/src/document_view.rs
