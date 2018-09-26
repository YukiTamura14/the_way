json.id @comment.id
json.name @comment.user.name
json.content @comment.content
json.created_at @comment.created_at.strftime("%Y-%m-%d %H:%M:%S")
json.icon @comment.user.icon.url
json.current_user_id current_user.id
json.comment_user_id @comment.user.id
json.likes_count @comment.likes_count.presence || 0
