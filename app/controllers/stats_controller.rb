class StatsController < ApplicationController
  before_action :authenticate_user!

  def index
    all_entries = current_user.journal_entries.active.order(entry_date: :desc)
    dates = all_entries.pluck(:entry_date).map(&:to_date).uniq.sort.reverse

    @total_entries  = all_entries.count
    @total_journals = current_user.journals.count
    @total_words    = all_entries.sum { |e| e.content.to_plain_text.split.length }
    @current_streak = streak(dates)
    @longest_streak = longest_streak(dates)
    @writing_since  = dates.last

    @heatmap = current_user.journal_entries.active
                 .where(entry_date: 1.year.ago.to_date..Date.today)
                 .group(:entry_date).count

    @journals_data = current_user.journals.map do |j|
      { name: j.name, color: j.color || "#50C878", count: j.journal_entries.active.count }
    end.sort_by { |j| -j[:count] }
  end

  private

  def streak(dates)
    return 0 if dates.empty?
    return 0 unless [Date.today, Date.yesterday].include?(dates.first)
    count = 0
    dates.each_cons(2) { |a, b| (a - b).to_i == 1 ? count += 1 : break }
    count + 1
  end

  def longest_streak(dates)
    return 0 if dates.empty?
    max = current = 1
    dates.each_cons(2) do |a, b|
      if (a - b).to_i == 1
        current += 1
        max = current if current > max
      else
        current = 1
      end
    end
    max
  end
end
