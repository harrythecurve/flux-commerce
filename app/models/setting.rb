class Setting < ApplicationRecord
  def self.get_value(name)
    Setting.find_by(name: name).value
  end

  def self.set_value(name, value)
    setting = Setting.find_or_create_by(name: name)
    setting.update(value: value)
  end
end
