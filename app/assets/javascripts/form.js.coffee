$ ->
  question_number = 1
  add_question = (question = false) ->
    this_number = question_number
    question_number += 1
    target_el = $("#add_question")
      .before(_.template($("#question_form_template").html(), {}))
      .prev().find(".control-group")
    target_el.find("input[type=text]").attr("name", "question"+this_number)
    target_el.find("input[type=text]").val(question.question) if question
    add_el = target_el.after(_.template($("#answer_add_template").html(), {})).next()
    add_answer = (answer = false) ->
      add_el.before(_.template($("#answer_form_template").html(), {}))
      add_el.prev().find("input[type=text]").attr("name", "answers"+this_number+"[]")
      add_el.prev().find("input[type=number]").attr("name", "points"+this_number+"[]")
      if answer
        add_el.prev().find("input[type=text]").val(answer.answer)
        add_el.prev().find("input[type=number]").val(answer.point)
    delete_question = ->
      target_el.parent().remove()
    delete_answer = ->
      add_el.prev().remove()
    if question
      for answer in question.answers
        add_answer(answer)
    else
      add_answer()
    $(add_el).find(".add_answer").click add_answer
    $(add_el).find(".delete_question").click delete_question
    $(add_el).find(".delete_answer").click delete_answer

  $("#add_question .btn").click add_question

  questions = [
    {question: "デートはどこで遊びたいですか？", answers: [
      {answer:"映画館", point: 2},
      {answer:"カラオケ", point: -1},
      {answer:"解答2", point: 2},
      {answer:"解答2", point: 2},
      ]
    },
    {question: "質問2", answers: [
      {answer:"解答1", point: 3},
      {answer:"解答2", point: 1},
      {answer:"解答2", point: 2},
      {answer:"解答2", point: 2},
      ]
    }
  ]

  for question in questions
    add_question(question)
