class Video < ApplicationRecord
  include AASM

  belongs_to :user
  has_one :original_attachment, -> { where(attachment_type: Attachment.attachment_types[:original]) }, class_name: Attachment.name, dependent: :destroy
  has_one :cropped_attachment, -> { where(attachment_type: Attachment.attachment_types[:cropped]) }, class_name: Attachment.name, dependent: :destroy

  enum status: {
    scheduled: 0,
    processing: 1,
    done: 2,
    failed: 3
  }

  aasm column: :status, whiny_transitions: false, enum: true do
    state :scheduled, initial: true
    state :processing
    state :done
    state :failed


    event :process, after: :enqueue_cropping do
      transitions from: :scheduled, to: :processing
    end

    event :fail do
      transitions from: :processing, to: :failed
    end

    event :done do
      transitions from: :processing, to: :done
    end

    event :restart, after: :enqueue_cropping do
      transitions from: :failed, to: :processing
    end
  end

  def enqueue_cropping
    ::VideoCropJob.perform_later(self.id)
  end 
end
