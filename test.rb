require "google_drive"
session = GoogleDrive::Session.from_config("config.json")

ws = session.spreadsheet_by_key("18UrlX3LS7nw__konCtFRygXWFeJ3ZMahVDoNfSUGA6o").worksheets[0]

p ws[2, 1]

ws[2, 1] = "foo"
ws[2, 2] = "bar"
ws.save

ws.reload
