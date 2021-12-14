# frozen_string_literal: true

require_relative 'company'

class Carriage
  include Company

  def type
    raise 'For future overriding...'
  end

  def info
    raise 'For future overriding...'
  end
end
