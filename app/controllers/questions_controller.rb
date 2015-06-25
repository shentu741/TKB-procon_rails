# -*- coding: utf-8 -*-
class QuestionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    id = params[:lesson_id] || 1
    @lesson = Lesson.find_by(:id => id)
    unless @lesson.nil?
      if UserLesson.find_by(:user_id => current_user.id, :lesson_id => id).nil?
        redirect_to root_path, :alert => "該当する授業に参加していません．"
      end
      @questions = @lesson.question
    else
      redirect_to root_path, :alert => "該当する授業が存在しません。"
    end
  end

  def new
    @question = Question.new
    @question.samples.build
    @question.test_data.build
  end


  def create
    @question = Question.new(question_params)

    if @question.save
      flash.notice='問題登録しました'
      redirect_to controller: 'lessons', action:'index'
    else
      redirect_to controller: 'lessons', action:'new'
    end
  end

  def show
    @question = Question.find(params[:id])
    answers = Answer.where(:student_id => current_user.id,
                           :question_id => params[:id],
                           :lesson_id => params[:lesson_id])
    @latest_answer = Answer.new
    unless answers.empty?
      last = answers.where(:result => 1).last
      @latest_answer = last.nil? ? answers.last : last
    end
  end


  private
  def question_params
    params.require(:question).permit(
      :title,
      :content,
      :input_description,
      :output_description,
      :run_time_limit,
      :memory_usage_limit,
      :cpu_usage_limit,
      samples_attributes: [:input,:output,:_destroy],
      test_data_attributes: [:input,:output,:_destroy]
    )
  end


end
