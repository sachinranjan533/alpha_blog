module UsersHelper
    def gravatar_for(user,size: 80)
        hash = Digest::MD5.hexdigest("sachin.ranjan@unthinkable.co")
        image_src = "http://www.gravatar.com/avatar/#{hash}?s=#{size}"
        image_tag(image_src, alt: user.username,class: "rounded shadow mx-auto d-block")
    end
end