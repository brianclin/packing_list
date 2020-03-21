# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :set_answer, only: %i[show edit update destroy]

  # GET /answers
  # GET /answers.json
  def index
    @answer = Answer.new
    @days = @answer.get_days
    @choice = @answer.get_choices
    @combined_list = @answer.list
    return if @days.empty? || @days.nil?
    case @days
    when '0-3 days'
      @combined_list[:clothing].push('1 pair of extra contacts')
      @combined_list[:clothing].push('3-5 pairs of socks')
      @combined_list[:clothing].push('3-5 pairs of underwear')
    when '4-7 days'
      @combined_list[:clothing].push('1 pair of extra contacts')
      @combined_list[:clothing].push('7-9 pairs of socks')
      @combined_list[:clothing].push('7-9 pairs of underwear')
    when '8-14 days'
      @combined_list[:clothing].push('2 pairs of extra contacts')
      @combined_list[:clothing].push('10-17 pairs of socks')
      @combined_list[:clothing].push('10-17 pairs of underwear')
    when 'Washer/Dryer'
      @combined_list[:clothing].push('2 pairs of extra contacts')
      @combined_list[:clothing].push('7-9 pairs of socks')
      @combined_list[:clothing].push('7-9 pairs of underwear')
    when 'No Washer/Dryer'
      @combined_list[:clothing].push('2 pairs of extra contacts')
      @combined_list[:clothing].push('17+ pairs of socks')
      @combined_list[:clothing].push('17+ pairs of underwear')
    end
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
      @answer.set_days(params[:text])
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
    @answer.remove_from_list(params[:item]) if params[:item]
    @answer.remove_choice(params[:text])
    redirect_back fallback_location: { action: 'show', id: params[:id] }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_answer
    @answer = Answer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def answer_params
    params.require(:answer).permit(:question_id, :choice_id)
  end
end
