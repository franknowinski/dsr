Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      defaults format: :json do
        resources :data_subject_rights, only: [:index, :create, :show, :update, :destroy]
      end
    end
  end
end
