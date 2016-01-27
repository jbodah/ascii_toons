require 'ascii_toons/version'
require 'ascii_toons/art'

module ASCIIToons
  def self.register(name, template)
    ASCIIToons.const_set name, ASCIIToons::Art.new(template)
  end

  DEFAULT_TEMPLATE_PATH = File.expand_path('../../templates', __FILE__)

  register :Gandalf,     File.join(DEFAULT_TEMPLATE_PATH, 'gandalf.txt')
  register :Alien,       File.join(DEFAULT_TEMPLATE_PATH, 'alien.txt')
  register :CatInTheHat, File.join(DEFAULT_TEMPLATE_PATH, 'cat.txt')
end
