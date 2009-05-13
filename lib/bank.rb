require 'rubygems'
require 'hpricot'
require 'open-uri'

module Bank

	def convert_date(date) #konwertuje daty i sprawdza czy rok nie przekroczony
	
			if (date.year < 2002) || (date.year > Time.now.year) || ((date.year == Time.now.year) && (date.month > Time.now.month)) || ((date.year == Time.now.year) && (date.month == Time.now.month) && (date.day > Time.now.day))
				raise(ArgumentError, "Valid year is betwen 2002 - #{Time.now.year}")
			else
				if date.month.to_i < 10
					if date.day.to_i < 10
						date = "#{date.year}0#{date.month}0#{date.day}"	
					else
						date = "#{date.year}0#{date.month}#{date.day}"
					end
				else date.day.to_i < 10	
					date = "#{date.year}0#{date.month}0#{date.day}"
				end
				date[2..-1]
			end  
	end

	def valutes(address)  
		v = nil
		tab = []
		doc = Hpricot(open("http://nbp.pl/kursy/#{address}"))
		doc.search("pozycja").each do |currency|
			tab << [(currency/"kod_waluty").inner_html, (currency/"kurs_sredni").inner_html]
		end
		tab
	end

	def codes
		tab = []
		doc = Hpricot(open("http://nbp.pl/kursy/xml/a001z090102.xml"))
		doc.search("pozycja").each do |currency|
			tab << "#{(currency/"kod_waluty").inner_html}"
		end
		tab
	end
	
	def is_there(date)
	 	@s = @index.select {|item| item.include?(date)}
		@s.size #zwraca liczbę komórek z odpowiednim plikiem (mogą być : 4-y)
	end

	def xml_index #zwraca indexzawierający stron z walutami 
		@index = [] #zawiera indeksy stron z walutami 
		open("http://nbp.pl/kursy/xml/dir.txt") do |line|
			while (b = line.gets)
				@index << b
			end
		end
		@index
	end

	def money(date)
		xml_index
		@fixed = (convert_date(date)) #zwraca date w formacie 080129 /rok miesiac dzien
		@fixed = @fixed.to_i
		if is_there(@fixed.to_s) == 0
			raise(ArgumentError,"there's no date")  #OBBSŁUŻYĆ TRZEBA JESZCZE TEN PRZYPADEK
		else
			valutes("xml/#{@s[2].chop}\.xml")  #bierzemy tylko najbardziej znane waluty (z pośród 4opcji - 2ga)
		end
	end

	module_function:money, :is_there, :valutes, :convert_date, :codes, :xml_index
end



