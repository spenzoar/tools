import os
import sys
import glob
import time
import subprocess
import uuid

#================================================
#return chunklist part of the filename
def GetChunklist(name):

	#parse VLC generated vs python generated files differently
	if name.find("vlc-record") == -1:
		chunklist = "0"
	else:
		start_index = name.find("w") + 1
		stop_index  = name.find("b") - 1
		chunklist = name[start_index:stop_index]
	return chunklist

#================================================
#return timestamp part of the filename
def GetTimestamp(name):

	#parse VLC generated vs python generated files differently
	if name.find("vlc-record") == -1:
		start_index = 0
		stop_index  = name.find("_") - 1
	else:
		start_index = name.find("d-") + 2
		stop_index = name.find("-c") - 2

	timestamp =  name[start_index:stop_index]
	return timestamp


#================================================
def Combine(files, ext):

	rc = 0

	#keep empty for autoname based on date
	output_file_name = ""
	output_file_uuid = str(uuid.uuid4())

	file_list_name = "temp.txt"
	file_list = open(file_list_name, "a", encoding="utf8")
	file_names = []

	for file in files:
			
			if(len(output_file_name) == 0):
				#timestamp = os.path.getctime(file)
				#output_file_name = time.strftime("%Y-%m-%d", time.localtime(timestamp))
				output_file_name = GetTimestamp(file)
			
			#seems to work better to ffmpeg each file before combining them
			#ffmpeg -i "concat:%IN_FILE_5%.%EXT%" -c copy %IN_FILE_5%-temp.%EXT%
			pre, e = os.path.splitext(file)
			temp_name = pre + "-temp." + ext
			subprocess.call([
				"ffmpeg",
				"-i",
				file,
				"-c",
				"copy",
				temp_name,
			])
			
			file_list.write("file " + temp_name + "\n")
			file_names.append(temp_name)

	#done writing the list to file. close before passing to ffmpeg.	
	file_list.close()

	#combine the file into single file
	subprocess.call([
				"ffmpeg",
				"-f", "concat",
				"-safe", "0",
				"-i", file_list_name,
				"-c", "copy",
				output_file_name + "__" + output_file_uuid + "." + ext,
			])

	#cleanup
	os.remove("temp.txt")
	for name in file_names:
		os.remove(name)

	#delete when know combine succeeded
	move_dir = "processed"
	if not os.path.exists(move_dir):
		os.mkdir(move_dir)
	for file in files:
		os.rename(file, move_dir + "/" + file)

	return rc

#================================================
def SortByCreated(files):
	files.sort(key=lambda x: os.path.getctime(x))

#================================================
def SortByModified(files):
	files.sort(key=lambda x: os.path.getmtime(x))

#================================================
def SortByName(files):
	files.sort(key=lambda x: os.path.splitext(x)[0])

#================================================
def DictionaryByChunklist(files):

	file_dict = dict()

	for file in files:
		#convert chunklist to number and use as key for the dictionary
		chunk_num = int(GetChunklist(file))
		if chunk_num in file_dict:
			file_dict[chunk_num].append(file)
		else:
			file_dict[chunk_num] = [file]

	return file_dict

#================================================
def main():

	rc = 0

	#ffmpeg supports several video file extensions
	ext = "mp4"
	files = glob.glob("*." + ext)

	#change depending on how video sequence should be determined. VLC prepends sortable timestamp.
	SortByName(files)
	rc = Combine(files, ext)

	#create several output files based on matching chunklists
	#file_dict = DictionaryByChunklist(files)
	#for key in file_dict:
		#print(key)
		#for file in file_dict[key]:
			#print("\t" + file)

		#rc = Combine(file_dict[key], ext)

		#print(rc)

	return rc

#================================================
if __name__ == "__main__":
	try:
		rc = main()
		sys.exit(rc)
	except:
		sys.exit(69)