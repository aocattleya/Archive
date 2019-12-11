crumb :root do
  link "メルカリ", root_path
end

crumb :mypage do
  link "マイページ", user_path(current_user)
  parent :root
end

crumb :categories do
  link "カテゴリー一覧", root_path
  parent :root
end

crumb :profile do
  link "プロフィール"
  parent :mypage
end

crumb :card do |card|
  link "支払い方法", cards_path
  parent :mypage
end

crumb :logout do |logout|
  link "ログアウト", logout_path
  parent :mypage
end

crumb :order_result do |order_result|
  link "購入した商品 - 過去の取引", root_path
  parent :mypage
end

crumb :order do |order|
  link "支払い画面", order_path
  parent :order_result
end

crumb :nice do |nice|
  link "いいね一覧", nices_path
  parent :mypage
end

crumb :ParentCategory do |category|
  category = Category.find(params[:id])
  if category.parent.nil?
    link "#{category.name}", category_path(category.id)
  elsif category.parent.parent.nil?
    link "#{category.parent.name}", category_path(category.parent.id)
  else
    link "#{category.parent.parent.name}", category_path(category.parent.parent.id)
  end
  parent :categories
end

crumb :ChildCategory do |category|
  category = Category.find(params[:id])
  if category.parent.nil?
    link "#{category.name}", category_path(category.id)
  else
    link "#{category.parent.name}", category_path(category.parent.id)
  end
  parent :ParentCategory
end

crumb :Category do |category|
  category = Category.find(params[:id])
  link "#{category.name}", category_path(params[:id])
  if category.parent.nil?
    parent :categories
  elsif category.parent.parent.nil?
    parent :ParentCategory
  else
    parent :ChildCategory
  end
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).