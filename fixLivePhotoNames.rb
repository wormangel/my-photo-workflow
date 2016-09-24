# first get the dupes using DupeGuru (compare Camera Uploads folder to the one imported from iPhone), export the results to CSV

require 'CSV'

path = "./livePhotos"

ls = CSV.read('dupes.csv', :headers => true)

ls.group_by{|s| s[0]}.each do |item|
  oldFilenamePicture = item[1][0]["Filename"]
  newFilenamePicture = item[1][1]["Filename"]
  oldFilenameVideo = oldFilenamePicture.sub(/JPG/i, 'MOV')
  newFilanameVideo = newFilenamePicture.sub(/jpg/i, 'MOV')
  File.rename(path + "/" + oldFilenamePicture, path + "/" + newFilenamePicture)
  File.rename(path + "/" + oldFilenameVideo, path + "/" + newFilanameVideo)
end
