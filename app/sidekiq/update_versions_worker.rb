class UpdateVersionWorker
  include Sidekiq::Worker
  sidekiq_options lock: :until_executed

  def perform(package_id)
    Package.find_by_id(package_id).update_versions
  end
end