# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/comment_mailer
class CommentMailerPreview < ActionMailer::Preview
  def new_comment
    CommentMailer.new_comment(Comment.first).deliver_now
  end
end
