# pdf-fit.yazi

Preview PDFs with a toggleable image or table-of-contents view.

## Behavior
- Uses `pdftoppm` with `-scale-to` so the rendered page is large enough to fill the pane.
- Caps the render size at 3000 px and also respects `preview.max_width`/`preview.max_height`.
- When toggled, shows `pdftc` output as a text-only preview.

## Configuration
Add this to `yazi.toml`:

```toml
[[plugin.prepend_previewers]]
mime = "application/pdf"
run = "pdf-fit"
```

Bind a key to toggle modes:

```toml
[[manager.prepend_keymap]]
on = [ "p" ]
run = "plugin pdf-fit"
```

## Tuning
- Change `MAX_PX` in `main.lua` for a different cap.
- Adjust `preview.max_width`/`preview.max_height` for a global ceiling.

## Requirements
- `pdftoppm` in `PATH` (from poppler-utils).
- `pdftc` in `PATH` (from pdftc).
