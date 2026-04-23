class PromptsController < ApplicationController
  before_action :authenticate_user!

  CATEGORY_ICONS = {
    "Reflection"  => "fa-user-pen",
    "Gratitude"   => "fa-heart",
    "Creativity"  => "fa-palette",
    "Goals"       => "fa-bullseye",
    "Mindfulness" => "fa-brain"
  }.freeze

  PROMPTS_BY_CATEGORY = {
    "Reflection" => [
      "What is one belief you held five years ago that you no longer hold? What changed your mind?",
      "Describe a moment this week when you felt most like yourself. What made it feel that way?",
      "What would you do differently if you knew no one would judge the outcome?",
      "What is something you keep putting off, and what is the real reason behind it?",
      "Write about a relationship that has shaped who you are today — not necessarily the most obvious one."
    ].freeze,
    "Gratitude" => [
      "What is something ordinary you experienced today that you would miss if it were gone?",
      "Name someone who made your life better without realising it. What would you want them to know?",
      "What challenge from your past are you now grateful for? What did it teach you?",
      "Describe a place — physical or emotional — where you always feel safe. Why does it feel that way?",
      "What is one small thing your body allowed you to do today that you usually take for granted?"
    ].freeze,
    "Creativity" => [
      "You discover a door in your home that was never there before. What is behind it?",
      "Write the opening paragraph of the novel that only you could write.",
      "Describe your current life as if it were a film genre. What genre is it, and who plays you?",
      "If your current mood were a landscape, what would it look like at this exact moment?",
      "Pick an object within reach and write its autobiography."
    ].freeze,
    "Goals" => [
      "What does your ideal ordinary Tuesday look like, five years from now? Be specific.",
      "Which goal have you been circling without committing to? Write out the first three concrete steps.",
      "What are you tolerating in your life right now that you no longer want to tolerate?",
      "If you could only accomplish one thing this month, what would make everything else easier or irrelevant?",
      "Write a letter from your future self explaining why a risk you are hesitating over was worth taking."
    ].freeze,
    "Mindfulness" => [
      "Without looking at your phone, what do you notice right now — sounds, sensations, light?",
      "What emotion have you been carrying around today without naming it? Name it now.",
      "Describe the last time you were fully present, not thinking about the past or future.",
      "What is your body trying to tell you right now that your mind has been ignoring?",
      "Write about one thing you can accept today exactly as it is, without wanting it to be different."
    ].freeze
  }.freeze

  def index
    @categories = PROMPTS_BY_CATEGORY.map do |name, prompts|
      { name: name, count: prompts.length, icon: CATEGORY_ICONS[name] }
    end
  end

  def show
    @category = PROMPTS_BY_CATEGORY.keys.find { |k| k.downcase == params[:category].downcase }
    redirect_to prompts_path and return unless @category
    @prompts = PROMPTS_BY_CATEGORY[@category]
  end
end
