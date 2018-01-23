require 'rubygems'
require 'nokogiri'
require 'open-uri'
require "google_drive"
$array = []
$email = []

def gets_the_email_of_townhall_from_its_webpage(url)
	page = Nokogiri::HTML(open(url))
	$is += 1
	emails = page.css("tr td.style27 p.Style22 font")
	emails.each do |i|
		if i.text.include?"@"
			$email[$is] = i.text
			return i.text
		end
	end
end

def get_all_the_urls_of_valdoise_townhalls
		town_hash = Hash.new
		page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
		$is = 1
		urls = page.css("a.lientxt")
		urls.each do |url|
			clean_url = "http://annuaire-des-mairies.com"+url['href'][1..url['href'].length]
			town_hash[url.text] = gets_the_email_of_townhall_from_its_webpage(clean_url)
			$array[$is] = url.text
		end
		return town_hash
end
print get_all_the_urls_of_valdoise_townhalls


session = GoogleDrive::Session.from_config("config.json")
ws = session.spreadsheet_by_key("1G87KoQyR2YEo7sQLe32lbY0_ezutxxyJX4sEtiMQAFU").worksheets[0]
p ws[2, 1]

puts $email
puts $array

for j in (1..$array.length-1) do
  ws[j, 1] = $array[j]
   ws[j, 2] = $email[j]
   ws.save
 end
