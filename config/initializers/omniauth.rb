OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer # unless Rails.env.production?
end
OmniAuth.config.on_failure = Proc.new do | env |
  (OmniAuth::FailureEndpoint.new env).redirect_to_failure
end
if Rails.env.test?
#   OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock :default , {
                                        'provider' => 'mock-provider' ,
                                        'uid'      => 'mock-uid'      ,
                                        'info'     =>
                                        {
                                          'name'     => 'mock-nick'        ,
                                          'email'    => 'mock@example.com' ,
                                          'nickname' => 'mock-nickname'
                                        }                                  ,
                                        'extra' =>
                                        {
                                          'raw_info' =>
                                          {
                                            'location'    => 'Mock Location'   ,
                                            'gravatar_id' => 'mock-gravatarid'
                                          }
                                        }
                                      }
  OmniAuth.config.add_mock :nfg     , {
                                        'provider' => 'mocknfg-provider' ,
                                        'uid'      => ''                 ,
                                        'info'     =>
                                        {
                                          'name'     => 'mocknfg-nick'        ,
                                          'email'    => 'mocknfg@example.com' ,
                                          'nickname' => 'mocknfg-nickname'
                                        }                             ,
                                        'extra' =>
                                        {
                                          'raw_info' =>
                                          {
                                            'location'    => 'Mocknfg Location'   ,
                                            'gravatar_id' => 'mocknfg-gravatarid'
                                          }
                                        }
                                      }
end
