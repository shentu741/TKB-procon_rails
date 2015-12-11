# -*- coding: utf-8 -*-
class Question < ActiveRecord::Base
  has_many :lesson_questions, :foreign_key => :question_id
  has_many :lessons, :through => :lesson_questions

  has_many :samples, :foreign_key => :question_id
  has_many :test_data, :foreign_key => :question_id
  has_many :answers, :foreign_key => :question_id
  has_many :question_keywords, :foreign_key => :question_id

  belongs_to :user, :foreign_key => :author

  accepts_nested_attributes_for :samples, allow_destroy: false, reject_if: :all_blank
  accepts_nested_attributes_for :test_data, allow_destroy: false, reject_if: :all_blank
  accepts_nested_attributes_for :lesson_questions, allow_destroy: false, reject_if: :all_blank
  accepts_nested_attributes_for :question_keywords, allow_destroy: false, reject_if: :all_blank

  rails_admin do
    weight 3

    create do
      field :title do
        required true
      end
      field :content do
        required true
        help "問題の説明など, #{help}"
      end
      field :input_description
      field :output_description
      field :question_keywords do
        required true
        help "インターネット剽窃チェックを行う際に利用するキーワード, #{help}"
      end
      field :run_time_limit do
        required true
        help "単位はms, #{help}"
      end
      field :memory_usage_limit do
        required true
        help "単位はMB, #{help}"
      end
      field :user do
        required true
      end

      field :samples do
        inverse_of :question
      end
      field :test_data do
        inverse_of :question
      end
      field :lessons
      field :version do
        required true
        help "問題を編集した場合に更新される値, #{help}"
      end
      field :is_public do
        help "この問題をパブリック問題として公開するかどうか, 非公開への変更は管理画面からのみ可能#{help}"
      end
    end

    edit do
      field :title do
        required true
      end
      field :content do
        required true
        help "問題の説明など, #{help}"
      end
      field :input_description
      field :output_description
      field :question_keywords do
        required true
        help "インターネット剽窃チェックを行う際に利用するキーワード, #{help}"
      end
      field :run_time_limit do
        required true
        help "単位はms, #{help}"
      end
      field :memory_usage_limit do
        required true
        help "単位はMB, #{help}"
      end
      field :user do
        required true
      end
      field :samples do
        inverse_of :question
      end
      field :test_data do
        inverse_of :question
      end
      field :lessons
      field :version do
        required true
        help "問題を編集した場合に更新される値, #{help}"
      end
      field :is_public do
        help "この問題をパブリック問題として公開するかどうか, 非公開への変更は管理画面からのみ可能#{help}"
      end
    end

    list do
      field :id
      field :title
      field :content
      field :lessons
      field :input_description
      field :output_description
      field :run_time_limit
      field :memory_usage_limit
      field :version
      field :user
      field :is_public
      field :samples
      field :test_data
      field :created_at
      field :updated_at
    end
  end

end
