class PromptsController < ApplicationController
  before_action :authenticate_user!

  CATEGORY_ICONS = {
    "Intentions"      => "fa-compass",
    "Reflections"     => "fa-book-open",
    "Gratitude & Joy" => "fa-heart",
    "Self-Discovery"  => "fa-user-pen",
    "Growth & Career" => "fa-seedling",
    "Mental Health"   => "fa-brain",
    "Creativity"      => "fa-palette"
  }.freeze

  PROMPTS_BY_CATEGORY = {
    "Intentions" => [
      "What is the one thing you want to feel at the end of today?",
      "If today had a theme song, what would it be and why?",
      "What is a \"win\" you are going to chase before the sun sets?",
      "How can you be 1% kinder to yourself today?",
      "Identify one potential stressor today. How will you choose to respond to it?",
      "What is the most important task on your plate, and why does it matter?",
      "What does your body need from you today — rest, movement, or hydration?",
      "Write down one affirmation that makes you feel powerful right now.",
      "Who is someone you can encourage or support today?",
      "What is one habit you want to practice with intention today?",
      "If you had an extra hour this morning, how would you have spent it?",
      "Before you dive into your day, take a moment to scan your body. Where are you holding tension right now? What does it tell you about what you need most today?",
      "What are you letting go of from yesterday to start fresh today?",
      "What is one genuinely restorative thing you could do for yourself today — something that actually refills you, not just distracts you? What has been stopping you from doing it?",
      "What are you most curious about regarding the day ahead?"
    ].freeze,
    "Reflections" => [
      "What was the \"High\" and the \"Low\" of your last 24 hours?",
      "What made you laugh or smile today?",
      "What did you learn about yourself through today's challenges?",
      "What is one thing you did today that your future self will thank you for?",
      "Think back over the past week. What is one moment — however small — that you almost let pass by without appreciating it?",
      "When did you last do something purely for the enjoyment of it, with no audience and no outcome in mind? How did it feel?",
      "What is the most difficult thing you've navigated in the past month? What did it demand of you that you didn't know you had?",
      "Looking back over the last twelve months, what is the one thing you wish you had started earlier — and what finally made you start, or what is still stopping you?",
      "What is something in your life right now that you have quietly accepted as \"good enough,\" even though it no longer fits who you are?",
      "Of the people who have had the most presence in your life this past year, who has made you more yourself? Who has made you less?",
      "What is one door that has quietly opened for you recently that you haven't fully stepped through yet? What is holding you in the doorway?",
      "What is a day from your past that your mind keeps returning to, years later? What made it matter so much?",
      "Think of someone who changed the direction of your life — perhaps without realizing it. What did they do, and where would you be without it?",
      "What is the one thing experience has taught you that no one could have simply told you — you had to live it to understand?",
      "When did you last choose the harder, braver option over the easier, safer one? What did it cost you, and what did it give you?",
      "If you could revisit any single decision from your past — not to change it, but just to understand it better — which one would you go back to, and why?",
      "What is the one sentence you would most want someone who knew you well to say about you — not at a eulogy, but just as a plain, honest fact?",
      "What is something you believed about yourself for years that turned out not to be true? What finally changed your mind?",
      "Twenty years from now, what do you hope to have more of in your life — and what do you hope to have less of?",
      "What is a story you've been telling yourself about who you are that may no longer be accurate?"
    ].freeze,
    "Gratitude & Joy" => [
      "List three small things that often go unnoticed but made your life better today.",
      "What is a piece of technology you are incredibly grateful for?",
      "Write about a \"simple pleasure\" that never fails to make you happy.",
      "Who is a teacher or mentor — past or present — you are thankful for?",
      "What is a hardship you've faced that you are now grateful for?",
      "Describe your favorite room in your home and why it brings you peace.",
      "What is a song that always shifts your mood for the better?",
      "List three qualities about your personality that you truly appreciate.",
      "What is a \"hidden gem\" in your neighborhood or city that you love?",
      "Write about a time a stranger was unexpectedly kind to you.",
      "What is a book or film that changed the way you see the world?",
      "What aspect of your health or body are you most grateful for right now?",
      "Describe a meal you ate recently that felt like a small gift.",
      "What is a freedom you have that you sometimes take for granted?",
      "Who was the first person to truly believe in you?"
    ].freeze,
    "Self-Discovery" => [
      "If you could have a conversation with your 10-year-old self, what would you say?",
      "What are three words your closest friends would use to describe you?",
      "What is a boundary you've struggled to set — and what has that cost you?",
      "What does \"success\" actually look like to you, outside of money or titles?",
      "What is a dream you've been afraid to say out loud?",
      "Describe your ideal ordinary day from start to finish.",
      "What is a trait you admire in others that you wish you practiced more?",
      "If your life right now were a season — not just the weather, but the energy, the pace, and the feeling — which season would it be? What does that tell you about what's coming next?",
      "What makes you feel the most at home in your own skin?",
      "What is a belief you held five years ago that you no longer hold?",
      "How do you typically react to praise? To criticism?",
      "What is your inner critic currently telling you, and how can you answer back with truth?",
      "What are you currently overcomplicating in your life?",
      "What is your favorite way to spend time completely alone?",
      "If you could master any one skill overnight, what would it be and why?",
      "What is something you find genuinely fascinating that you rarely bring up with others? Why do you keep it close rather than share it freely?",
      "Think of one specific moment in your past when you felt completely at ease — no rushing, no performing, no anxious loops. Where were you? What made it possible? How far does that feeling seem right now?",
      "What is the most courageous thing you have ever done?",
      "Write about a place you have never been but feel a pull toward.",
      "What does your comfort zone look like right now, and is it time to leave it?"
    ].freeze,
    "Growth & Career" => [
      "What is a mistake you made recently, and what did it teach you?",
      "What is the most uncomfortable truth you've been quietly circling around lately — something you already know but haven't fully looked at yet?",
      "How do you handle imposter syndrome when it shows up?",
      "What is one professional goal you want to achieve in the next six months?",
      "Describe a time you failed and how you found your way back.",
      "Who is someone in your field you genuinely look up to, and why?",
      "What is a habit that is currently holding you back from your potential?",
      "How do you balance ambition with your need for rest?",
      "What would you do if you knew you couldn't fail?",
      "What is the best piece of career advice you have ever received?",
      "Are you working toward your own goals, or someone else's?",
      "What is a difficult conversation you have been postponing?",
      "How has your definition of \"work\" changed over the years?",
      "What part of your work brings you the most genuine satisfaction?",
      "If you could change careers tomorrow without any consequences, what would you do?"
    ].freeze,
    "Mental Health" => [
      "What is currently draining your energy more than anything else?",
      "Where in your life do you need to say \"No\" more often?",
      "What are three things that instantly make you feel grounded when you're anxious?",
      "How do you show yourself compassion on your difficult days?",
      "Write a letter of forgiveness to someone — you don't have to send it.",
      "When everything feels like too much, what thought, memory, or image tends to bring you back to yourself? Where did it come from, and why does it work?",
      "Describe a time you felt truly heard and understood.",
      "What does self-care look like for you when it has nothing to do with spending money?",
      "How do you navigate feelings of loneliness?",
      "What is a recurring thought or worry you've been carrying lately?",
      "What are the early warning signs that you are burning out?",
      "Who are the people in your life who make you feel the safest?",
      "Where in your life are you carrying more than you actually need — physically, emotionally, or socially? What would it feel like to set one of those things down, even temporarily?",
      "Write about a time you stood up for yourself.",
      "What is a truth you have been avoiding?"
    ].freeze,
    "Creativity" => [
      "If you could travel to any fictional world, where would you go and why?",
      "Imagine a stranger who has been silently watching your life for the past month — your routines, your habits, your reactions. What story would they tell about you? Is it the story you want to be telling?",
      "What is a creative project you would start if time and money were no object?",
      "If you had to describe your life as a movie genre right now, what would it be?",
      "Write about a scent that triggers a specific, vivid memory.",
      "What is the most beautiful thing you saw this week?",
      "What is one thing you genuinely want to do but keep not doing — not a fantasy, but something real that fear or circumstance has been blocking? If the fear of consequences disappeared tomorrow, would you actually do it?",
      "What is a question you wish people would ask you more often?",
      "If you could change one thing about the way humans communicate, what would it be?",
      "Write a \"User Manual\" for yourself — how to handle you, what you love, and what you don't."
    ].freeze
  }.freeze

  def index
    @categories = PROMPTS_BY_CATEGORY.map do |name, prompts|
      { name: name, count: prompts.length, icon: CATEGORY_ICONS[name] }
    end
  end

  def show
    @category = PROMPTS_BY_CATEGORY.keys.find { |k| k.parameterize == params[:category] }
    redirect_to prompts_path and return unless @category
    @prompts = PROMPTS_BY_CATEGORY[@category]
  end
end
