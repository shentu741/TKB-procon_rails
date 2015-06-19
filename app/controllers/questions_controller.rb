# -*- coding: utf-8 -*-
class QuestionsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @lesson = nil
    if params[:lesson_id]
      @lesson = Lesson.find(params[:lesson_id])
      ul = UserLesson.find_by(:user_id => current_user.id, :lesson_id => @lesson.id)
      if ul.nil?
        redirect_to root_path, :alert => "該当する授業に参加していません．"
      end
    end

    @lesson ? @questions = @lesson.question : @questions = Question.all
  end

  def new

  end

  def create
    @question = Question.new(params[:question])
    if @question.save
      flash.notice='問題登録しました'
      render action:'new'
    else
      render action:'new'
    end
  end

end
