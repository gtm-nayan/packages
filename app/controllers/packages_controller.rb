class PackagesController < ApplicationController
  def index
    @registry = Registry.find_by_name!(params[:registry_id])
    @recent_versions = @registry.versions.where('published_at > ?', 2.month.ago).where('published_at < ?', Time.now).group_by_day(:published_at).count
    @pagy, @packages = pagy(@registry.packages.order('latest_release_published_at DESC nulls last, created_at DESC'))
  end

  def show
    @registry = Registry.find_by_name!(params[:registry_id])
    @package = @registry.packages.find_by_name!(params[:id])
    @pagy, @versions = pagy(@package.versions.order('published_at DESC, created_at DESC'))
  end
end