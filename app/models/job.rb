class Job < ApplicationRecord
  after_create_commit { broadcast_prepend_to "jobs" }
  after_update_commit { broadcast_replace_to "jobs" }
  after_destroy_commit { broadcast_remove_to "jobs" }

  validates :title, presence: true
end
