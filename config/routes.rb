Hansearch::Application.routes.draw do
  root :to => 'welcome#index'
  ActiveAdmin.routes(self)
end
