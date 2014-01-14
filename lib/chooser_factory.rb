require_relative '../lib/normal_chooser'
require_relative '../lib/smart_chooser'
require_relative '../lib/smarter_chooser'

class ChooserFactory
  def self.chooser(choose_type)
    case choose_type
      when 'normal'
        return NormalChooser.new
      when 'smart'
        return SmartChooser.new
      when 'smarter'
        return SmarterChooser.new
      else
        return nil
    end
  end
end