OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer # unless Rails.env.production?
end
# OmniAuth.config.test_mode = Rails.env.test?
OmniAuth.config.on_failure = Proc.new do | env |
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
end
OmniAuth.config.add_mock :default , {
                                      'provider' => 'test-provider' ,
                                      'uid'      => 'test-uid'      ,
                                      'info'     =>
                                      {
                                        'name'     => 'test-name'        ,
                                        'email'    => 'test@example.com' ,
                                        'nickname' => 'test-nick'
                                      }                             ,
                                      'extra' =>
                                      {
                                        'raw_info' =>
                                        {
                                          'location'    => 'Test Location'   ,
                                          'gravatar_id' => 'test-gravatarid'
                                        }
                                      }
                                    }
OmniAuth.config.add_mock :nfg , {
                                  'provider' => 'test-provider' ,
                                  'uid'      => ''              ,
                                  'info'     =>
                                  {
                                    'name'     => 'test-name'        ,
                                    'email'    => 'test@example.com' ,
                                    'nickname' => 'test-nick'
                                  }                             ,
                                  'extra' =>
                                  {
                                    'raw_info' =>
                                    {
                                      'location'    => 'Test Location'   ,
                                      'gravatar_id' => 'test-gravatarid'
                                    }
                                  }
                                }
