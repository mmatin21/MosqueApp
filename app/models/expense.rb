class Expense < ApplicationRecord
  belongs_to :masjid
  
  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0}
  validates :date, presence: true
  
  scope :by_year, ->(year) { where('extract(year from date) = ?', year) }
  scope :by_year_and_month, ->(year, month) { where('extract(year from date) = ? AND extract(month from date) = ?', year, month) }

  def self.grouped_by_year
    group("extract(year from date)").sum(:amount)
  end

  # Group expenses by year and month
  def self.grouped_by_year_and_month
    group("extract(year from date)", "extract(month from date)").sum(:amount)
  end

  
  def self.group_by_year_to_date
    start_date = Time.current.beginning_of_year
    end_date = Time.current.end_of_day

    # Group donations by month and sum the amount for each month within the current year
    self.where(date: start_date..end_date)
        .group("TO_CHAR(date, 'MM/YYYY')")
        .sum(:amount)
  end

  def self.group_by_last_three_months
    start_date = 2.months.ago.beginning_of_month
    end_date = Time.current.end_of_month

    # Group donations by month and sum the amount for each month, formatting as 'MM/DD/YYYY'
    self.where(date: start_date..end_date)
        .group("TO_CHAR(date, 'MM/YYYY')")
        .sum(:amount)
  end

  def self.ransackable_attributes(auth_object = nil) 
    ["name", "date", "amount"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

end
