xml.instruct! :xml, :version=>"1.0" 
xml.feed(:xmlns => "http://www.w3.org/2005/Atom") do |feed|
  feed.title('Super ')
  feed.link(root_url)
  for post in @posts do
    feed.entry do |entry|
      entry.id(post.id)
      entry.title(post.title)
      entry.content(post.matter, :type => 'text')
      entry.updated(post.updated_at)
      entry.link(post_path(post))
      entry.author do |author|
      	author.name post.user.login if post.user
      end
    end
  end
end
