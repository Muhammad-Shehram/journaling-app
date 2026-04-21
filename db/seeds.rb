puts "Cleaning database..."
JournalEntry.destroy_all
Journal.destroy_all
User.destroy_all
Tag.destroy_all

# ── HELPER ────────────────────────────────────────────────────────────────────
def tag_entry(entry, user, *names)
  names.each do |name|
    tag = Tag.find_or_create_by!(name: name.downcase.strip, user: user)
    EntryTag.find_or_create_by!(journal_entry: entry, tag: tag)
  end
end

# ── USER ──────────────────────────────────────────────────────────────────────
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

e = daily.journal_entries.create!(
  title: "Slow Sunday Morning",
  entry_date: Date.new(2026, 4, 20),
  content: "Made coffee before anyone else was up. Sat by the window for a full hour without looking at my phone. It felt strange at first — almost guilty — but then something settled.\n\nI forget how much I need this kind of quiet. The city was barely awake. A pigeon on the ledge opposite. The coffee cooling faster than I drank it. Nothing happening.\n\nPlanning to make it a Sunday habit. No phone until the cup is empty."
)
tag_entry(e, alex, "morning", "mindfulness", "routine")

e = daily.journal_entries.create!(
  title: "The 6am Run I Almost Skipped",
  entry_date: Date.new(2026, 4, 17),
  content: "Set the alarm for 6. Snoozed it twice. Eventually dragged myself out at 6:20, still half-asleep, convinced I'd turn back after five minutes.\n\nThe streets were empty and the air was cold and by the time I got home I felt like a completely different person. That's the thing about mornings — the version of me who hit snooze doesn't know what the version of me who ran knows.\n\nThe hardest part is always just getting out the door. Everything after that takes care of itself."
)
tag_entry(e, alex, "exercise", "morning", "discipline")

e = daily.journal_entries.create!(
  title: "Overthinking Again",
  entry_date: Date.new(2026, 4, 14),
  content: "Spent most of the evening in my head about a conversation that probably meant nothing to the other person. I know this pattern well enough by now. I just can't always stop it mid-spiral.\n\nWrote it out here to try to get it out of my head. It helps a little. Naming the spiral is at least something — it means I'm watching it rather than being it.\n\nTomorrow will feel different. It always does."
)
tag_entry(e, alex, "mental-health", "reflection", "anxiety")

e = daily.journal_entries.create!(
  title: "Good Day, No Particular Reason",
  entry_date: Date.new(2026, 4, 10),
  content: "Some days just work. Nothing major happened — got through my to-do list, had a good lunch, called my brother. I felt present in a way I don't always manage.\n\nI want to understand what made today different so I can replicate it, but maybe that's the wrong approach. Maybe some good days are just good days.\n\nNoting it here because I want to remember that ordinary days can feel like this. It's easy to only write when something's wrong."
)
tag_entry(e, alex, "mindfulness", "gratitude", "reflection")

e = daily.journal_entries.create!(
  title: "Tired But Okay",
  entry_date: Date.new(2026, 4, 5),
  content: "Long week. Running on four hours last night and it showed by 3pm. But I finished everything I set out to do and that counts for something.\n\nEarly night tonight. No guilt about it. Rest is not the reward for finishing — it's part of the work."
)
tag_entry(e, alex, "health", "rest", "reflection")

e = daily.journal_entries.create!(
  title: "Starting This Journal",
  entry_date: Date.new(2026, 3, 28),
  content: "Decided to actually try journaling properly. Not bullet points, not habit trackers — actual writing. I've started and stopped three times before. The first time I kept it for eleven days. The second time, four. The third, about a week before I got self-conscious reading it back.\n\nThis time I want to be honest in it, even when what I write isn't flattering. Especially then. The point isn't to document a good life — it's to understand the one I'm actually living."
)
tag_entry(e, alex, "journaling", "reflection", "intention")

# ── WORK & CAREER ─────────────────────────────────────────────────────────────
puts "Creating Work & Career journal..."
work = Journal.create!(name: "Work & Career", color: "#63B3ED", user: alex)

e = work.journal_entries.create!(
  title: "Q2 Kicked Off Well",
  entry_date: Date.new(2026, 4, 19),
  content: "First full week of Q2 and the team energy is genuinely good. We shipped the feature we'd been sitting on for two weeks and the feedback from users was better than I expected — specific, positive, actionable. The kind that makes you want to keep going.\n\nReminded me why I like this work when the process isn't in the way. The actual building part — the decisions, the iterations, seeing something work — that part I still love.\n\nWant to hold onto this feeling. Q1 ended with a lot of friction."
)
tag_entry(e, alex, "productivity", "shipping", "team")

e = work.journal_entries.create!(
  title: "The Meeting That Could've Been an Email",
  entry_date: Date.new(2026, 4, 15),
  content: "Two hours. Two. For a status update that could have been four bullet points sent on a Monday morning.\n\nI stayed engaged — I asked questions, I contributed where I could — but by the end I was just watching the clock and thinking about everything I wasn't doing.\n\nI need to get better at suggesting shorter formats without it feeling like a complaint. It's a skill. I don't have it yet."
)
tag_entry(e, alex, "meetings", "productivity", "communication")

e = work.journal_entries.create!(
  title: "Feedback I Didn't Expect",
  entry_date: Date.new(2026, 4, 11),
  content: "My manager mentioned in our 1:1 that I've been \"more present\" lately. Not more productive, not more output — more present. I've been working on that deliberately for about six weeks so I'm glad it's visible.\n\nI didn't realise how much it would matter to have someone notice. It matters more than I thought it would.\n\nI'm trying to figure out if that's good — healthy recognition of effort — or if I've been too reliant on external validation. Probably both."
)
tag_entry(e, alex, "feedback", "growth", "reflection")

e = work.journal_entries.create!(
  title: "Thinking About the Next Step",
  entry_date: Date.new(2026, 4, 7),
  content: "Had coffee with a friend who just made a lateral move to a company I've always admired. She's not earning more, she's not senior — she just wanted to work on a harder problem.\n\nNot jealous exactly. More like a reminder that I haven't sat down and thought seriously about where I want to be in two years. I've been so focused on doing the current job well that I haven't asked whether it's the right job.\n\nNeed to make time for that soon. Not urgently — but intentionally."
)
tag_entry(e, alex, "career", "goals", "reflection")

e = work.journal_entries.create!(
  title: "Shipped Something I'm Proud Of",
  entry_date: Date.new(2026, 3, 31),
  content: "Closed out the month strong. The project I've been leading for six weeks is done — actually done, not just done enough — and it's genuinely good work.\n\nI don't say that often enough about my own output. I'm quick to find the gaps, the things I'd do differently, the decisions that didn't land perfectly. Today I'm letting myself feel the part that did land.\n\nGood work. I made something good."
)
tag_entry(e, alex, "shipping", "pride", "career")

# ── TRAVEL ────────────────────────────────────────────────────────────────────
puts "Creating Travel journal..."
travel = Journal.create!(name: "Travel", color: "#4FD1C5", user: alex)

e = travel.journal_entries.create!(
  title: "Porto, Day Two",
  entry_date: Date.new(2026, 4, 13),
  content: "Walked seventeen thousand steps according to my phone. Didn't feel like it. The old town is built on hills so steep you're basically doing lunges the whole time, which means you're never quite comfortable but also never quite bored.\n\nHad the best pastel de nata of my life from a tiny place with no seating and one person working. Ate it standing outside. The tiles on every building are something I wasn't prepared for — the scale of them, the detail, the fact that it's just everywhere, like wallpaper for an entire city.\n\nI've been here two days and I already don't want to leave."
)
tag_entry(e, alex, "portugal", "europe", "food", "city")

e = travel.journal_entries.create!(
  title: "Train to Somewhere Slow",
  entry_date: Date.new(2026, 4, 3),
  content: "Took a regional train with no particular destination — just picked a town from the map that had a river and a name I couldn't pronounce. Got off, walked around for an hour, found a café, sat for two hours with a book I barely read.\n\nNobody knew where I was. No plans, no itinerary, no one to check in with. That kind of invisibility is its own kind of rest — different from being home alone, different from being off the grid. Just quietly somewhere else.\n\nI should do this more. Book a ticket to a place I know nothing about and see what's there."
)
tag_entry(e, alex, "europe", "slow-travel", "solitude")

e = travel.journal_entries.create!(
  title: "Hiking the Ridge Trail",
  entry_date: Date.new(2026, 3, 22),
  content: "The trail was harder than the listing said. They always are. The photos show the view; they don't show the last kilometre, which was nearly vertical and made me seriously reconsider what I'd signed up for.\n\nBut the view at the top was one of those moments where you feel briefly like everything is in proportion — your problems, your size, the amount of time you've been worrying about something that won't matter in a year. All of it rescaled.\n\nCame back down lighter. That's the only word for it."
)
tag_entry(e, alex, "hiking", "nature", "adventure", "perspective")

e = travel.journal_entries.create!(
  title: "Weekend in the City",
  entry_date: Date.new(2026, 3, 15),
  content: "Just two nights in a hotel I couldn't really justify — not a special occasion, not a work trip, just a weekend I decided to spend somewhere that wasn't home.\n\nAte at three places I'd bookmarked for months. Walked until my feet hurt in the way that feels earned rather than wasteful. Saw an exhibition I'd almost missed and stood in front of one painting for longer than I expected to.\n\nThis is what I save money for and I should do it more often without needing a reason. \"Because I wanted to\" is a complete sentence."
)
tag_entry(e, alex, "city", "food", "culture", "solo-travel")

# ── GRATITUDE ─────────────────────────────────────────────────────────────────
puts "Creating Gratitude journal..."
gratitude = Journal.create!(name: "Gratitude", color: "#68D391", user: alex)

e = gratitude.journal_entries.create!(
  title: "For the Friend Who Just Checks In",
  entry_date: Date.new(2026, 4, 18),
  content: "Got a voice note out of nowhere today — just \"thinking of you, hope the week's been okay.\" Nothing else. No ask, no occasion, no reason.\n\nThat kind of unprompted kindness is rarer than it should be and I don't want to take it for granted. She didn't need to send that. She sent it anyway.\n\nI want to be better at doing the same thing — reaching out when someone crosses my mind instead of assuming they know I'm thinking of them."
)
tag_entry(e, alex, "friendship", "gratitude", "connection")

e = gratitude.journal_entries.create!(
  title: "Small Things, April Edition",
  entry_date: Date.new(2026, 4, 12),
  content: "The specific shade of light at 7pm this time of year, when it's finally staying late enough to matter. Finding a good playlist entirely by accident and adding it without knowing why it's working. That my commute is short enough to walk when I want to think.\n\nHot food after a cold day. A reply that arrived faster than expected. The particular satisfaction of finishing a book.\n\nThese sound small but they add up to most of what makes a day good. I think the practice of writing them down is making me better at noticing them."
)
tag_entry(e, alex, "gratitude", "mindfulness", "small-things")

e = gratitude.journal_entries.create!(
  title: "For Having Work I Actually Care About",
  entry_date: Date.new(2026, 4, 8),
  content: "I complain about work a fair amount — the slow decisions, the meetings, the gap between what we say we'll do and what we actually do. And some of those complaints are valid.\n\nBut underneath all of it I actually care about what we're building. I care whether it works. I care whether the people using it find it useful. Not everyone gets to feel that way about their job, and I know it.\n\nWorth writing down on a day when it's easy to forget."
)
tag_entry(e, alex, "work", "gratitude", "purpose")

e = gratitude.journal_entries.create!(
  title: "For My Health",
  entry_date: Date.new(2026, 4, 1),
  content: "Had a check-up today. Everything fine. Blood pressure normal, nothing to flag, come back in a year.\n\nI only think about this when I'm sitting in a waiting room — how much of what I want to do depends on just... working. Being able to walk, sleep, think, not be in pain.\n\nI want to hold onto the feeling a bit longer this time. Feeling well enough to do the things I want to do is not a given and I don't treat it like the gift it is."
)
tag_entry(e, alex, "health", "gratitude", "body")

e = gratitude.journal_entries.create!(
  title: "For This Habit",
  entry_date: Date.new(2026, 3, 29),
  content: "One week of writing in here consistently. That's not a long time, but it's longer than I've managed before.\n\nI've already noticed I'm processing things differently — less stuck in the same loops, more able to name what I'm actually feeling rather than just carrying it around as vague weight. Getting it out of my head and into words seems to do something.\n\nI don't know if this version of the habit will stick. But I'm glad I started again."
)
tag_entry(e, alex, "journaling", "gratitude", "growth", "reflection")

puts ""
puts "✅ Done! Created:"
puts "   1 user      → alex@reflekto.app / Reflect0!"
puts "   4 journals  → Daily Life, Work & Career, Travel, Gratitude"
puts "   20 entries  → hand-crafted, realistic content"
puts "   #{Tag.count} tags       → #{Tag.pluck(:name).sort.join(', ')}"
