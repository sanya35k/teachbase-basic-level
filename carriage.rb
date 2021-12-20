# frozen_string_literal: true

require_relative 'company'
require_relative 'validation'

class Carriage
  include Company
  include Validation

  validate :company_name, :presence

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
