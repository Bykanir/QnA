class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, :url, presence: true
  validates :url, format: { with: URI::regexp(%w(http https)), message: 'invalid' }

  def gist?
    URI.parse(url).host.include?('gist.')
  end

  def gist
    client = Octokit::Client.new
    gist = client.gist(url.split("/").last)
    file = {}
    gist.files.each { |_, v| file = v }
    file.content
  end

end
