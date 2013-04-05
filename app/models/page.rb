# encoding: utf-8

class Page < ActiveRecord::Base
  # Relation ship
  belongs_to :author,
    class_name: 'User',
    foreign_key: :author_id
  belongs_to :category,
    class_name: 'PageCategory',
    foreign_key: :category_id

  # ページのツリー構造
  # 親ページ
  belongs_to :parent,
    class_name: 'Page',
    foreign_key: :parent_id
  # 子ページ
  has_many :children,
    class_name: 'Page',
    foreign_key: :parent_id


  # Validation
  # 必須項目
  validates :author_id,
    presence: true

  validates :name,
    presence: true,
    uniqueness: true,
    format: { with: /[a-zA-Z0-9_\-]+/ }

  # 関連先の存在チェック
  validate :author_exists?
  validate :category_exists?
  validate :parent_check


  # ページのパスを返す
  def path
    # 親ページがある場合は再帰して取得
    (self.parent ? self.parent.path : '') + '/' + self.name
  end

  private

  def author_exists?
    errors.add(:author_id, 'はDBに存在しません．') unless User.exists?(author_id)
  end

  def category_exists?
    # 空欄は許可
    # 空欄じゃ無いときカテゴリが存在するかチェック
    errors.add(:category_id, 'はDBに存在しません．') unless category_id.nil? || PageCategory.exists?(category_id)
  end

  def parent_check
    unless parent_id.nil?
      # 親ページが存在するかチェック
      # parent_id無しは許可（親無し）
      errors.add(:parent_id, 'ページはDBに存在しません．') unless Page.exists?(parent_id)
      # 自分自身を親にできない
      errors.add(:parent_id, 'このページ自身を親にすることはできません．') if self.id == parent_id
    end
  end
end
