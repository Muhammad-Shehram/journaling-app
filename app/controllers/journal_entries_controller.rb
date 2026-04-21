class JournalEntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_journal
  before_action :set_journal_entries, only: [ :show, :edit, :update, :destroy ]


  def index
    @journal_entries = @journal.journal_entries.order(entry_date: :desc)
    @journal_entries = @journal_entries.where("title LIKE ?", "%#{params[:q]}%") if params[:q].present?
    @journal_entries = @journal_entries.where(mood: params[:mood]) if params[:mood].present?
    @journal_entries = @journal_entries.where("entry_date >= ?", params[:from]) if params[:from].present?
    @journal_entries = @journal_entries.where("entry_date <= ?", params[:to]) if params[:to].present?
    if params[:tag].present?
      @journal_entries = @journal_entries.joins(:tags).where(tags: { name: params[:tag].downcase })
    end
    @user_tags = current_user.tags.order(:name)
    @all_entry_dates = @journal.journal_entries.pluck(:entry_date).map { |d| d.to_date.strftime("%Y-%m-%d") }
  end

  def show
  end

  def new
    @journal_entry = @journal.journal_entries.build
    @journal_entry.entry_date = Date.today
    @user_tags = current_user.tags.order(:name)
  end

  def create
    @journal_entry = @journal.journal_entries.build(journal_entry_params)
    if @journal_entry.save
      save_tags(@journal_entry)
      redirect_to journal_journal_entry_path(@journal, @journal_entry)
    else
      @user_tags = current_user.tags.order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user_tags = current_user.tags.order(:name)
  end

  def update
    if @journal_entry.update(journal_entry_params)
      save_tags(@journal_entry)
      redirect_to journal_journal_entry_path(@journal, @journal_entry)
    else
      @user_tags = current_user.tags.order(:name)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @journal_entry.destroy
    redirect_to journal_journal_entries_path(@journal), status: :see_other
  end

  private

  def journal_entry_params
    params.require(:journal_entry).permit(:title, :content, :mood, :entry_date, :cover_photo)
  end

  def save_tags(entry)
    tag_list = params.dig(:journal_entry, :tag_list).to_s
    tag_names = tag_list.split(",").map(&:strip).map(&:downcase).reject(&:blank?).uniq
    entry.entry_tags.destroy_all
    tag_names.each do |name|
      tag = current_user.tags.find_or_create_by!(name: name)
      entry.entry_tags.create!(tag: tag)
    end
  end

  def set_journal_entries
    @journal_entry = @journal.journal_entries.find(params[:id])
  end

  def set_journal
    @journal = current_user.journals.find(params[:journal_id])
  end
end
