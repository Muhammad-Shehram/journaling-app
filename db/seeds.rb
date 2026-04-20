puts "Cleaning database..."
JournalEntry.destroy_all
Journal.destroy_all
User.destroy_all

puts "Creating demo user..."
alex = User.create!(
  email: "alex@reflekto.app",
  password: "Reflect0!",
  password_confirmation: "Reflect0!",
  name: "Alex"
)

# ── DAILY LIFE ────────────────────────────────────────────────────────────────
puts "Creating Daily Life journal..."
daily = Journal.create!(name: "Daily Life", color: "#7C6FF7", user: alex)

daily.journal_entries.create!([
  {
    title: "Slow Sunday Morning",
    entry_date: Date.new(2026, 4, 20),
    content: "Made coffee before anyone else was up. Sat by the window for a full hour without looking at my phone. It felt strange at first — almost guilty — but then something settled. I forget how much I need this kind of quiet. Planning to make it a Sunday habit."
  },
  {
    title: "The 6am Run I Almost Skipped",
    entry_date: Date.new(2026, 4, 17),
    content: "Set the alarm for 6. Snoozed it twice. Eventually dragged myself out at 6:20. The streets were empty and the air was cold and by the time I got home I felt like a completely different person. The hardest part is always just getting out the door."
  },
  {
    title: "Overthinking Again",
    entry_date: Date.new(2026, 4, 14),
    content: "Spent most of the evening in my head about a conversation that probably meant nothing to the other person. I know this pattern. I just can't always stop it mid-spiral. Wrote it out here to try to get it out of my head. It helps a little."
  },
  {
    title: "Good Day, No Particular Reason",
    entry_date: Date.new(2026, 4, 10),
    content: "Some days just work. Nothing major happened — got through my to-do list, had a good lunch, called my brother. I felt present in a way I don't always manage. Noting it here because I want to remember that ordinary days can feel like this."
  },
  {
    title: "Tired But Okay",
    entry_date: Date.new(2026, 4, 5),
    content: "Long week. Running on four hours last night. But I finished everything I set out to do and that counts for something. Early night tonight. No guilt about it."
  },
  {
    title: "Starting This Journal",
    entry_date: Date.new(2026, 3, 28),
    content: "Decided to actually try journaling properly. Not bullet points, not habit trackers — actual writing. I've started and stopped three times before. This time I want to be honest in it, even when what I write isn't flattering. Especially then."
  }
])

# ── WORK & CAREER ─────────────────────────────────────────────────────────────
puts "Creating Work & Career journal..."
work = Journal.create!(name: "Work & Career", color: "#63B3ED", user: alex)

work.journal_entries.create!([
  {
    title: "Q2 Kicked Off Well",
    entry_date: Date.new(2026, 4, 19),
    content: "First full week of Q2 and the team energy is genuinely good. We shipped the feature we'd been sitting on for two weeks and the feedback was positive. Reminded me why I like this work when the process isn't in the way."
  },
  {
    title: "The Meeting That Could've Been an Email",
    entry_date: Date.new(2026, 4, 15),
    content: "Two hours. Two. For a status update that could have been four bullet points. I stayed engaged but by the end I was just watching the clock. I need to get better at suggesting shorter formats without it feeling like a complaint."
  },
  {
    title: "Feedback I Didn't Expect",
    entry_date: Date.new(2026, 4, 11),
    content: "My manager mentioned in our 1:1 that I've been \"more present\" lately. I didn't realise anyone had noticed the effort I've been putting in. It matters more than I thought it would. Trying to figure out if that's good or if I should've been expecting less validation."
  },
  {
    title: "Thinking About the Next Step",
    entry_date: Date.new(2026, 4, 7),
    content: "Had coffee with a friend who just made a lateral move to a company I've always admired. Not jealous exactly — more like a reminder that I haven't sat down and thought seriously about where I want to be in two years. Need to do that soon."
  },
  {
    title: "Shipped Something I'm Proud Of",
    entry_date: Date.new(2026, 3, 31),
    content: "Closed out the month strong. The project I've been leading for six weeks is done and it's genuinely good work. I don't say that often enough about my own output. Today I'll let myself feel it."
  }
])

# ── TRAVEL ────────────────────────────────────────────────────────────────────
puts "Creating Travel journal..."
travel = Journal.create!(name: "Travel", color: "#4FD1C5", user: alex)

travel.journal_entries.create!([
  {
    title: "Porto, Day Two",
    entry_date: Date.new(2026, 4, 13),
    content: "Walked seventeen thousand steps according to my phone. Didn't feel like it. The old town is built on hills so steep you're basically doing lunges the whole time. Had the best pastel de nata of my life from a tiny place with no seating. The tiles on every building are something I wasn't prepared for."
  },
  {
    title: "Train to Somewhere Slow",
    entry_date: Date.new(2026, 4, 3),
    content: "Took a regional train with no particular destination, just picked a town from the map that had a river. Got off, walked around, found a café, sat for two hours. Nobody knew where I was. That kind of invisibility is its own kind of rest."
  },
  {
    title: "Hiking the Ridge Trail",
    entry_date: Date.new(2026, 3, 22),
    content: "The trail was harder than the listing said (they always are). Last kilometre was nearly vertical. But the view at the top was one of those moments where you feel briefly like everything is in proportion — your problems, your size, all of it. Came back down lighter."
  },
  {
    title: "Weekend in the City",
    entry_date: Date.new(2026, 3, 15),
    content: "Just two nights in a hotel I couldn't really justify. Ate at three places I'd bookmarked for months. Walked until my feet hurt. Saw an exhibition I'd almost missed. This is what I save money for and I should do it more often without needing a reason."
  }
])

# ── GRATITUDE ─────────────────────────────────────────────────────────────────
puts "Creating Gratitude journal..."
gratitude = Journal.create!(name: "Gratitude", color: "#68D391", user: alex)

gratitude.journal_entries.create!([
  {
    title: "For the Friend Who Just Checks In",
    entry_date: Date.new(2026, 4, 18),
    content: "Got a voice note out of nowhere today — just \"thinking of you, hope the week's been okay.\" Nothing else. That kind of unprompted kindness is rarer than it should be and I don't want to take it for granted."
  },
  {
    title: "Small Things, April Edition",
    entry_date: Date.new(2026, 4, 12),
    content: "The specific shade of light at 7pm this time of year. Finding a good playlist by accident. That my commute is short. Hot food after a cold day. These sound small but they add up to most of what makes a day good."
  },
  {
    title: "For Having Work I Actually Care About",
    entry_date: Date.new(2026, 4, 8),
    content: "I complain about work a fair amount — the meetings, the slow decisions, the red tape. But underneath it I actually care about what we're building. That's not something everyone gets. Worth writing down on a day when it's easy to forget."
  },
  {
    title: "For My Health",
    entry_date: Date.new(2026, 4, 1),
    content: "Had a check-up today. Everything fine. I only think about this when I'm sitting in a waiting room but I want to hold onto the feeling a bit longer this time. Feeling well enough to do the things I want to do is not a given."
  },
  {
    title: "For This Habit",
    entry_date: Date.new(2026, 3, 29),
    content: "One week of writing in here consistently. It's not much, but I've already noticed I'm processing things differently — less stuck in loops, more able to name what I'm actually feeling. That's worth something."
  }
])

puts ""
puts "✅ Done! Created:"
puts "   1 user      → alex@reflekto.app / Reflect0!"
puts "   4 journals  → Daily Life, Work & Career, Travel, Gratitude"
puts "   20 entries  → hand-crafted, realistic content"
