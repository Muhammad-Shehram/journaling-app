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

### 🎨 Phase 3: The Public Face & UX
*Goal: Make the app look professional and handle navigation smoothly.*

- [ ] Marketing Landing Page: Build `Pages#home` for non-logged-in users
- [ ] Root Logic: Logged out → Landing page, Logged in → Bookshelf (`journals#index`)
- [ ] Navigation Bar: "My Journals", "New Entry", "Logout"
- [ ] Flash Messages: "Entry saved successfully!" popups

---

### ✍️ Phase 4: The "Apple" Polish (Rich Content)
*Goal: Upgrade from basic text to a premium writing experience.*

- [ ] Migration to ActionText: Upgrade content field to Rich Text (Bold, Italics, Links)
- [ ] Media & Photos: Allow photo attachments via ActiveStorage
- [ ] Search & Filtering: Search entries by title or filter by mood/date

---

### 💅 Phase 5: UI/UX Polish (The "Final Look")
*Goal: Transform basic HTML into sleek design using Bootstrap + Le Wagon stylesheet.*

- [ ] CSS/Bootstrap Integration: Style Journals as cards/books (dark mode)
- [ ] Mood Logic: Auto-show emoji based on mood (🔥, 😴, 😊)
- [ ] Date Formatting: Change `2026-04-15` to `April 15, 2026`
- [ ] Empty States: Nice views for "No entries yet"

---

### 🚀 Phase 6: Final Refinement & Launch
*Goal: Squash bugs and go live.*

- [ ] Cleanup: Remove faker gem, clear test seeds
- [ ] Deployment: Push to production (Render/Heroku) and merge to master

---

## Current Status
**Branch:** `add-journals-layer`

**Phases Complete:** Phase 1 & Phase 2

**Current Phase:** Phase 3 — The Public Face & UX

**Next Immediate Task:** Build the Marketing Landing Page (`Pages#home`) and set up root path logic

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

**Last Updated:** April 18, 2026
**Current Focus:** Phase 5 — UI/UX Polish (branch: `ui-ux-polish`)
