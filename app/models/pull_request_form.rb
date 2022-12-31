

class PullRequestForm
  include ActiveModel::Model

  # All our attrs, defined here so we can access programmatically later
  ATTRS = [:merged_by, :milestone, :creator, :pr_merged_at_start, :pr_merged_at_end]
  # Not useful for serialization
  HELPER_ATTRS = [:pr_merged_at_start, :pr_merged_at_end]
  attr_accessor(*ATTRS)
  # validates :name, :email, :body, presence: true

  def initialize(params = {})
    params[:pr_merged_at_start] = params[:pr_merged_at_start].to_date if params[:pr_merged_at_start]
    params[:pr_merged_at_end] = params[:pr_merged_at_end].to_date if params[:pr_merged_at_end]
    super
  end

  def serialize
    query_params = {}
    query_params.merge!(serialize_date_attributes)
    query_params.merge!(serialize_other_attributes)
    query_params
  end

  def save
    if valid?
      # send email
      #ContactMailer.message(params).deliver_later
      true
    else
      false
    end
  end

  private

  def serialize_date_attributes
    { pr_merged_at: (@pr_merged_at_start || nil)..(@pr_merged_at_end || DateTime::Infinity.new) }
  end

  def serialize_other_attributes
    res = {}
    (ATTRS - HELPER_ATTRS).each do |a|
      res[a] = send(a) unless send(a).blank? || send(a).all?(&:blank?)
    end
    res
  end
end
