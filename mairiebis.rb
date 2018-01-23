require 'nokogiri'
require 'open-uri'
require "google_drive"
$array = []
$email = []

def get_all_the_urls_of_val_doise_townhalls (web_list)
page = Nokogiri::HTML(open(web_list))
$is = 1
page.css("a.lientxt").each do |note|
note['href'] = note['href'][1..-1]
web_page = "http://annuaire-des-mairies.com" + note['href']
$array[$is] = note.text

get_the_email_of_a_townhal_from_its_webpage(web_page)
end
end

def get_the_email_of_a_townhal_from_its_webpage (web_page)
doc = Nokogiri::HTML(open(web_page))
    doc.xpath('//p[@class = "Style22"]').each do |node|
   if node.text.include?("@")
            $email[$is] = node.text
     $is += 1
     node.text
    end
end
end

get_all_the_urls_of_val_doise_townhalls("http://annuaire-des-mairies.com/val-d-oise")

session = GoogleDrive::Session.from_config("config.json")
ws = session.spreadsheet_by_key("18UrlX3LS7nw__konCtFRygXWFeJ3ZMahVDoNfSUGA6o").worksheets[0]
p ws[2, 1]

puts $email
puts $array

for j in (1..$array.length-1) do
  ws[j, 1] = $array[j]
   ws[j, 2] = $email[j]
   ws.save
 end
