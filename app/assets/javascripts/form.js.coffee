$ ->
  question_number = 1
  add_question = ->
    this_number = question_number
    question_number += 1
    target_el = $("#add_question")
      .before(_.template($("#question_form_template").html(), {}))
      .prev().find(".control-group")
    target_el.find("input[type=text]").attr("name", "question"+this_number)
    add_el = target_el.after(_.template($("#answer_add_template").html(), {})).next()
    add_answer = ->
      add_el.before(_.template($("#answer_form_template").html(), {}))
      add_el.prev().find("input[type=text]").attr("name", "answers"+this_number+"[]")
      add_el.prev().find("input[type=number]").attr("name", "points"+this_number+"[]")
    delete_question = ->
      target_el.parent().remove()
    delete_answer = ->
      add_el.prev().remove()
    add_answer()
    $(add_el).find(".add_answer").click add_answer
    $(add_el).find(".delete_question").click delete_question
    $(add_el).find(".delete_answer").click delete_answer

  add_question()

  $("#add_question .btn").click add_question
