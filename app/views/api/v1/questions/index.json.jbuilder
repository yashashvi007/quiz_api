json.pagination do
  json.extract! @pagination,  :count, :page, :next
end

json.assesment(@assesment , :id, :title , :duration)

json.data do
  json.array! @questions
end