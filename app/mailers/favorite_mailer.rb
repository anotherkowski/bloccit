class FavoriteMailer < ApplicationMailer
  default from: "bloccit@gmail.com"

  def new_comment(user, post, comment)
    headers["Message-ID"] = "<comments/#{comment.id}@your-app-name.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
    headers["References"] = "<post/#{post.id}@your-app-name.example>"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subect: "New comment on #{post.title}")
  end

  def new_post(user,post)
    headers["Message-ID"] = "<topic/#{post.topic.id}@your-app-name.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
    headers["References"] = "<post/#{post.id}@your-app-name.example>"

    @user = user
    @post = post

    mail(to: user.email, cc: "annhnova@gmail.com", subject: "You created #{post.title}")
  end
end
