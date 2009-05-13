class CurrenciesController < ApplicationController
	helper :sparklines
	def index
		#@currencies_quotes = CurrenciesQuote.all #do widoku pobiera wszystkie rekordy z bazy
		@currency_short = CurrenciesQuote.currency_short #pobiera listę dostępnych skrótów walut
		@today = Date.today
	  @selected_day = params[:date].blank? ? @today : choosen_date(params[:date])
		if params[:date]
			@date = choosen_date(params[:date])
			@currency = params[:currency] 
			@desired_value = current_quote(@currency, @date).nil? ? "Change your request" : current_quote(@currency, @date).value
 		end
 		if params[:graph_date]
	 		@table = []
			@start_date = first_graph_day
			while @start_date < last_graph_day
				if cq = current_quote(params[:shortcut], @start_date)
					@table << cq.value
				end
				@start_date += 1
			end
		end
	end
	
	protected
	
	def choosen_date(params)
		Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
	end
	
	def current_quote(currency, date)
		CurrenciesQuote.find_by_symbol_and_found_date(currency, date)
	end
	def first_graph_day
		Date.new(params[:graph_date][:year].to_i, params[:graph_date][:month].to_i, 1)
	end 
	def last_graph_day
		Date.new(params[:graph_date][:year].to_i, params[:graph_date][:month].to_i + 1, 1)
	end 
	
end
