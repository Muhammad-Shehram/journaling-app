class JournalEntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_journal_entries, only: [ :show, :edit, :update, :destroy ]

  def index
    @journal_entries = current_user.journal_entries
  end
  def show
    # @journal_entry = current_user.journal_entries.find(params[:id])
  end

  def new
    @journal_entry = JournalEntry.new
    @journal_entry.entry_date = Date.today
  end

  def create
    @journal_entry = JournalEntry.new(journal_entry_params)
    @journal_entry.user = current_user
    if @journal_entry.save
      redirect_to journal_entry_path(@journal_entry)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @journal_entry = current_user.journal_entries.find(params[:id])
  end

  def update
    # @journal_entry = current_user.journal_entries.find(params[:id])
    if @journal_entry.update(journal_entry_params)
      redirect_to journal_entry_path(@journal_entry)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # @journal_entry = current_user.journal_entries.find(params[:id])
    @journal_entry.destroy
    # No need for app/views/restaurants/destroy.html.erb
    redirect_to journal_entries_path, status: :see_other
  end

  private
  def journal_entry_params
    params.require(:journal_entry).permit(:title, :content, :mood, :entry_date)
  end

  def set_journal_entries
    @journal_entry = current_user.journal_entries.find(params[:id])
  end
end
