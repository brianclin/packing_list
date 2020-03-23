# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :set_answer, only: %i[show edit update destroy]

  # GET /answers
  # GET /answers.json
  def index
    @answer = Answer.new
    @days = @answer.days
    @choice = @answer.choices
    @combined_list = @answer.list
    return if @days.empty? || @days.nil?

    add_clothing_by_days(@days)
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
    # do nothing
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
    # do nothing
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new
    if params[:id] == '5'
      @answer.days = params[:text]
    else
      @answer.add_choice(params[:text])
    end
    redirect_back fallback_location: { action: 'show', id: params[:id] }
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove
    @answer = Answer.new
    remove_everything(@answer, params[:text])
    @answer.remove_from_list(params[:item]) if params[:item]
    redirect_back fallback_location: { action: 'show', id: params[:id] }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_answer
    @answer = Answer.find(params[:id])
  end

  def remove_everything(answer, text)
    remove_days(text)
    answer.remove_choice(text)
  end

  def remove_days(days)
    case days
    when '0-3 days', '4-7 days', '8-14 days', 'Washer/Dryer', 'No Washer/Dryer'
      @answer.days = []
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def answer_params
    params.require(:answer).permit(:question_id, :choice_id)
  end

  def add_clothing_by_days(days)
    case days
    when '0-3 days'
      add_number_clothing(@combined_list, '1', '3-5', '3-5')
    when '4-7 days'
      add_number_clothing(@combined_list, '1', '7-9', '7-9')
    when '8-14 days'
      add_number_clothing(@combined_list, '2', '10-17', '10-17')
    when 'Washer/Dryer'
      add_number_clothing(@combined_list, '2', '7-9', '7-9')
    when 'No Washer/Dryer'
      add_number_clothing(@combined_list, '2', '17+', '17+')
    end
  end

  def add_number_clothing(list, contacts, socks, underwear)
    contacts_string = if contacts == '1'
                        '1 pair of contacts'
                      else
                        "#{contacts} pairs of extra contacts"
                      end
    list[:clothing].push(contacts_string)
    list[:clothing].push("#{socks} pairs of socks")
    list[:clothing].push("#{underwear} pairs of underwear")
  end
end
