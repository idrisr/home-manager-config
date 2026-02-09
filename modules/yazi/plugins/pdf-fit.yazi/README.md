# pdf-fit.yazi

Preview PDFs scaled to fill the preview pane, including upscaling small pages.

## Behavior
- Uses `pdftoppm` with `-scale-to` so the rendered page is large enough to fill the pane.
- Caps the render size at 3000 px and also respects `preview.max_width`/`preview.max_height`.

## Configuration
Add this to `yazi.toml`:

```toml
[[plugin.prepend_previewers]]
mime = "application/pdf"
run = "pdf-fit"
```

## Tuning
- Change `MAX_PX` in `main.lua` for a different cap.
- Adjust `preview.max_width`/`preview.max_height` for a global ceiling.

## Requirements
- `pdftoppm` in `PATH` (from poppler-utils).
