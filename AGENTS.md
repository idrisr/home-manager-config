# Repository Guidelines

## Project Structure & Module Organization
- `flake.nix` defines inputs, overlays, and exports the `graphical`/`headless` home configurations; treat it as the single entry point.
- `home.nix` composes shared profiles and is the only place new modules are imported; keep its optional lists tidy and alphabetized.
- Program-specific logic lives under `modules/<service>/default.nix`; mirror existing casing (e.g., `modules/git`, `modules/nixvim`) and prefer small, focused modules.
- Reusable bundles belong in `profiles/*.nix` (base vs desktop) and should only aggregate modules or options needed across multiple homes.
- `modules/nixvim` is a self-contained flake—update it in place and check it independently when touching Neovim config.

## Build, Test, and Development Commands
- `nix flake check` evaluates the root flake, catching option regressions early.
- `nix build .#graphical` (or `.#headless`) builds the activation package without mutating your live profile.
- `home-manager switch --flake .#graphical` applies changes locally; add `--show-trace` when diagnosing evaluation errors.
- `nix build modules/nixvim#default` tests the embedded Neovim flake after plugin or Lua adjustments.

## Coding Style & Naming Conventions
- Write Nix expressions with two-space indentation and trailing semicolons aligned as in existing files.
- Keep attribute sets and import lists alphabetized when practical; group related settings with single-line comments sparingly.
- Use lowerCamelCase for option names (`extraConfigLua`) and lowercase directory names that match the target program.
- Prefer splitting complex features into new modules rather than expanding large files; follow `modules/<name>/default.nix` as the pattern.
- Format before committing (`nixpkgs-fmt` or `alejandra`) to avoid stylistic churn.

## Testing Guidelines
- Run `nix flake check` before every push; it is the project’s baseline “test suite.”
- After home-manager changes, build both `.#graphical` and `.#headless` unless the change is scoped to one profile.
- For Neovim work, run `nix flake check` inside `modules/nixvim/` and launch the resulting `./result/bin/nvim` to sanity check key plugins.
- Document manual validation steps in your PR when no automated check covers the change.

## Commit & Pull Request Guidelines
- Compose commit subjects as `area: action` (e.g., `modules/git: enable delta theme`) and keep bodies focused on rationale and fallout.
- Group unrelated tweaks into separate commits; include the flake output you verified (`nix build .#graphical`) in the message footer when helpful.
- In PRs, list affected modules, link related issues, and attach screenshots or command output for UI-facing changes.
- Ensure the PR description states which commands were run and any follow-up tasks left for the reviewer.
