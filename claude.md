# Claude's Role in the Reflekto Project

## Project Overview
**Reflekto** — A journaling application being built as a clone of Apple Journal (MVP) with the final product aiming to match Day One's feature set. The app will be publicly deployed and searchable on the web.

**Tech Stack:**
- Ruby on Rails
- Devise (Authentication)
- ActionText (Rich Text)
- ActiveStorage (Media)
- PostgreSQL/SQLite

---

## Claude's Role Definition

### ✅ What I SHOULD Do:
1. **Logic Assistance** - Help you think through the implementation logic and approach
2. **Roadmap Navigation** - Guide you through the phases and keep you on track
3. **Debugging Support** - Help identify logical errors and suggest solutions conceptually
4. **Architecture Advice** - Discuss data model relationships, controller logic, routing structure
5. **Best Practices** - Suggest Rails conventions and security considerations
6. **Explain Concepts** - Break down complex topics (nested resources, associations, etc.)
7. **Front-End Implementation** - Write all HTML and CSS for views when the time comes (Phase 5 UI/UX polish and any view styling throughout)

### ❌ What I SHOULD NOT Do:
1. **Write Back-End Code** - Unless you explicitly say "give me the code" (controllers, models, migrations)
2. **Generate Back-End Files** - No auto-creating controllers, models, or migrations without request
3. **Make Assumptions** - Always ask for clarification when the path forward isn't clear
4. **Jump Ahead** - Stick to the current phase; don't skip steps

### 🎨 Front-End Stack Available:
- **Le Wagon Stylesheet** - Already installed in the app
- **Bootstrap** - Full grid, components, and utilities available
- **FontAwesome** - Icons available
- **Target Aesthetic** - Deep purple/dark mode like Apple Journal
- When it's time for UI work, I will write the full HTML structure and CSS styling for all views

### 🎯 My Primary Mission:
**Walk you through the roadmap step-by-step, ensuring you understand the LOGIC behind each decision before implementing it yourself.**

---

## Available Skills (Installed in `~/.claude/commands/`)
/
These are invoked with `/skill-name` and load only when needed:

| Skill | Command | When to Use |
|-------|---------|-------------|
| **frontend-design** | `/frontend-design` | Building pages, components, UI — bold aesthetic direction |
| **ui-ux-pro-max** | `/ui-ux-pro-max` | Full design system — palettes, font pairings, UX rules |
| **seo** | `/seo` | Before deployment — audit pages, schema markup, AI search |
| **code-review** | `/code-review` | Every PR — catch bugs, quality, constructive feedback |
| **owasp-security** | `/owasp-security` | Phase 6 — security audit before going live |

**For Phase 5 UI/UX:** Use `/ui-ux-pro-max` first to establish the design system, then `/frontend-design` when building each page.

---

## The Project Roadmap

### ✅ Phase 1: The Nested "Read" Flow — COMPLETE
*Goal: Navigate from Bookshelf to Entry without crashes.*

- [x] Database Migration: Associate Entries with Journals
- [x] Seeding: Populate with test data
- [x] Journals Index: The "Bookshelf" view
- [x] Journal Entries Index: List of entries inside a specific notebook
- [x] Journal Entries Show: Display specific entry details

---

### ✅ Phase 2: Complete Nested CRUD — COMPLETE
*Goal: Allow full create, edit, delete within the nested structure.*

- [x] Journals CRUD: Full create, edit, delete for journals
- [x] Journal Entries CRUD: Full create, edit, delete for journal entries
- [x] Controller Security: `before_action` filters hardened

---

### ✅ Phase 3: The Public Face & UX — COMPLETE
*Goal: Make the app look professional and handle navigation smoothly.*

- [x] Marketing Landing Page: Build `Pages#home` for non-logged-in users
- [x] Root Logic: Logged out → Landing page, Logged in → Bookshelf (`journals#index`)
- [x] Navigation Bar: "My Journals", "New Entry", "Logout"
- [x] Flash Messages: "Entry saved successfully!" popups

---

### ✅ Phase 4: The "Apple" Polish (Rich Content) — COMPLETE
*Goal: Upgrade from basic text to a premium writing experience.*

- [x] Migration to ActionText: Rich text editor with Bold, Italic, Strikethrough, Headings, Quotes, Code Blocks, Lists
- [x] Media & Photos: Cover photo attachment via ActiveStorage (`cover_photo` field on entries) — UI hidden for now, backend intact
- [x] Search & Filtering: Title search, mood filter, date range (from/to), tag filter — all on entries index
- [x] Tags: Tag/EntryTag models with user-scoped tags, autocomplete chip input (Stimulus controller)
- [x] Mood Tracking: `mood` DB column preserved; emoji picker UI **removed** from form per April 21 2026 designer note (tags replace moods as the professional alternative)
- [x] Settings Page: `/settings` with profile edit, password change, reminder preferences, dark mode toggle, data export, and account deletion
- [x] Writing Stats Widget: Dashboard shows total entries, journals, words, current streak, longest streak
- [x] Calendar View: Month-view calendar on entries index with entry indicators and month navigation (Stimulus controller)
- [x] Soft Delete / Recently Deleted: 30-day recovery window, bulk recover/purge, auto-expiry
- [x] Dark Mode: Toggle in settings, persisted to DB (`dark_mode` column on users)
- [x] Data Export: Plain-text download of all entries
- [x] Journaling Prompts: Two-level `/prompts` page — category list → per-category prompt cards. Clicking a prompt opens new entry pre-filled with prompt as title. Journal picker pill on new-entry form lets user switch journals before writing.

---

### ✅ Phase 5: UI/UX Polish (The "Final Look") — COMPLETE
*Goal: Transform basic HTML into sleek design using Bootstrap + Le Wagon stylesheet.*

- [x] CSS/Bootstrap Integration: Style Journals as cards/books (dark mode)
- [x] Auth Pages Redesign: Centered dark card layout (sign in + sign up), matching landing page purple tone
- [x] Password Eye Toggle: Show/hide password on all auth forms (Stimulus controller)
- [x] Password Requirements: Live checklist on sign-up + server-side validation (uppercase, number, special char, 8+ chars)
- [x] Journal Color Picker: Color swatches + live book preview on New/Edit Journal form; bookshelf accent bar uses chosen color
- [x] Landing Page Footer: Two-column footer (LEGAL + COMPANY) replacing single-row bar
- [x] Bookshelf Cleanup: Removed "New Journal" ghost card from grid (top-right button is the only entry point)
- [x] Date Formatting: Change `2026-04-15` to `April 15, 2026`
- [x] Empty States: Nice views for "No entries yet"
- [x] **Dark Mode Theme:** Canvas-only dark mode wired to `dark_mode` DB column. `body.dark-mode` class toggled via `dark_mode_controller.js` (Stimulus, instant AJAX — no save button). `_dark_mode.scss` covers app-main, entry cards, bookshelf, settings, prompts, recently deleted, writing canvas, forms. Sidebar stays dark navy (unchanged). Landing/auth/legal pages unaffected (class only applied when signed in).
- [x] **Sign-up Page Polish:** Name field added (Devise permitted params), animated password req-list (CSS `:focus-within`), card border/shadow distinction, button resting glow.
- [x] **Settings Improvements:** Read-only email field (`:email` removed from `profile_params`); password card with lock icons, eye toggles, separator, req-list, placeholders; GitHub-style 3-step delete account modal (type email to confirm); instant dark mode toggle (no Save needed); day chips driven by CSS `:has(:checked)` only.
- [x] **Password Change UX Fix:** Both success and failure redirect to `settings_path(anchor: "password")` so the page scrolls to the password card instead of jumping to the top.
- [x] **Mobile Responsiveness:** Full responsive pass — all pages clean at iPhone XR (375px) through iPad Pro. Entry cards, bookshelf grid, settings cards, prompts, recently deleted, writing canvas, filter bar all reflow correctly at mobile breakpoints.

---

### 🎯 Phase 5.5: Infrastructure (Decided — implement before deployment)
*Goal: Replace SQLite with production-grade Postgres and wire up email + background jobs.*

| Layer | Choice | Why |
|-------|--------|-----|
| Database | Local Postgres (dev) + Supabase or Neon (prod) | Free tier, nice dashboard, production-ready |
| Transactional email | Resend | Simple, free tier, ActionMailer-compatible |
| Background jobs (reminders) | GoodJob | Postgres-backed, no Redis needed |

- [x] Migrate from SQLite3 → PostgreSQL locally
- [ ] Create Supabase or Neon project and wire up `DATABASE_URL` for production
- [ ] Add Resend gem + configure ActionMailer SMTP (Devise forgot-password + future reminder emails)
- [ ] Add GoodJob gem for scheduled/background jobs (email reminders)

---

### 🚀 Phase 6: Final Refinement & Launch
*Goal: Squash bugs and go live.*

- [ ] Cleanup: Remove faker gem, clear test seeds
- [ ] Deployment: Push to production (Render/Heroku) and merge to master

---

## Current Status
**Branch:** `phase-5-dark-mode-mobile`

**Phases Complete:** Phase 1, Phase 2, Phase 3, Phase 4, Phase 5 ✅

**Current Phase:** Phase 5.5 — Infrastructure (Postgres local ✅, Supabase/Neon prod + Resend + GoodJob remaining)

**Completed since last update (April 24, 2026):**
- Dark Mode Theme: canvas-only, instant AJAX toggle, `_dark_mode.scss` covers all in-app pages
- Mobile Responsiveness: full pass across all pages, clean at 375px–iPad Pro
- Sign-up page polish: name field, animated req-list, card glow, button resting glow
- Settings: read-only email, password card with icons/eye toggles/separator/req-list, GitHub-style 3-step delete modal, instant dark mode toggle
- Password change UX fix: redirects to `#password` anchor on both success and failure

**Next Session:** Phase 5.5 — wire up Supabase/Neon for production DB, Resend for email, GoodJob for reminders

---

## How to Work With Me

1. **Tell me what phase/task you're working on**
2. **Ask me to explain the logic needed**
3. **I'll walk you through the approach**
4. **You implement it**
5. **If you get stuck, show me the error**
6. **When you need actual code, explicitly say: "give me the code"**

---

## Key Reminders
- This is a **nested resource** app: Journals → Journal Entries
- Users have many Journals, Journals have many Journal Entries
- All routes should be nested: `journals/:journal_id/journal_entries/:id`
- Security: Users can only see/edit their own Journals and Entries
- Target aesthetic: Deep purple/dark mode like Apple Journal

---

**Last Updated:** April 24, 2026
**Current Focus:** Phase 5.5 — Infrastructure (branch: `phase-5-dark-mode-mobile`)
