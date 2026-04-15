class JournalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_journal, only: [ :show, :edit, :update, :destroy ]

  def index
    # James sees all HIS journals
    @journals = current_user.journals
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
    params.require(:journal).permit(:name)
  end

  def set_journal
    @journal = current_user.journals.find(params[:id])
  end
end
