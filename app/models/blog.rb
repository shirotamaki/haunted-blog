# frozen_string_literal: true

class Blog < ApplicationRecord
  belongs_to :user
  has_many :likings, dependent: :destroy
  has_many :liking_users, class_name: 'User', source: :user, through: :likings

  validates :title, :content, presence: true

  scope :published, -> { where('secret = FALSE') }

  scope :search, lambda { |term|
    where('title LIKE ?', "%#{term}%")
      .or(where('content LIKE ?', "%#{term}%"))
  }

  scope :default_order, -> { order(id: :desc) }

  scope :authorized_for, lambda { |user|
    where(user: user)
      .or(published)
  }

  def owned_by?(target_user)
    user == target_user
  end
end
