# frozen_string_literal: true

require_relative 'company'

class Carriage
  include Company

  def initialize(company_name)
    @company_name = company_name
  end

  def type
    raise 'For future overriding...'
  end

  def info
    raise 'For future overriding...'
  end
end
