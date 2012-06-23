class CreateComments < ActiveRecord::Migration

  def up
    create_table 'comments' do |t|
      t.text       'comments'
      t.references 'user'
      t.references 'movie'
    end
  end
  def down ; drop_table 'comments' ; end
end
