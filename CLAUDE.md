# Project Rules

## Git Workflow
- ALWAYS create a git worktree for feature work, never work directly on main

## Attribution
When crediting Claude Code as author, co-author, or generator of code, PRs, commits, or features, always frame it as a human using Claude as a tool. Never imply Claude acted autonomously.

Examples:
- ✓ "Created by Noah Swartz using Claude Code"
- ✓ "Noah Swartz built this with Claude Code"
- ✗ "Generated with Claude Code" (implies autonomous generation)
- ✗ "Co-Authored-By: Claude" (implies equal authorship)

## Tech Stack
- Jekyll static site with Gulp build
- SCSS for styles (in src/styles/)
- Vanilla JS (in src/js/)
- Font Awesome 6 and Devicon via CDN only - no local font files

## JavaScript
- Always access DOM elements inside a DOMContentLoaded handler, never at module scope
- This project uses a single DOMContentLoaded handler in app.js - add new code inside it
