ActiveAdmin.register SessionTalker do
  actions :index, :show
  index do
    column :name
    column :electorate
    column :party
    column :ts
    column :parlinfo_avatar
    column :parlinfo_link
  end
end
