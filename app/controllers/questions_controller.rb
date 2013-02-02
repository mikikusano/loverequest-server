class QuestionsController < ApplicationController
  def new
  end
  def create
    datas = []
    params.keys.each do |key|
      next unless key.include?("question") && params[key].present?
      data = {}
      data[:question] = params[key]
      number = key.gsub("question", "")
      next if params["answers" + number].blank?
      data[:answers] = []
      params["answers" + number].each_with_index{ |answer, i| data[:answers].push({ answer: answer, point: params["points" + number][i] }) }
      datas.push data
    end
    render json: datas
  end
end
