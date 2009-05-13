class CurrenciesQuote < ActiveRecord::Base
	validates_uniqueness_of :symbol, :scope => :found_date
	
	def self.currency_short
		find(:all, :select => "distinct(symbol)").map(&:symbol).sort
	end
	@today = Date.today
	
	def self.update_database
		@conversion_date = start_date
		while @conversion_date < @today 
			begin
				make_new_row(@conversion_date)
			rescue ArgumentError => e			  
				flash[:notice] = e.message
			end
			@conversion_date += 1
		end 
		begin 
			make_new_row(@today)
		rescue ArgumentError => e	
			flash[:notice] = e.message
		end
	end
	
	protected
	
	def self.start_date
		@start_date = CurrenciesQuote.last.nil? ? Date.new(2002,1,2) : CurrenciesQuote.last.found_date
	end
	
	def self.make_new_row(date)
		@desired_value = Bank::money(date) #zwraca tablicę złożoną z par: skrót - wartość, dla danej daty
		@desired_value.each do |concret|
			@currencies_quote = CurrenciesQuote.new
			@currencies_quote.symbol = concret[0]
			@currencies_quote.found_date = date
			@currencies_quote.value = concret[1]
			@currencies_quote.save
		end
	end
	
end
