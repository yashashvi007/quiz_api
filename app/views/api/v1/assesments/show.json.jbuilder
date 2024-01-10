json.assesment(@assesment, :id, :title, :duration, :difficulty_level)
json.questions(@assesment.questions ,:id, :text, :options)