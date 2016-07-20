require 'rails_helper'


RSpec.describe 'shared/_navbar' , :type => :view do
  let(:test_user      ) { (User.find_or_create_with_omniauth OmniAuth.config.mock_auth[:default])         }
  let(:mail_img_html  ) { /<img id="top-nav-mail-img" alt="messages" src="\/assets\/mail.png" \/>/        }
  let(:alerts_img_html) { /<img id="top-nav-alerts-img" alt="notifications" src="\/assets\/bell.png" \/>/ }
  let(:fans_img_html  ) { /<img id="top-nav-fans-img" alt="follows" src="\/assets\/follows.png" \/>/      }
  let(:user_img_html  ) { /<img id="top-nav-user-img" alt="avatar" src="\/assets\/my-mm.png" \/>/         }


  def expect_nav_btns
    (expect response).to render_template 'shared/_navbar'
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
      render

      expect_nav_btns
      expect_login_btns
    end
  end

  context "when signed in" do
    it "renders the top navbar with user buttons" do
      session[:user_id] = 1
      assign :current_user , test_user
      render

      expect_nav_btns
      expect_user_btns
    end
  end
end
