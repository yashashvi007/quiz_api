json.assesment(@assesment , :id, :title , :duration)
json.questions(@assesment.questions, :id , :text , :options)
