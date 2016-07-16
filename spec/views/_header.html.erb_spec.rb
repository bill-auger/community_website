require 'rails_helper'

RSpec.describe 'layouts/_header' , :type => :view do
  let(:mail_img_html  ) { /<img alt="messages" id="top-nav-mail-img" src="\/assets\/mail.png" \/>/        }
  let(:alerts_img_html) { /<img alt="notifications" id="top-nav-alerts-img" src="\/assets\/bell.png" \/>/ }
  let(:fans_img_html  ) { /<img alt="follows" id="top-nav-fans-img" src="\/assets\/follows.png" \/>/      }
  let(:user_img_html  ) { /<img alt="avatar" id="top-nav-user-img" src="\/assets\/my-mm.png" \/>/         }

  def expect_nav_btns
    (expect response).to render_template 'layouts/_header'
    (expect rendered).to match /<img alt="livecoding.tv logo" src="\/assets\/lctv-users-logo.png" \/>/
    (expect rendered).to match /Home/
    (expect rendered).to match /Projects/
    (expect rendered).to match /Users/
    (expect rendered).to match /Badges/
    (expect rendered).to match /Emoticons/
  end

  def expect_login_btns
    (expect rendered).to     match /LOGIN/
    (expect rendered).to     match /SIGN UP/
    (expect rendered).not_to match mail_img_html
    (expect rendered).not_to match alerts_img_html
    (expect rendered).not_to match fans_img_html
    (expect rendered).not_to match user_img_html
  end

  def expect_user_btns
    (expect rendered).not_to match /LOGIN/
    (expect rendered).not_to match /SIGN UP/
    (expect rendered).to     match mail_img_html
    (expect rendered).to     match alerts_img_html
    (expect rendered).to     match fans_img_html
    (expect rendered).to     match user_img_html
  end

  context "when signed out" do
    it "renders the top navbar with login buttons" do
      assign :lctv_user , ''
      render

      expect_nav_btns
      expect_login_btns
    end
  end

  context "when signed in" do
    it "renders the top navbar with user buttons" do
      assign :lctv_user , 'a-nick'
      render

      expect_nav_btns
      expect_user_btns
    end
  end
end
