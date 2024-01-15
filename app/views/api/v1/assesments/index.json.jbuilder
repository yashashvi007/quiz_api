json.pagination do
  json.extract! @pagination,  :count, :page, :next
end

json.data do
  json.array! @assesments, :id , :title ,  :difficulty_level, :questions
end