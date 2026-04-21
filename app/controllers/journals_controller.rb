class JournalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_journal, only: [ :show, :edit, :update, :destroy ]

  def index
    @all_entries = current_user.journal_entries
                                .includes(:journal, :tags)
                                .order(entry_date: :desc)
    @stats = compute_stats
  end

  def show
    # This is where James sees the list of entries for this specific journal
    @journal_entries = @journal.journal_entries
  end

  def new
    @journal = current_user.journals.build
  end

  def create
    @journal = current_user.journals.build(journal_params)
    if @journal.save
      redirect_to journals_path, notice: "Journal created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @journal.update(journal_params)
      redirect_to journals_path(@journal)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @journal.destroy
    # No need for app/views/restaurants/destroy.html.erb
    # redirect_to journal_entries_path, status: :see_other
    redirect_to journals_path(@journal), status: :see_other
  end

  private

  def journal_params
    params.require(:journal).permit(:name, :color)
  end

  def set_journal
    @journal = current_user.journals.find(params[:id])
  end

  def compute_stats
    all_entries = current_user.journal_entries.order(entry_date: :desc)
    dates = all_entries.pluck(:entry_date).map(&:to_date).uniq.sort.reverse

    total_words = all_entries.sum do |e|
      e.content.to_plain_text.split.length
    end

    {
      total_entries: all_entries.count,
      total_journals: current_user.journals.count,
      total_words: total_words,
      current_streak: streak(dates),
      longest_streak: longest_streak(dates)
    }
  end

  def streak(dates)
    return 0 if dates.empty?
    return 0 unless [Date.today, Date.yesterday].include?(dates.first)

    count = 0
    dates.each_cons(2) do |a, b|
      break unless (a - b).to_i == 1
      count += 1
    end
    count + 1
  end

  def longest_streak(dates)
    return 0 if dates.empty?

    max = 1
    current = 1
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
