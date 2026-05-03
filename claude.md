# Claude's Role in the Reflekto Project

## Project Overview
**Reflekto** — A journaling application being built as a clone of Apple Journal (MVP) with the final product aiming to match Day One's feature set. The app will be publicly deployed and searchable on the web.

**Tech Stack:**
- Ruby on Rails
- Devise (Authentication) + OmniAuth (Google OAuth2)
- ActionText (Rich Text)
- ActiveStorage + Cloudinary (Media)
- PostgreSQL (local dev + Heroku Postgres in production)
- GoodJob (background jobs, Postgres-backed)
- Resend (transactional email via ActionMailer SMTP)

**Deployment:** Live at https://www.reflektoapp.com (Heroku EU, Heroku Postgres add-on, Cloudinary for ActiveStorage, ACM SSL)

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
- [x] **Google OAuth:** Sign-in/sign-up with Google (`omniauth-google-oauth2` + `omniauth-rails_csrf_protection` gems). `User.from_omniauth` — find by provider+uid → link existing email → create new. OAuth users bypass password complexity (random token password). `Users::OmniauthCallbacksController`. Google Cloud credentials stored in `.env` (dev) and Heroku config vars (prod).
- [x] **Auth Page Improvements:** Solid black pill Google button (overrides green card button styles with `!important`). Confirm password field removed (eye toggle + req checklist make it redundant). "Reflekto" logo at top is a link back to root. "Back to Home" link removed. ToS + Privacy Policy line on sign-up. `auth-divider` between Google button and email form.

---

### ✅ Phase 5.5: Infrastructure — COMPLETE
*Goal: Replace SQLite with production-grade Postgres and wire up email + background jobs.*

| Layer | Choice | Why |
|-------|--------|-----|
| Database | Heroku Postgres (prod) | Already wired via Heroku add-on; `DATABASE_URL` set automatically |
| Transactional email | Resend | Simple, free tier, ActionMailer-compatible |
| Background jobs (reminders) | GoodJob | Postgres-backed, no Redis needed |

- [x] Migrate from SQLite3 → PostgreSQL locally
- [x] Heroku Postgres for production (add-on active, `DATABASE_URL` auto-set by Heroku)
- [x] Add Resend gem + configure ActionMailer SMTP (dev + prod environments)
- [x] Add GoodJob gem + cron schedule (reminder emails every 5 min, purge expired entries nightly at 3am UTC)
- [x] `UserMailer#welcome` — welcome email on user creation via `after_commit`
- [x] `ReminderMailer#daily_reminder` — daily reminder email (HTML + text templates)
- [x] `SendReminderEmailJob` — checks `reminders_enabled`, `reminder_days`, `reminder_time` per user
- [x] `PurgeExpiredEntriesJob` — destroys soft-deleted entries older than 30 days

**Architecture note — Reminder system improvement (consider post-launch):**
Current approach: a cron fires every 5 min and checks which users' reminder time falls in that window. Works fine in production (Heroku dyno stays up), but fragile during server restarts (misses the window) and relies on window math.
Recommended improvement: ditch the cron + window approach. Instead, when a user saves reminder preferences, enqueue a per-user scheduled job at their exact reminder time (`ReminderEmailJob.set(wait_until: next_occurrence).perform_later(user.id)`). The job re-enqueues itself for the next day on completion. GoodJob stores `scheduled_at` in Postgres so jobs survive restarts. No window math, no missed windows, exact timing. ~30 lines of code change in `SettingsController` + `SendReminderEmailJob`.

**Pending (production only):**
- [ ] Run `heroku run rails db:migrate --app reflektoapp` — applies `provider`/`uid` columns (from Google OAuth migration) to production DB
- [ ] Test Google OAuth end-to-end on production (visit reflektoapp.com → "Continue with Google" → land on journals#index)

---

### 🚀 Phase 6: Final Refinement & Launch
*Goal: Squash bugs and go live.*

- [ ] Run `heroku run rails db:migrate --app reflektoapp` — apply `provider`/`uid` + `timezone` + `confirmable` columns to prod DB
- [ ] Test Google OAuth end-to-end on production
- [ ] Verify Resend email delivery (welcome email + forgot-password + confirmation) on production
- [ ] Verify GoodJob reminder cron fires correctly on production
- [ ] Cleanup: Remove faker gem, clear test seeds
- [ ] Merge `feature/google-oauth-and-improvements` → `master` (open PR first)
- [ ] Final smoke test on https://www.reflektoapp.com
- [ ] Migrate from Heroku to Railway (reduces ~$15/month)
  - Sign up at railway.app, connect GitHub repo
  - Add PostgreSQL service (auto-injects `DATABASE_URL`)
  - Set env vars: `RAILS_MASTER_KEY`, `GOOGLE_CLIENT_ID`, `GOOGLE_CLIENT_SECRET`, `RESEND_API_KEY`, `CLOUDINARY_URL`, `RAILS_ENV=production`, `RAILS_SERVE_STATIC_FILES=true`
  - Pre-deploy command: `bundle exec rails db:migrate`
  - Migrate data: `heroku pg:backups:download` → `pg_restore` to Railway DB URL
  - Point `reflektoapp.com` DNS CNAME to Railway domain
  - Update Google OAuth redirect URIs in Google Cloud Console to production URL

---

## Current Status
**Branch:** `feature/google-oauth-and-improvements`

**Phases Complete:** Phase 1, Phase 2, Phase 3, Phase 4, Phase 5, Phase 5.5 ✅

**Current Phase:** Phase 6 — Final Refinement & Launch

**Completed since last update (May 1, 2026):**
- GoodJob background jobs: `SendReminderEmailJob` (every 5 min cron) + `PurgeExpiredEntriesJob` (nightly cron)
- Resend email: ActionMailer SMTP configured for dev + prod, `UserMailer#welcome` + `ReminderMailer#daily_reminder` with HTML + text templates
- Google OAuth: full flow — Google Cloud Console credentials, `omniauth-google-oauth2` gem, `User.from_omniauth`, callback controller, routes
- Auth page redesign: solid black Google button, removed confirm password, logo as home link, ToS line on sign-up, `auth-divider`
- Heroku deployment: app live at https://www.reflektoapp.com (Heroku EU, Postgres add-on, Cloudinary, ACM SSL)

**Immediate next steps:**
1. `heroku run rails db:migrate --app reflektoapp` — adds `provider`/`uid` columns to prod DB
2. Test Google OAuth on production
3. Open PR: `feature/google-oauth-and-improvements` → `master`
4. Phase 6 cleanup (remove faker, test seeds)

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

**Last Updated:** May 1, 2026
**Current Focus:** Phase 6 — run prod migration, test Google OAuth, open PR to master (branch: `feature/google-oauth-and-improvements`)
