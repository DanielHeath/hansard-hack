ActiveAdmin.register Speech do
  actions :index, :show
  index do
    column :nameid
    column :speech
    column :time
    config.sort_order = "time_desc"
  end
end
