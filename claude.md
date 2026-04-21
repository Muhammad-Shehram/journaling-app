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

### ✍️ Phase 4: The "Apple" Polish (Rich Content)
*Goal: Upgrade from basic text to a premium writing experience.*

- [ ] Migration to ActionText: Upgrade content field to Rich Text (Bold, Italics, Links)
- [ ] Media & Photos: Allow photo attachments via ActiveStorage
- [ ] Search & Filtering: Search entries by title or filter by mood/date
- [ ] Journaling Prompts: A curated set of pre-built prompts (e.g. "What made you smile today?", "What's one thing you'd do differently?") shown on the new entry form. User clicks a prompt to auto-fill the title or content area, helping people who don't know what to write.
- [ ] Mood Tracking: Emoji mood picker on the entry form (😊 Happy, 😴 Tired, 🔥 Motivated, 😰 Anxious, 🙏 Grateful, 😌 Calm, 😔 Sad). Mood stored on the entry, displayed on entry cards and the show page. Enables filtering entries by mood over time. Core feature in Day One and Apple Journal — gives users emotional context and pattern awareness across their journaling history.
- [ ] Settings Page: Dedicated `/settings` page for the logged-in user. Minimum: change display name, change email, change password, delete account. Can expand later with notification preferences and theme options.

---

### 💅 Phase 5: UI/UX Polish (The "Final Look")
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

---

### 🎯 Phase 5.5: Journal Identity (Deferred — post Rich Content)
*Goal: Give each journal a unique visual identity like Apple Journal / Day One.*

- [ ] **Emoji/Icon picker on New Journal form** — Full icon grid (100+ icons across categories: activities, travel, food, nature, etc.) that sets a visual icon for the journal cover. Requires: new `icon` string column on `journals`, an icon picker UI component, and updating the bookshelf card to display the chosen icon. Reference: Apple Journal's icon grid UI (screenshots saved). Deferred until Phase 4 rich content is complete since it shares the same "visual identity" milestone.
- [ ] Mood Logic: Auto-show emoji based on mood (🔥, 😴, 😊)

---

### 🚀 Phase 6: Final Refinement & Launch
*Goal: Squash bugs and go live.*

- [ ] Cleanup: Remove faker gem, clear test seeds
- [ ] Deployment: Push to production (Render/Heroku) and merge to master

---

## Current Status
**Branch:** `ui-ux-polish`

**Phases Complete:** Phase 1, Phase 2, Phase 3

**Current Phase:** Phase 5 — UI/UX Polish (in progress)

**Completed this session (April 20, 2026):** Auth redesign, password toggle + validation, journal color picker, footer redesign, bookshelf cleanup

**Next Tasks (Phase 5 remaining):** Mood emoji logic, date formatting, empty states

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

**Last Updated:** April 20, 2026
**Current Focus:** Phase 5 — UI/UX Polish (branch: `ui-ux-polish`)
